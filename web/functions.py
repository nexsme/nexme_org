import datetime
import decimal
from django.db.models import Q, Sum

from api.v1.users.functions import add_privilege_point
from customers.functions import update_privilege_point
from finance.models import InvoicePrefix
from general.models import Batch
from main.functions import get_auto_id
from orders.models import *
from products.models import ProductVariant
from products.functions import special_variant_stock
from users.models import CartItem
from web.models import ProductReturn
from offers.models import VoucherCode


def get_cart_total(request):
    try:
        zone_session = request.session.get('zone', '')
        today = datetime.datetime.now()

        cart_items = CartItem.objects.filter(customer__user=request.user, is_deleted=False)
        if cart_items.exists():

            variant_pks = cart_items.values_list('product_variant_id', flat=True)
            if zone_session:
                batches = Batch.objects.filter(is_deleted=False, product_variant_id__in=variant_pks, warehouse__deliverable_location__in=[zone_session], expire_date__gt=today)
            else:
                batches = Batch.objects.filter(is_deleted=False, product_variant_id__in=variant_pks, expire_date__gt=today)

            all_offers = Offers.objects.filter(is_deleted=False, start_time__lte=today, end_time__gte=today)

            total = 0
            for cart_item in cart_items:
                offer = None

                if all_offers.exists():
                    if all_offers.filter(product_variant=cart_item.product_variant).exists():
                        offer = all_offers.filter(product_variant=cart_item.product_variant).order_by('offer_percentage').last()

                    elif all_offers.filter(category=cart_item.product_variant.product.category).exists():
                        offer = all_offers.filter(category=cart_item.product_variant.product.category).order_by('offer_percentage').last()

                    elif all_offers.filter(subcategory=cart_item.product_variant.product.subcategory).exists():
                        offer = all_offers.filter(subcategory=cart_item.product_variant.product.subcategory).order_by('offer_percentage').last()

                if batches.filter(product_variant=cart_item.product_variant).exists():
                    batch_instance = batches.filter(product_variant=cart_item.product_variant).order_by('-date_added').first()
                    if offer:
                        offer_amount = batch_instance.retail_price - (batch_instance.retail_price * offer.offer_percentage / 100)
                        total = total + cart_item.qty * offer_amount
                    else:
                        if cart_item.product_variant.whole_sale_quantity > 0 and cart_item.product_variant.whole_sale_quantity <= cart_item.qty:
                            total = total + (cart_item.qty * batch_instance.whole_sale_price)
                        else:
                            total = total + (cart_item.qty * batch_instance.retail_price)
                else:
                    if offer:
                        offer_amount = cart_item.product_variant.retail_price - (cart_item.product_variant.retail_price * offer.offer_percentage / 100)
                        total = total + cart_item.qty * offer_amount
                    else:
                        if cart_item.product_variant.whole_sale_quantity > 0 and cart_item.product_variant.whole_sale_quantity <= cart_item.qty:
                            total = total + (cart_item.qty * cart_item.product_variant.whole_sale_price)
                        else:
                            total = total + (cart_item.qty * cart_item.product_variant.retail_price)
            print(total)

            return round(total, 2)
        else:
            return 0

    except Exception as e:
        print(e)

        return 0


