import datetime
import random
import re
import requests
import decimal
import string

from django.utils import timezone

from products.models import Category


def generate_serializer_errors(args):
    message = ''
    for key, values in args.items():
        error_message = ""
        for value in values:
            error_message += value + ","
        error_message = error_message[:-1]

        message += "%s : %s |" % (key, error_message)
    return message[:-3]


def get_user_token(request, user_name, password):
    headers = {
        'Content-Type': 'application/json',
    }
    data = '{"username": "' + user_name + '", "password":"' + password + '"}'
    print(data, "--data")
    protocol = "http://"
    if request.is_secure():
        protocol = "https://"

    web_host = request.get_host()
    request_url = protocol + web_host + "/api/v1/auth/token/"

    print(request_url, "--------request_url")

    response = requests.post(request_url, headers=headers, data=data)
    print(response, "------response2")
    return (response)


def is_zone_exists(request):
    if 'zone' in request.session:
        return True
    else:
        return False

def get_zone(request):
    zone_session = request.session.get('zone', '')
    if zone_session:
        return zone_session

def get_shop_category_instances(product_instances):
   categories = product_instances.values_list('product__category',flat=True).distinct()
   category_instances = Category.objects.filter(pk__in=categories)

   return category_instances

def get_retail_price_of_product(request):
    """
    get retail price of a product from chosen zone, if zone is none the products retail price will added
    :param request:
    """
    pass


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
