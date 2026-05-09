from django import template
from django.db.models import Sum, F

import datetime
from products.functions import get_all_stock, ProductVariant

register = template.Library()


@register.simple_tag
def get_total_stock(product):
    total_stock = get_all_stock(product)

    return total_stock


@register.simple_tag
def product_variant_data(instance, request):
    from_date = request.GET.get('from_date')
    to_date = request.GET.get('to_date')
    from_date = datetime.datetime.strptime(from_date, '%Y-%m-%d')
    to_date = datetime.datetime.strptime(to_date, '%Y-%m-%d')

    sale_items = instance.saleitem_set.filter(sale__is_deleted=False, sale__sale_date__date__gte=from_date, sale__sale_date__date__lte=to_date)
    order_items = instance.orderitem_set.filter(order__order_status='30', order__date_added__date__gte=from_date, order__date_added__date__lte=to_date)

    sale_items = sale_items.annotate(
        my_quantity = F('quantity'),
        my_total = F('total'),
        my_price = F('amount'),
        my_cost = F('product_variant__cost'),
        my_total_cost = F('my_cost') * F('quantity'),
        my_profit = F('total') - F('my_total_cost'),
    )
    order_items = order_items.annotate(
        my_quantity = F('qty'),
        my_total = F('price'),
        my_price = F('price') / F('qty'),
        my_cost = F('product_variant__cost'),
        my_total_cost = F('my_cost') * F('qty'),
        my_profit = F('price') - F('my_total_cost'),
    )

    sales_data = sale_items.aggregate(
        total_amount = Sum('my_total'),
        quantity = Sum('my_quantity'),
        total_cost = Sum('my_total_cost'),
        profit = Sum('my_profit'),
    )

    order_data = order_items.aggregate(
        quantity = Sum('my_quantity'),
        total_amount = Sum('my_total'),
        total_cost = Sum('my_total_cost'),
        profit = Sum('my_profit'),
    )

    data = {
        'cost': instance.cost,
        'price': instance.retail_price,
        'quantity': (sales_data.get('quantity') or 0) + (order_data.get('quantity') or 0),
        'total_amount': (sales_data.get('total_amount') or 0) + (order_data.get('total_amount') or 0),
        'total_cost': (sales_data.get('total_cost') or 0) + (order_data.get('total_cost') or 0),
        'profit': (sales_data.get('profit') or 0) + (order_data.get('profit') or 0),
    }
    return data


@register.simple_tag
def get_instance(instances, pk):
    return instances.get(pk=pk)
