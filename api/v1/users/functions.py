import datetime
import decimal
from email.mime import application
import random
import string
from datetime import datetime, timezone
from decimal import Decimal

from cryptography.fernet import Fernet
from customers.models import Customer, CustomerAddress, PrivilegePoint
from django.conf import settings
from django.db.models import Q, Avg, Sum
from django.core.exceptions import ImproperlyConfigured
from finance.models import InvoicePrefix
from general.models import Batch, DeliveryCharge, ChargeSetting
from offers.models import Offers
from orders.models import OrderItem, Orders
from products.models import ProductVariant
from users.models import CartItem
from web.models import ProductReview, ProductReturn


def get_otp(size=4, chars=string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


def load_key():
    key = getattr(settings, "PASSWORD_ENCRYPTION_KEY", None)
    if key:
        return key
    else:
        raise ImproperlyConfigured("No configuration  found in your PASSWORD_ENCRYPTION_KEY setting.")


def encrypt_message(message):
    key = load_key()
    encoded_message = message.encode()
    f = Fernet(key)
    encrypted_message = f.encrypt(encoded_message)
    return (encrypted_message.decode("utf-8"))


def decrypt_message(encrypted_message):
    key = load_key()
    f = Fernet(key)
    decrypted_message = f.decrypt(encrypted_message.encode())
    return decrypted_message.decode()


def get_user(user):
    user = Customer.objects.get(user=user)
    return user


def get_cart_item_price(request):
    try:
        user = request.user
        zone_session = request.session.get('zone', '')
        today = datetime.now()

        cart = CartItem.objects.filter(customer__user=user, is_deleted=False)
        all_offers = Offers.objects.filter(is_deleted=False, start_time__lte=today, end_time__gte=today)

        total = 0
        for i in cart:
            offer = None

            if all_offers.filter(product_variant=i.product_variant).exists():
                offer = all_offers.filter(product_variant=i.product_variant).order_by('offer_percentage').last()

            elif all_offers.filter(category=i.product_variant.product.category).exists():
                offer = all_offers.filter(category=i.product_variant.product.category).order_by('offer_percentage').last()

            elif all_offers.filter(subcategory=i.product_variant.product.subcategory).exists():
                offer = all_offers.filter(subcategory=i.product_variant.product.subcategory).order_by('offer_percentage').last()

            if offer:
                if Batch.objects.filter(is_deleted=False, product_variant=i.product_variant,warehouse__deliverable_location__in=[zone_session], expire_date__gt=today).exists():
                    batch_instance = Batch.objects.filter(is_deleted=False, product_variant=i.product_variant,warehouse__deliverable_location__in=[zone_session], expire_date__gt=today).order_by('-date_added').first()
                    offer_amount = batch_instance.retail_price - (batch_instance.retail_price * offer.offer_percentage / 100)
                    total = total + i.qty * offer_amount
                else:
                    offer_amount = i.product_variant.retail_price - (i.product_variant.retail_price * offer.offer_percentage / 100)
                    total = total + i.qty * offer_amount
            else:
                if i.product_variant.is_special_variant:
                    if i.product_variant.whole_sale_quantity > 0 and i.product_variant.whole_sale_quantity <= i.qty:
                        total = total + i.qty * i.product_variant.whole_sale_price
                    else:
                        total = total + i.qty * i.product_variant.retail_price

                else:
                    if Batch.objects.filter(is_deleted=False, product_variant=i.product_variant,warehouse__deliverable_location__in=[zone_session], expire_date__gt=today).exists():
                        batch_instance = Batch.objects.filter(is_deleted=False, product_variant=i.product_variant,warehouse__deliverable_location__in=[zone_session], expire_date__gt=today).order_by('-date_added').first()
                        if i.product_variant.whole_sale_quantity > 0 and i.product_variant.whole_sale_quantity <= i.qty:
                            total = total + i.qty * batch_instance.whole_sale_price
                        else:
                            total = total + i.qty * batch_instance.retail_price
                    else:
                        if i.product_variant.whole_sale_quantity > 0 and i.product_variant.whole_sale_quantity <= i.qty:
                            total = total + i.qty * i.product_variant.whole_sale_price
                        else:
                            total = total + i.qty * i.product_variant.retail_price

        return total
    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

        return str(e)


def get_privileged_points(request):
    try:
        customer_instance = Customer.objects.get(user=request.user)

        point = PrivilegePoint.objects.filter(is_deleted=False).first()
        value_of_point = point.value_of_point

        customer_available_points = customer_instance.current_privilege_points
        customer_available_points_to_cash = float(customer_available_points) * float(value_of_point)

        wallet_amount = float(point.value_of_point) * float(customer_available_points)

        # print("avail points", customer_available_points)
        # print("Current cash ",customer_available_points_to_cash)
        # print("Value Of Point",value_of_point)
        # print("wallet amount", wallet_amount)
        # print("Customer available points", customer_available_points)

        is_applied = False
        applied_value = 0
        applied_value_to_cash = 0

        if 'wallet' in request.session:
            is_applied = True
            applied_value = request.session.get('wallet', 0)
            if not applied_value:
                applied_value = 0
            applied_value_to_cash = float(applied_value) * float(value_of_point)

        response_data = {
            "points": str(value_of_point),
            "available_points": str(customer_available_points),
            "available_points_to_cash": str(customer_available_points_to_cash),
            # wallet balance is converted to cash amount
            "wallet_balance": str(round(wallet_amount, 2)),
            "is_applied": is_applied,
            "applied_value": applied_value,
            "applied_value_to_cash": applied_value_to_cash,
        }

    except Exception as e:
        response_data = {
            "message": "Something Went Wrong!",
            "error": str(e),
        }
    return response_data


def get_grand_total(item_price,delivery_charge, request):
    coupon_session_amt = 0
    wallet_session_amt = 0

    # del request.session['wallet']

    # print("The session value is ", request.session['wallet'])

    if 'coupon_amt' in request.session:
        print("inside coupon")
        coupon_session_amt = request.session.get('coupon_amt', 0)

    if 'wallet' in request.session:
        print("Inside wallet")
        wallet_session_amt = request.session.get('wallet', 0)

    print("wallet session amount==>", wallet_session_amt)
    if not coupon_session_amt:
        coupon_session_amt = 0
    if not wallet_session_amt:
        wallet_session_amt = 0

    # print(f"{coupon_session_amt} - wallet :-{wallet_session_amt} - {item_price} +. ")

    total = float(item_price) - float(coupon_session_amt) - float(wallet_session_amt)

    grand_total = float(total) + float(delivery_charge)

    return grand_total


def add_privilege_point(request, order):
    customer_instance = Customer.objects.get(user=request.user)
    point_instance = PrivilegePoint.objects.filter(is_deleted=False).first()

    online_order_points = point_instance.point_gained_online

    if order.total_amt >= point_instance.minimum_amount:
        points_gained = (Decimal(order.total_amt) // Decimal(point_instance.minimum_amount)) * online_order_points

        customer_instance.current_privilege_points += points_gained
        customer_instance.privilege_points += points_gained

        customer_instance.save()
        return True
    else:
        return False


def clear_cart(customer, order, request):
    instances = None
    zone = request.session.get('zone', '')

    if CartItem.objects.filter(customer=customer):
        instances = CartItem.objects.filter(customer=customer)

        for cart_item in instances:
            variant_item = cart_item.product_variant

            batches = Batch.objects.filter(product_variant__pk=variant_item.pk, is_deleted=False)

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

                if zone:
                    special_variant_batches = special_variant_batches.filter(warehouse__deliverable_location=zone)

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
        if 'coupon_amt' in request.session:
            del request.session['coupon_amt']
        if 'wallet' in request.session:
            del request.session['wallet']
        if 'coupon_id' in request.session:
            del request.session['coupon_id']

        # add_privilege_point(request, order)

        return True
    else:
        return False


def get_order_prefix():
    order_prefix = None
    if InvoicePrefix.objects.filter(is_active=True, is_deleted=False, financial_year__is_active=True).exists():
        prefix = InvoicePrefix.objects.filter(is_active=True, is_deleted=False, financial_year__is_active=True).first()
        prefix_actual_count = Orders.objects.filter(Q(order_id__icontains=prefix.order)).count()
        new_order_prefix_to_string = int(prefix_actual_count) + 1

        return f"{prefix.order}{new_order_prefix_to_string}"
    else:
        return f"NONE"


def update_current_rating(product_instance):
    average = ProductReview.objects.filter(product_variant=product_instance).aggregate(Avg('rating'))
    product_instance.current_rating = decimal.Decimal(average['rating__avg'])
    product_instance.save()
    print(average['rating__avg'])


def is_eligible_for_return(product_variant, order_id):
    # return True
    if not ProductReturn.objects.filter(order_item__product_variant__pk=product_variant, order__pk=order_id).exists():
        try:
            product_variant_instances = ProductVariant.objects.get(pk=product_variant)

            returnable_duration_type = product_variant_instances.product.returnable_duration_type

            order_instances = Orders.objects.get(pk=order_id)

            today_date = datetime.now().replace(tzinfo=None)
            order_date = order_instances.date_added.replace(tzinfo=None)

            if 'day' in returnable_duration_type:
                day_duration = product_variant_instances.product.returnable_duration
                date_differnce = (today_date - order_date).days

                print('\n\n')
                print('day ', product_variant_instances.product_id, '   ---')
                print('day_duration--------', day_duration)
                print('date_differnce------', date_differnce)
                print('\n\n')

                if date_differnce >= day_duration:
                    return False
                else:
                    return True

            elif 'hours' in returnable_duration_type:
                time_duration = product_variant_instances.product.returnable_duration
                seconds = (today_date - order_date.replace(tzinfo=None)).seconds
                # hours = seconds // 3600
                hours = decimal.Decimal(seconds // 3600)

                if hours >= time_duration:
                    return False
                else:
                    return True

        except Exception as e:
            print(e)
            return False
    else:
        return False


def get_delivery_charge(request, item_price):
    try:
        user = request.user
        zone_session = request.session.get('zone', '')
        addresses = CustomerAddress.objects.filter(customer__user=user, is_default = True)

        instance = CartItem.objects.filter(customer__user=user, is_deleted=False).first()

        to_zone = addresses.first().zone if addresses.exists() else zone_session
        delivery_charge = 0

        if to_zone:
            try:
                warehouse = instance.warehouse
                if DeliveryCharge.objects.filter(to_zone=to_zone,warehouse=warehouse).exists():
                    delivery_instance = DeliveryCharge.objects.get(to_zone=to_zone,warehouse=warehouse )
                    if delivery_instance:
                        delivery_charge = delivery_instance.normal_charge

                min_amount = ChargeSetting.objects.filter(warehouse=warehouse)
            except:
                vendor = instance.product_variant.product.vendor

                if DeliveryCharge.objects.filter(to_zone=to_zone,vendor=vendor ).exists():
                    delivery_instance = DeliveryCharge.objects.get(to_zone=to_zone,vendor=vendor )
                    if delivery_instance:
                        delivery_charge = delivery_instance.normal_charge

                min_amount = ChargeSetting.objects.filter(vendor=vendor)

            if min_amount.exists():
                amount = min_amount.first()
                applicable_total = amount.no_delivery_charge_amount
                max_delivery_charge = amount.no_free_delivery_amount

                if item_price >= applicable_total and max_delivery_charge >= delivery_charge:
                    delivery_charge = 0

        return delivery_charge

    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

        return str(e)


def get_express_charge(request):
    try:
        user = request.user
        zone_session = request.session.get('zone', '')
        addresses = CustomerAddress.objects.filter(customer__user=user, is_default = True)

        instance = CartItem.objects.filter(customer__user=user, is_deleted=False).first()
        warehouse = instance.warehouse

        to_zone = addresses.first().zone if addresses.exists() else zone_session

        if warehouse:
            if DeliveryCharge.objects.filter(to_zone=to_zone,warehouse=warehouse).exists():
                delivery_instance = DeliveryCharge.objects.get(to_zone=to_zone,warehouse=warehouse )
                if delivery_instance:
                    delivery_charge = delivery_instance.express_charge
                else:
                    delivery_charge= 0
            else:
                delivery_charge= 0
        else:
            vendor = instance.product_variant.product.vendor
            if DeliveryCharge.objects.filter(to_zone=to_zone,vendor=vendor ).exists():
                delivery_instance = DeliveryCharge.objects.get(to_zone=to_zone,vendor=vendor )
                if delivery_instance:
                    delivery_charge = delivery_instance.express_charge
                else:
                    delivery_charge= 0
            else:
                delivery_charge= 0

        return delivery_charge

    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

        return str(e)


def get_distributor_type(request):
    try:

        cart_items = CartItem.objects.filter(customer__user=request.user, is_deleted=False)
        if cart_items:

            warehouse_id = cart_items.first().warehouse_id

            if warehouse_id:
                return True
            else:
                return False
        else:
            return False
    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

        return str(e)


def get_return_prefix():
    return_prefix = None
    try:
        actual_count = ProductReturn.objects.filter(is_deleted = False).count()
        new_count = int(actual_count) + 1

        return_prefix = f"ONZRTN{new_count}"
    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

    return return_prefix