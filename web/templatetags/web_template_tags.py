from django import template
from django.db.models import Sum
from django.shortcuts import get_object_or_404
from products.models import Category, SubCategory, ProductVariant

register = template.Library()

import decimal
import datetime
from users.models import *
from products.models import *
from general.models import *
from customers.models import Customer, CustomerAddress
from vendors.models import Vendor
from warehouses.models import Location
from orders.models import Orders
from web.models import ProductReturn, ProductReview


@register.filter
def check_wish(product):
    if Wishlistitem.objects.filter(product_variant=product).exists():
        return True
    else:
        return False


@register.simple_tag
def get_cart_count(product, user):
    if CartItem.objects.filter(product_variant__pk=product, customer__user=user,is_deleted=False).exists():
        cart_item_instance = CartItem.objects.get(product_variant__pk=product, customer__user=user,is_deleted=False)
        return cart_item_instance.qty
    else:
        return 1


@register.simple_tag
def get_pv(zone, category):
    products = Batch.objects.filter(
        is_deleted=False,
        warehouse__deliverable_location__in=[zone],
        product__category__pk=category,
        product_variant__is_default=True,
    )
    return products


@register.simple_tag
def is_stock(variant, zone):
    pk = variant.pk

    if not variant.is_special_variant:
        try:
            if zone:
                batch = Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant_id=pk)
            else:
                batch = Batch.objects.filter(is_deleted=False, product_variant_id=pk)
        except Exception as e:
            print('\n\n\n\n\n', e)
            return False
        total_stock = batch.aggregate(Sum('stock')).get('stock__sum', 0)

        if not total_stock or total_stock == 0:
            return False
        else:
            return True
    else:
        special_variant = variant.special_variant_added
        variants = special_variant.product_variant.all()
        all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0)
        stock_ok = True

        try:
            if zone:
                all_batches = all_batches.filter(warehouse__deliverable_location__in=[zone])
        except Exception as e:
            print('\n------------------error occured-----------\n\n', e, '\n\n')

        for variant_item in variants:
            if not all_batches.filter(product_variant_id=variant_item.pk).exists():
                stock_ok = False

        return stock_ok


@register.simple_tag
def get_booked_product_price(pk, zone):
    try:
        if zone:
            batch = Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant__pk=pk).order_by('-date_added').first()
        else:
            batch = Batch.objects.filter(is_deleted=False, product_variant__pk=pk).order_by('-date_added').first()
    except Exception as e:
        print('\n\n\n\n\n', e)
        batch = None

    if batch:
        return {
            "mrp": batch.mrp,
            "retail_price": batch.retail_price
        }
    else:
        product_variant = ProductVariant.objects.get(pk=pk)
        return {
            "mrp": product_variant.mrp,
            "retail_price": product_variant.retail_price
        }


@register.simple_tag
def get_product_by_id(pk):
    product = ProductVariant.objects.get(pk=pk)

    return product


@register.simple_tag
def get_product_price(pk, zone):
    try:
        if Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant__pk=pk).exists():
            batch = Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant__pk=pk).order_by('-date_added').first()

            if batch.product_variant.offer_price():
                return batch.product_variant.offer_price()
            else:
                return round(batch.retail_price, 2)
        else:
            prod_instance = ProductVariant.objects.get(is_deleted=False, pk=pk)
            if prod_instance.offer_price():
                prod_instance.offer_price()
            else:
                return round(prod_instance.retail_price, 2)

    except Exception as e:
        return e


@register.simple_tag
def get_name(user):
    try:
        customer = Customer.objects.get(user__username=user)
        return customer.name
    except Exception as e:
        return e


@register.simple_tag
def get_pro_pic(user):
    try:
        customer = Customer.objects.get(user__username=user)
        if customer.image:
            return customer.image.url
        else:
            return False
    except Exception as e:
        return e


@register.simple_tag
def get_customer_active_address(customer):
    address = None

    # check for default address
    if CustomerAddress.objects.filter(is_deleted=False, is_default=True, customer=customer).exists():
        address = CustomerAddress.objects.filter(is_deleted=False, is_default=True, customer=customer).first()
    # checking for adress if no active address found
    elif CustomerAddress.objects.filter(is_deleted=False, customer=customer).exists():
        address = CustomerAddress.objects.filter(is_deleted=False, customer=customer).first()

    return address


