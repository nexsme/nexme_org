from customers.models import Customer
from suppliers.models import Supplier
from delivery_agent.models import DeliveryAgents

from django.urls import reverse
from django.template import Library
from django.template.defaultfilters import stringfilter


register = Library()


@register.filter
def check_default(value):
    result = value
    if value == "default":
        result = "-"
    return result


@register.filter
@stringfilter
def underscore_smallletter(value):
    value = value.replace(" ", "_")
    return value


@register.filter
def to_fixed_two(value):
    return "{:10.2f}".format(value)


@register.filter
def tax_divide(value):
    return value / 2


@register.filter
def to_positive(value):
    return (value * -1)


@register.filter
def partition_horizontal(thelist):
    try:
        count = thelist.count()
        if count % 2 == 1:
            count += 1
        n = count / 2
        n = int(n)
        thelist = list(thelist)
    except (ValueError, TypeError):
        return [thelist]
    newlists = [list() for i in range(n)]
    for i, val in enumerate(thelist):
        newlists[i % n].append(val)
    return newlists


@register.simple_tag
def get_filtered_url(url):
    splitted = url.split("?")

    if len(splitted) > 1:
        return splitted[1]
    else:
        return ""


@register.simple_tag
def get_sub_ledger(instance):
    if not instance.sub_ledger:
        return [None, '']

    try:
        if instance.account_head.code == 'sundry_debtor_customer':
            ledger = Customer.objects.get(pk=instance.sub_ledger)
            url = reverse('customers:customer', kwargs={"pk": instance.sub_ledger})
            return [ledger, url]
        elif instance.account_head.code == 'sundry_creditor_supplier':
            ledger = Supplier.objects.get(pk=instance.sub_ledger)
            url = reverse('suppliers:supplier', kwargs={"pk": instance.sub_ledger})
            return [ledger, url]
        elif instance.account_head.code == 'sundry_creditor_delivery_agent':
            ledger = DeliveryAgents.objects.get(pk=instance.sub_ledger)
            url = reverse('delivery_agent:delivery_agent', kwargs={"pk": instance.sub_ledger})
            return [ledger, url]

    except Exception as e:
        print(f'\n\n\n\n\n{e}\n\n\n\n\n')

    return [None, '']

