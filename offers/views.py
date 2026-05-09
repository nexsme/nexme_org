import json
import datetime
from decimal import Decimal
from itertools import chain
from operator import attrgetter, itemgetter
# Third party libraries
from ast import literal_eval
from dal import autocomplete
# Django libraries
from django.shortcuts import render, get_object_or_404
from django.urls import reverse
from django.http.response import HttpResponse, HttpResponseRedirect,JsonResponse
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.core import serializers
from django.core.exceptions import ValidationError
from django.core.files.images import get_image_dimensions
from django.db.models import Q, F
from django.views.decorators.http import require_GET
from django.forms.widgets import Select, TextInput
from django.forms.formsets import formset_factory
from django.forms.models import inlineformset_factory
from django.views.decorators.http import require_POST
from django.template.loader import render_to_string
from django.db.models import Sum
# Local libraries
from main.decorators import role_required
from main.functions import generate_form_errors, get_auto_id, get_a_id, get_date_updated_request
from users.functions import get_warehouse
from offers.models import Offers, DealOfDay, VoucherCode
from offers.forms import OffersForm, DealOfDayForm, VoucherForm
from general.models import Batch


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_offer(request):
    if request.method == 'POST':
        form = OffersForm(request.POST, request.FILES)

        if form.is_valid():
            start_date = form.cleaned_data['start_time']
            end_date = form.cleaned_data['end_time']
            offer_percentage = form.cleaned_data['offer_percentage']

            if offer_percentage < 1 or offer_percentage >100:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please ensure offer percentage must be between 0 and 100"
                }
                return JsonResponse(response_data)
            if start_date < end_date:
                auto_id = get_auto_id(Offers)
                # create offer
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = auto_id

                if data.offer_type == 'product':
                    data.category = None
                    data.subcategory = None
                elif data.offer_type == 'category':
                    data.product = None
                    data.subcategory = None
                elif data.offer_type == 'sub_category':
                    data.product = None
                    data.category = None

                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Offer Created Successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('offers:offer', kwargs={'pk': data.pk})
                }

            else:

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "End date should be a date after Start date"
                }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return JsonResponse(response_data)

    else:
        form = OffersForm()
        context = {
            "title": "Create Offer ",
            "form": form,
            "url": reverse('offers:create_offer'),
        }

        return render(request, 'offers/offers/offer_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def offers(request):
    instances = Offers.objects.filter(is_deleted=False).order_by("date_added")
    title = "Offers"
    filter_data = {}

    query = request.GET.get("q")
    offer_date = request.GET.get('offer_date')
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Offers - %s" % query
        filter_data['query']=query

    if offer_date:
        offer_date = datetime.datetime.strptime(offer_date, '%Y-%m-%d').date()
        instances = instances.filter(start_time__date__lte=offer_date, end_time__date__gte=offer_date)

        filter_data['offer_date'] = offer_date


    context = {
        "instances": instances,
        'title': title,
        'filter_data': filter_data

    }
    return render(request, 'offers/offers/offers.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def offer(request, pk):
    instance = get_object_or_404(Offers.objects.filter(pk=pk, is_deleted=False))

    context = {
        "instance": instance,
        "title": "Offer : " + instance.title,
        "single_page": True,

    }
    return render(request, 'offers/offers/offer.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_offer(request, pk):
    instance = get_object_or_404(Offers.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = OffersForm(request.POST, request.FILES, instance=instance)
        if form.is_valid():
            start_date = form.cleaned_data.get('start_time')
            end_date = form.cleaned_data.get('end_time')
            offer_percentage = form.cleaned_data.get('offer_percentage')
            if offer_percentage < 1 or offer_percentage >100:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please ensure offer percentage must be between 0 and 100"
                }
                return JsonResponse(response_data)
            if start_date > end_date:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "End date should be a date after Start date"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            # update offer
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()

            if data.offer_type == 'product':
                data.category = None
                data.subcategory = None
            elif data.offer_type == 'category':
                data.product = None
                data.subcategory = None
            elif data.offer_type == 'sub_category':
                data.product = None
                data.category = None

            data.save()

            response_data = {
                    "status": "true",
                    "title": "Successfully Updated",
                    "message": "Offer Successfully Updated.",
                    "redirect": "true",
                    "redirect_url": reverse('offers:offer', kwargs={'pk': data.pk})
                }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": str(message)
            }



    else:
        initial = {
            'start_time': datetime.datetime.strftime(instance.start_time, '%Y-%m-%d'),
            'end_time': datetime.datetime.strftime(instance.end_time, '%Y-%m-%d')
        }
        form = OffersForm(instance=instance, initial=initial)

        context = {
            "form": form,
            "title": "Edit Offer : " + instance.title,
            "instance": instance,
            # "url": reverse('offers:edit_offer', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'offers/offers/offer_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_offer(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(Offers.objects.filter(pk=pk, is_deleted=False))

    Offers.objects.filter(pk=pk).update(is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Offer Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('offers:offers')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_selected_offers(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                Offers.objects.filter(pk=pk, is_deleted=False))
            Offers.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Offers Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('offers:offers')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_dealofday(request):
    if request.method == 'POST':
        form = DealOfDayForm(request.POST)

        if form.is_valid():
            auto_id = get_auto_id(DealOfDay)
            deal_date= form.cleaned_data['deal_date']
            offer_percentage = form.cleaned_data['offer_percentage']

            if offer_percentage < 1 or offer_percentage >100:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please ensure offer percentage must be between 0 and 100"
                }
                return JsonResponse(response_data)
            if deal_date < datetime.date.today():
                response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": "Previous dates are not allowed"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            # create DealOfDay

            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.auto_id = auto_id

            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Deal Of Day Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('offers:dealofday', kwargs={'pk': data.pk})
            }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = DealOfDayForm()
        context = {
            "title": "Create Deal Of Day ",
            "form": form,
            "url": reverse('offers:create_dealofday'),

        }
        return render(request, 'offers/dealofdays/dealofday_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def dealofdays(request):
    instances = DealOfDay.objects.filter(is_deleted=False)
    title = "Deal Of Day"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Deal Of Day - %s" % query

    context = {
        "instances": instances,
        'title': title,

    }
    return render(request, 'offers/dealofdays/dealofdays.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def dealofday(request, pk):
    instance = get_object_or_404(
        DealOfDay.objects.filter(pk=pk, is_deleted=False))
    context = {
        "instance": instance,
        "title": "DealOfDay : " + str(instance.offer_percentage),
        "single_page": True,
    }
    return render(request, 'offers/dealofdays/dealofday.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_dealofday(request, pk):
    instance = get_object_or_404(DealOfDay.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = DealOfDayForm(request.POST, instance=instance)

        if form.is_valid():
            # update dealofdays
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            offer_percentage = form.cleaned_data['offer_percentage']
            if offer_percentage < 1 or offer_percentage >100:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please ensure offer percentage must be between 0 and 100"
                }
                return JsonResponse(response_data)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Deal Of Day Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('offers:dealofday', kwargs={'pk': data.pk})
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = DealOfDayForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Deal Of Day ",
            "instance": instance,
            "url": reverse('offers:edit_dealofday', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'offers/dealofdays/dealofday_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_dealofday(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(
        DealOfDay.objects.filter(pk=pk, is_deleted=False))

    DealOfDay.objects.filter(pk=pk).update(is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Deal Of Day Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('offers:dealofdays')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_selected_dealofdays(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                DealOfDay.objects.filter(pk=pk, is_deleted=False))
            DealOfDay.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Offers Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('offers:dealofdays')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_voucher(request):
    if request.method == 'POST':
        form = VoucherForm(request.POST)

        if form.is_valid():
            customer = form.cleaned_data['customer']
            product = form.cleaned_data['product']
            product_variant = form.cleaned_data['product_variant']
            voucher_type = form.cleaned_data['voucher_type']
            minimum_order_amount = form.cleaned_data['minimum_order_amount']
            voucher_code = form.cleaned_data['voucher_code']

            if VoucherCode.objects.filter(voucher_code=voucher_code).exists():
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Voucher Code already exists"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            is_ok = True

            if minimum_order_amount <= 0:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Minimum order amount greater than 1"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')


            if voucher_type == 20 and not customer:
                is_ok = False
                error_message = "Please Select a customer from the choices"
            elif voucher_type == 30 and not product:
                is_ok = False
                error_message = "Please Select a product from the choices"
            elif voucher_type == 40 and not product_variant:
                is_ok = False
                error_message = "Please Select a product variant from the choices"

            if is_ok:
                # create timeslot
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = get_auto_id(VoucherCode)

                if voucher_type == 10:
                    data.product = None
                    data.customer = None

                elif voucher_type == 20: #customer
                    data.product = None

                elif voucher_type == 30: #product
                    data.customer = None
                    data.product_variant = None

                elif voucher_type == 40: #variant
                    data.product = None
                    data.customer = None

                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Voucher Code Created Successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('offers:voucher', kwargs={'pk': data.pk})
                }

            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = VoucherForm()
        context = {
            "title": "Create Voucher ",
            "form": form,
            "url": reverse('offers:create_voucher'),
        }

        return render(request, 'offers/voucher/voucher_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_voucher(request, pk):
    instance = get_object_or_404(VoucherCode, pk=pk)

    if request.method == 'POST':
        form = VoucherForm(request.POST, instance=instance)

        if form.is_valid():
            customer = form.cleaned_data['customer']
            product = form.cleaned_data['product']
            product_variant = form.cleaned_data['product_variant']
            voucher_type = form.cleaned_data['voucher_type']
            minimum_order_amount = form.cleaned_data['minimum_order_amount']
            start_time = form.cleaned_data['start_time']
            end_time = form.cleaned_data['end_time']
            percentage = form.cleaned_data['percentage']
            is_ok = True
            if minimum_order_amount <= 0:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Minimum order amount greater than 1"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            if start_time > end_time:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Start time befor End time"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            if percentage < 1 or percentage > 100:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Maximum discount percentage must between 1 and 100"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if voucher_type == 20 and not customer:
                is_ok = False
                error_message = "Please Select a customer from the choices"
            elif voucher_type == 30 and not product:
                is_ok = False
                error_message = "Please Select a product from the choices"
            elif voucher_type == 40 and not product_variant:
                is_ok = False
                error_message = "Please Select a product variant from the choices"

            if is_ok:
                data = form.save(commit=False)
                data.updater = request.user
                data.date_updated = datetime.datetime.now()

                if voucher_type == 10:
                    data.product = None
                    data.customer = None
                    data.product_variant = None

                elif voucher_type == 20: #customer
                    data.product = None
                    data.product_variant = None

                elif voucher_type == 30: #product
                    data.customer = None
                    data.product_variant = None

                elif voucher_type == 40: #variant
                    data.product = None
                    data.customer = None

                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Updated",
                    "message": "Voucher Code Successfully Updated.",
                    "redirect": "true",
                    "redirect_url": reverse('offers:voucher', kwargs={'pk': data.pk})
                }

            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = VoucherForm(instance=instance, initial={'start_time': instance.start_time.strftime('%Y-%m-%d'), 'end_time': instance.end_time.strftime('%Y-%m-%d')})

        context = {
            "form": form,
            "title": "Edit Voucher : " + instance.title,
            "edit":True,
            "instance": instance,
            "url": reverse('offers:edit_voucher', kwargs={'pk': instance.pk}),
            "redirect": True,
        }
        return render(request, 'offers/voucher/voucher_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def voucher(request, pk):
    instance = get_object_or_404(
        VoucherCode.objects.filter(pk=pk, is_deleted=False))
    context = {
        "instance": instance,
        "title": "Voucher Code : " + instance.voucher_code,
        "single_page": True,
    }

    return render(request, 'offers/voucher/voucher.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_voucher(request, pk):
    reason = request.GET.get('reason')
    # instance = get_object_or_404(VoucherCode.objects.filter(pk=pk, is_deleted=False))

    VoucherCode.objects.filter(pk=pk).update(is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Voucher Code Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('offers:vouchers')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def vouchers(request):
    instances = VoucherCode.objects.filter(is_deleted=False)
    title = "Voucher Codes"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) |
            Q(voucher_code__icontains=query)
        )
        title = "Voucher Codes - %s" % query

    context = {
        "instances": instances,
        'title': title,
    }
    return render(request, 'offers/voucher/vouchers.html', context)