@register.simple_tag
def get_english_or_arabic(pk, field_type, language_code):
    if 'product' in field_type:
        product_instance = ProductVariant.objects.get(pk=pk)
        if product_instance.is_special_variant:
            description = product_instance.special_variant_added.description or product_instance.product.description
        else:
            description = product_instance.product.description

        if 'en' in language_code:
            data = {
                "name": product_instance.get_fullname(),
                "description": description,
            }
            return data

        elif 'ar' in language_code:
            if product_instance.is_special_variant:
                description = product_instance.special_variant_added.arabic_description or product_instance.special_variant_added.description or product_instance.product.arabic_description or product_instance.product.description
            else:
                description = product_instance.product.arabic_description or product_instance.product.description
            data = {
                "name": product_instance.get_arabic_name(),
                "description": description,
            }
            return data

    elif 'category' in field_type:
        category_instance = Category.objects.get(pk=pk)
        if 'en' in language_code:
            return category_instance.name

        elif 'ar' in language_code:
            return category_instance.arabic_name if category_instance.arabic_name else category_instance.name

    elif 'sub_category' in field_type:
        sub_category_instance = SubCategory.objects.get(pk=pk)
        if 'en' in language_code:
            return sub_category_instance.name

        elif 'ar' in language_code:
            return sub_category_instance.arabic_name if sub_category_instance.arabic_name else sub_category_instance.name

    elif 'shop' in field_type:
        shop_instance = Vendor.objects.get(pk=pk)
        if 'en' in language_code:
            return shop_instance.name

        elif 'ar' in language_code:
            return shop_instance.arabic_name if shop_instance.arabic_name else shop_instance.name

    elif 'type' in field_type:
        shop_instance = Vendor.objects.get(pk=pk)
        if 'en' in language_code:
            return shop_instance.vendor_type

        elif 'ar' in language_code:
            return shop_instance.type_arabic if shop_instance.type_arabic else shop_instance.vendor_type

    elif 'location' in field_type:
        if pk:
            print(pk)
            location_instance = Zone.objects.get(pk=pk)
            if 'en' in language_code:
                return location_instance.name

            elif 'ar' in language_code:
                return location_instance.arabic_name if location_instance.arabic_name else location_instance.name


@register.simple_tag
def is_return_button(product_variant, order_id):
    print("===>>>> ",product_variant)

    if ProductReturn.objects.filter(order_item__product_variant__id=product_variant, order_id=order_id).exists():
        return False
    product_variant_instances = ProductVariant.objects.get(pk=product_variant)

    returnable_duration_type = product_variant_instances.product.returnable_duration_type

    order_instances = Orders.objects.get(pk=order_id)
    if order_instances.order_status != '30':
        return False

    today_date = datetime.datetime.now(timezone.utc)
    today_date = today_date.replace(tzinfo=None)
    order_date = order_instances.date_added

    if 'day' in returnable_duration_type:
        day_duration = product_variant_instances.product.returnable_duration
        date_differnce = (today_date - order_date.replace(tzinfo=None)).days

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


@register.simple_tag
def check_product_review(product_variant, user):
    if ProductReview.objects.filter(product_variant_id=product_variant, creator=user).exists():
        return ProductReview.objects.filter(product_variant_id=product_variant, creator=user).first()
    return False


@register.simple_tag
def get_whole_sale_data(instance, zone):
    qty = instance.whole_sale_quantity

    if qty == 0:
        return {'is_available': False}

    all_batches = Batch.objects.filter(is_deleted=False, product_variant=instance)

    if all_batches.exists():
        if zone and all_batches.filter(warehouse__deliverable_location__in=[zone]).exists():
            batch = all_batches.filter(warehouse__deliverable_location__in=[zone]).order_by('-date_added').first()
            price = batch.whole_sale_price
            retail_price = batch.retail_price
        else:
            batch = all_batches.first()
            price = batch.whole_sale_price
            retail_price = batch.retail_price

    else:
        retail_price = instance.retail_price
        price = instance.whole_sale_price

    return {
        "is_availabe": True,
        "item_price": price,
        "minimum_quantity": qty,
        "total_rate": (price * qty),
        "total_discount": (retail_price * qty) - (price * qty),
    }