def clear_cart(customer, order, zone_session, request):
    instances = None

    if CartItem.objects.filter(customer=customer):
        instances = CartItem.objects.filter(customer=customer)

        variant_pks = instances.values_list('product_variant_id', flat=True)
        if zone_session:
            all_batches = Batch.objects.filter(is_deleted=False, stock__gt=0, product_variant_id__in=variant_pks, warehouse__deliverable_location__in=[zone_session])
        else:
            all_batches = Batch.objects.filter(is_deleted=False, stock__gt=0, product_variant_id__in=variant_pks)

        for cart_item in instances:
            variant_item = cart_item.product_variant

            batches = all_batches.filter(product_variant__pk=variant_item.pk)

            if variant_item.is_special_variant:
                batch = None
            else:
                if order.warehouse and batches.filter(warehouse_id=order.warehouse_id).exists():
                    batch = batches.filter(warehouse_id=order.warehouse_id).first()
                else:
                    batch = batches.first()

            if variant_item.offer_price():
                item_price = variant_item.offer_price()
            else:
                if variant_item.is_special_variant:
                    item_price = variant_item.retail_price
                else:
                    if variant_item.whole_sale_quantity > 0 and variant_item.whole_sale_quantity <= cart_item.qty:
                        item_price = batch.whole_sale_price
                    else:
                        item_price = batch.retail_price

            OrderItem.objects.create(
                order = order,
                product_variant = variant_item,
                batch = batch,
                qty = cart_item.qty,
                price = item_price
            )

            # get and set batch stock and pk
            cart_item.delete()
            total_qty = cart_item.qty

            if variant_item.is_special_variant:
                special_variant = variant_item.special_variant_added
                variants = special_variant.product_variant.all()
                special_variant_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False).order_by('expire_date')

                if zone_session:
                    special_variant_batches = special_variant_batches.filter(warehouse__deliverable_location=zone_session)

                for variant_obj in variants:
                    variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                    total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                    if variant_stocks.filter(stock__gte=total_qty).exists():
                        variant_stock = variant_stocks.filter(stock__gte=total_qty).first().stock
                        pk = variant_stocks.filter(stock__gte=total_qty).first().pk
                    else:
                        variant_stock = 0

                    if variant_stock > total_qty:
                        Batch.objects.filter(pk=pk).update(stock=variant_stock - total_qty)

                    elif total_stock > total_qty:
                        for batch_item in variant_stocks:
                            if batch_item.stock >= total_qty:
                                batch_item.stock = batch_item.stock - total_qty
                                batch_item.save()
                                break
                            elif batch_item.stock < total_qty:
                                total_qty -= batch_item.stock
                                batch_item.stock = 0
                                batch_item.save()

                    else:
                        return False # usually won't happen

            else:
                total_stock = batches.aggregate(Sum('stock')).get('stock__sum')
                stock = batch.stock
                pk = batch.pk

                if stock > total_qty:
                    Batch.objects.filter(pk=pk).update(stock=stock - total_qty)

                elif total_stock > total_qty:
                    for batch_item in batches:
                        if batch_item.stock >= total_qty:
                            batch_item.stock = batch_item.stock - total_qty
                            batch_item.save()
                            break
                        elif batch_item.stock < total_qty:
                            total_qty -= batch_item.stock
                            batch_item.stock = 0
                            batch_item.save()

                else:
                    return False # usually won't happen
            print(variant_item.total_stock(),'    -current stock')

        # add_privilege_point(request, order)

        return True
    else:
        return False


def get_orginal_price(product_variant, request):
    zone_session = request.session.get('zone', '')
    today = datetime.datetime.now()

    if Batch.objects.filter(is_deleted=False, product_variant=product_variant, warehouse__deliverable_location__in=[zone_session],  product_variant__expire_date__gt=today).exists():
        batch = Batch.objects.filter(is_deleted=False, product_variant=product_variant, warehouse__deliverable_location__in=[zone_session],  product_variant__expire_date__gt=today).order_by('-date_added').first()
        return batch.retail_price
    else:
        if product_variant.retail_price:
            return product_variant.retail_price


def get_order_prefix():
    order_prefix = None
    if InvoicePrefix.objects.filter(is_active=True, is_deleted=False).exists():
        prefix = InvoicePrefix.objects.filter(is_active=True, is_deleted=False).first()
        prefix_actual_count = Orders.objects.filter(prefix=prefix).count()
        new_order_prefix_to_string = int(prefix_actual_count) + 1

        return f"{prefix.order}{new_order_prefix_to_string}"
    else:
        return f"NONE"


def get_shop_category_instances(product_instances):
    categories = product_instances.values_list('product__category', flat=True).distinct()
    category_instances = Category.objects.filter(pk__in=categories)

    return category_instances


def save_return(order_item, reason, reason_specification, request):
    order_item_instances = OrderItem.objects.get(pk=order_item)
    order_instances = order_item_instances.order

    if reason_specification == "":
        ProductReturn.objects.create(
            auto_id=get_auto_id(ProductReturn),
            creator=request.user,
            updater=request.user,
            order_item=order_item_instances,
            order=order_instances,
            reason_for_return=reason,
        )
    else:
        ProductReturn.objects.create(
            auto_id=get_auto_id(ProductReturn),
            creator=request.user,
            updater=request.user,
            order_item=order_item_instances,
            order=order_instances,
            reason_for_return=reason,
            return_specification=reason_specification,
        )


def is_eligible_for_cancel(order):
    success_count = 0
    fail_count = 0
    is_cancel = False

    order_item_instances = OrderItem.objects.filter(order=order)
    total_count = order_item_instances.count()
    product_variant_pk = order_item_instances.values_list('product_variant_id')

    product_variant_instances = ProductVariant.objects.filter(pk__in=product_variant_pk, is_admin_approved=True)

    for variant in product_variant_instances:
        cancellable_duration_type = variant.product.cancellable_duration_type
        today_date = datetime.datetime.now(timezone.utc)
        today_date = today_date.replace(tzinfo=None)
        order_date = order.date_added

        if 'day' in cancellable_duration_type:
            day_duration = variant.product.cancellable_duration
            date_differnce = (today_date - order_date.replace(tzinfo=None)).days

            if date_differnce >= day_duration:
                fail_count += 1
            else:
                success_count += 1

        elif 'hours' in cancellable_duration_type:
            time_duration = variant.product.cancellable_duration
            seconds = (today_date - order_date.replace(tzinfo=None)).seconds
            # hours = seconds // 3600
            hours = decimal.Decimal(seconds // 3600)

            if hours >= time_duration:
                fail_count += 1
            else:
                success_count += 1

    if total_count == success_count:
        is_cancel = True

    return is_cancel


def is_eligible_for_cancel_order_item(order_item):
    try:
        variant = order_item.product_variant
        cancellable_duration_type = variant.product.cancellable_duration_type
        today_date = datetime.datetime.now(timezone.utc)
        today_date = today_date.replace(tzinfo=None)
        order_date = order_item.order.date_added

        if 'day' in cancellable_duration_type:
            day_duration = variant.product.cancellable_duration
            date_difference = (today_date - order_date.replace(tzinfo=None)).days

            if date_difference >= day_duration:
                return False
            else:
                return True

        elif 'hours' in cancellable_duration_type:
            time_duration = variant.product.cancellable_duration
            seconds = (today_date - order_date.replace(tzinfo=None)).seconds
            hours = decimal.Decimal(seconds // 3600)

            if hours >= time_duration:
                return False
            else:
                return True

    except Exception as e:
        print(f"Error in is_eligible_for_cancel_order_item: {e}")
        return False


def get_mrp(product_variant, request):
    """
    get the mrp of a product
    :param product_variant:
    :param request:
    :return:
    """
    zone_session = request.session.get('zone', '')
    today = datetime.datetime.now()

    batch = Batch.objects.filter(is_deleted=False, product_variant=product_variant, warehouse__deliverable_location__in=[zone_session],  product_variant__expire_date__gt=today)
    if batch.exists():
        batch = batch.order_by('-date_added').first()
        return batch.mrp
    else:
        if product_variant.mrp:
            return product_variant.mrp


def get_queried_params(query, instances):
    if 'product' in query:
        return instances.filter(product_variant__isnull=False)
    elif 'brand' in query:
        return instances.filter(brand__isnull=False)
    elif 'category' in query:
        return instances.filter(category__isnull=False)


def check_stock_availability(request):
    not_available = []

    zone_session = request.session.get('zone', '')
    cart_items = CartItem.objects.filter(customer__user=request.user, is_deleted=False)

    product_ids = list(cart_items.values_list('product_variant_id', flat=True))
    warehouse_id = cart_items.first().warehouse_id
    error_message = ''
    if warehouse_id:
        batches = Batch.objects.filter(product_variant_id__in=product_ids, warehouse__deliverable_location__in=[zone_session], is_deleted=False, stock__gt=0)
        if not zone_session:
            zone_session = cart_items.first().product_variant.warehouse.deliverable_location.all().first()

        for item in cart_items:
            if item.product_variant.is_special_variant:
                stock = special_variant_stock(item.product_variant, zone_session)

                if stock > item.qty:
                    pass # stock available
                else:
                    not_available.append({
                        "id": item.id,
                        "stock": stock,
                        "qty": item.qty,
                        "product_id": item.product_variant_id,
                        "name": str(item.product_variant),
                    })
                    error_message += f"Not Enough Stock for {str(item.product_variant)}"

            else:
                stocks = batches.filter(product_variant=item.product_variant).order_by("expire_date")
                total_stock = stocks.aggregate(Sum('stock')).get('stock__sum')

                if not stocks.exists():
                    not_available.append({
                        "id": item.id,
                        "stock": 0,
                        "qty": item.qty,
                        "product_id": item.product_variant_id,
                        "name": str(item.product_variant),
                    })
                    error_message += f'{str(item.product_variant)} is out of stock'
                elif stocks.filter(stock__gte=item.qty):
                    pass # stock available
                elif total_stock < item.qty:
                    not_available.append({
                        "id": item.id,
                        "stock": total_stock,
                        "qty": item.qty,
                        "product_id": item.product_variant_id,
                        "name": str(item.product_variant),
                    })
                    error_message = f'{str(item.product_variant)} has only {int(total_stock)} in stock'

        if len(not_available) > 0:
            return False, not_available, error_message

        return True, warehouse_id, error_message
    else:
        vendor_id = cart_items.first().product_variant.product.vendor_id
        if not zone_session:
            zone_session = cart_items.first().product_variant.product.vendor.deliverable_location.all().first()

        batches = Batch.objects.filter(product_variant_id__in=product_ids, is_deleted=False, stock__gt=0)

        for item in cart_items:
            stocks = batches.filter(product_variant=item.product_variant).order_by("expire_date")
            total_stock = stocks.aggregate(Sum('stock')).get('stock__sum')

            if not stocks.exists():
                not_available.append({
                    "id": item.id,
                    "stock": 0,
                    "qty": item.qty,
                    "product_id": item.product_variant_id,
                    "name": str(item.product_variant)
                })
                error_message = f"{str(item.product_variant)} is out of stock"

            elif stocks.filter(stock__gte=item.qty):
                # stock available
                pass
            elif total_stock < item.qty:
                not_available.append({
                    "id": item.id,
                    "stock": total_stock,
                    "qty": item.qty,
                    "product_id": item.product_variant_id,
                    "name": str(item.product_variant)
                })
                error_message = f"{str(item.product_variant)} is out of stock"

        if len(not_available) > 0:
            return False, not_available, error_message

        return True, vendor_id, error_message


def is_voucher_available(pk, request):
    today = datetime.datetime.now()

    cart_instances = CartItem.objects.filter(customer__user=request.user, is_deleted=False)
    all_voucher_instances = VoucherCode.objects.filter(is_deleted=False, start_time__lte=today, end_time__gte=today)

    product_ids = cart_instances.values_list('product_variant__product_id', flat=True)
    variant_ids = cart_instances.values_list('product_variant_id', flat=True)

    voucher_instances = all_voucher_instances.filter(
        Q(voucher_type=10) | # applicable to all
        Q(voucher_type=20, customer__user=request.user) | # for specific customer
        Q(voucher_type=30, product_id__in=product_ids) | # for specific product
        Q(voucher_type=40, product_variant_id__in=variant_ids), # for specific variant
        is_expired = False
    ).exclude(Q(is_limited_once=True, used_users=request.user))

    return voucher_instances.filter(pk=pk).exists()
