import xlrd
import xlwt
import json
import datetime
import requests
from decimal import Decimal
from itertools import chain
from operator import attrgetter, itemgetter
# Third party libraries
from ast import literal_eval
from dal import autocomplete
# Django libraries
from django.shortcuts import render, get_object_or_404
from django.conf import settings as SETTINGS
from django.conf import settings
from django.urls import reverse
from django.db.models import Q, F, Sum
from django.core import serializers
from django.core.exceptions import ValidationError
from django.core.files.images import get_image_dimensions
from django.forms.models import inlineformset_factory
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.forms.widgets import Select, TextInput
from django.forms.formsets import formset_factory
from django.http.response import HttpResponse, HttpResponseRedirect
from django.template.loader import render_to_string
from django.views.decorators.http import require_GET, require_POST
from django.contrib.auth.decorators import login_required
# Local libraries
from main.decorators import role_required
from main.functions import generate_form_errors, get_auto_id, get_a_id, get_date_updated_request, get_or_create_location
from staffs.models import Staff
from users.forms import UserForm
from staffs.forms import StaffForm
from warehouses.models import Warehouse, Location, Zone
from warehouses.forms import *
from products.models import ProductVariant
from orders.models import Orders
from general.models import *

class WarehouseAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        items = Warehouse.objects.filter(is_deleted=False)

        warehouse_pks = []
        if Staff.objects.filter(user=self.request.user, warehouse__isnull=False).exists():
            warehouse_pks += Staff.objects.filter(user=self.request.user, warehouse__isnull=False).values_list('warehouse_id', flat=True)

        if Staff.objects.filter(user=self.request.user, staff_role="warehouse_manager").exists():
            warehouse_pks += items.filter(manager__user=self.request.user).values_list('id', flat=True)

        if warehouse_pks:
            items = items.filter(pk__in=warehouse_pks)

        if self.q:
            items = items.filter(
                Q(auto_id__istartswith=self.q) |
                Q(name__istartswith=self.q)
            )

        return items


class ToWarehouseAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        items = Warehouse.objects.filter(is_deleted=False)

        warehouse = self.forwarded.get('warehouse', None)
        if warehouse:
            items = items.exclude(pk=warehouse)

        if Staff.objects.filter(user=self.request.user, warehouse__isnull=False).exists():
            pk = Staff.objects.get(user=self.request.user, warehouse__isnull=False).warehouse.pk
            items = items.exclude(pk=pk)

        if self.q:
            items = items.filter(
                Q(auto_id__istartswith=self.q) |
                Q(name__istartswith=self.q)
            )

        return items


class LocationAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        items = Location.objects.filter(is_deleted=False)

        if self.q:
            items = items.filter(
                Q(auto_id__istartswith=self.q) |
                Q(name__istartswith=self.q)
            )

        return items



class ZoneAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        items = Zone.objects.all()

        if self.q:
            items = items.filter(
                Q(pk__istartswith=self.q) |
                Q(name__istartswith=self.q)|
                Q(municipality__istartswith=self.q)
            )

        return items


class WarehouseLocationAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        instances = Location.objects.filter(is_deleted=False)

        ''' this section of code is used for filtering locations that doesn't fall under any other warehouses.'''
        warehouses = Warehouse.objects.filter(is_deleted=False)
        items = Location.objects.none()

        for warehouse in warehouses:
            items |= warehouse.location.all()

        if items.exists():
            item_pks = items.values_list('pk', flat=True)
            instances = instances.exclude(pk__in=item_pks)
        ''' warehouse filter ends here.'''

        if self.q:
            instances = instances.filter(
                Q(auto_id__istartswith=self.q) |
                Q(name__istartswith=self.q)
            )

        return instances


@login_required
@role_required(['superadmin'])
def create_warehouse(request):
    if request.method == 'POST':
        form = WarehouseForm(request.POST)
        location_form = LocationForm(request.POST, request.FILES)

        if form.is_valid()  and location_form.is_valid():
            location_name = location_form.cleaned_data['location']
            latitude = location_form.cleaned_data['latitude']
            longitude = location_form.cleaned_data['longitude']

            location = get_or_create_location(request, location_form, location_name, latitude, longitude)

            auto_id = get_auto_id(Warehouse)
            # create warehouse
            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.location = location
            data.auto_id = auto_id
            data.save()

            locations = request.POST.getlist('deliverable_location')
            for item in locations:
                p = Zone.objects.get(pk=item)
                data.deliverable_location.add(p)

            staff = form.cleaned_data['manager']
            if staff:
                staff.warehouse = data
                staff.save()
            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Warehouse Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:set_locations', kwargs={'pk': data.pk})
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
        auto_id = get_auto_id(Staff)
        if auto_id < 10:
            staff_id = 'ONZ000%s' % (str(auto_id))
        elif auto_id < 100:
            staff_id = 'ONZ00%s' % (str(auto_id))
        elif auto_id < 1000:
            staff_id = 'ONZ0%s' % (str(auto_id))
        else:
            staff_id = 'ONZ%s' % (str(auto_id))

        staff_initial = {
            'staff_id': staff_id,
            'staff_role': 'warehouse_manager',
        }

        user_form = UserForm()
        staff_form = StaffForm(initial=staff_initial)
        form = WarehouseForm()
        location_form = LocationForm()

        context = {
            "title": "Create Warehouse ",
            "form": form,
            "location_form": location_form,
            "staff_form": staff_form,
            "user_form": user_form,
            "url": reverse('warehouses:create_warehouse'),
        }

        return render(request, 'warehouses/warehouse_entry.html', context)


@login_required
@role_required(['superadmin'])
def warehouses(request):
    instances = Warehouse.objects.filter(is_deleted=False)
    title = "Warehouse"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Brands - %s" % query
    print(instances)
    context = {
        "instances": instances,
        'title': title,

    }
    return render(request, 'warehouses/warehouses.html', context)


@login_required
@role_required(['superadmin'])
def warehouse(request, pk):
    instance = get_object_or_404(Warehouse.objects.filter(pk=pk, is_deleted=False))

    context = {
        "single_page": True,
        "instance": instance,
        "title": "Warehouse : " + instance.name,
        "locations" : instance.deliverable_location.all(),
        "no_delivery_locations" : instance.no_express_delivery.all()
    }
    return render(request, 'warehouses/warehouse.html', context)


@login_required
@role_required(['superadmin'])
def edit_warehouse(request, pk):
    instance = get_object_or_404(
        Warehouse.objects.filter(pk=pk, is_deleted=False))
    location= instance.location
    old_staff = instance.manager
    if old_staff:
        old_staff.warehouse = None
        old_staff.save()

    if request.method == 'POST':
        response_data = {}
        form = WarehouseForm(request.POST, instance=instance)
        location_form = LocationForm(request.POST, request.FILES,instance=location)
        if form.is_valid() and location_form.is_valid() :
            location_name = location_form.cleaned_data['location']
            latitude = location_form.cleaned_data['latitude']
            longitude = location_form.cleaned_data['longitude']

            location = get_or_create_location(request, location_form, location_name, latitude, longitude)


            # update warehouse
            data = form.save(commit=False)
            data.location = location
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            locations = request.POST.getlist('deliverable_location')
            instance.deliverable_location.clear()
            for item in locations:
                p = Zone.objects.get(pk=item)
                data.deliverable_location.add(p)

            staff = form.cleaned_data['manager']
            if staff:
                staff.warehouse = data
                staff.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Warehouse Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:warehouse', kwargs={'pk': data.pk})
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
        auto_id = get_auto_id(Staff)
        if auto_id < 10:
            staff_id = 'ONZ000%s' % (str(auto_id))
        elif auto_id < 100:
            staff_id = 'ONZ00%s' % (str(auto_id))
        elif auto_id < 1000:
            staff_id = 'ONZ0%s' % (str(auto_id))
        else:
            staff_id = 'ONZ%s' % (str(auto_id))

        staff_initial = {
            'staff_id': staff_id,
            'staff_role': 'warehouse_manager',
        }
        user_form = UserForm()
        staff_form = StaffForm(initial=staff_initial)
        form = WarehouseForm(instance=instance)
        location_form = LocationForm(instance=location)

        context = {
            "form": form,
            "location_form": location_form,
            "user_form": user_form,
            "staff_form": staff_form,
            "title": "Edit Warehouse : " + instance.name,
            "instance": instance,
            "url": reverse('warehouses:edit_warehouse', kwargs={'pk': instance.pk}),
            "redirect": True,

        }
        return render(request, 'warehouses/warehouse_entry.html', context)


@login_required
@role_required(['superadmin'])
def delete_warehouse(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(
        Warehouse.objects.filter(pk=pk, is_deleted=False))

    Warehouse.objects.filter(pk=pk).update(
        is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id),deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Warehouse Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('warehouses:warehouses')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin'])
def set_locations(request, pk):
    instance = get_object_or_404(Warehouse.objects.filter(pk=pk, is_deleted=False))
    deliverable_locations = Zone.objects.all()
    DISTRICTS = Zone.DISTRICTS
    selected_district = request.GET.get('district')
    query = request.GET.get('q')

    if query:
        deliverable_locations = Zone.objects.filter(
            Q(name__icontains=query) | Q(taluk__icontains=query) | Q(district__icontains=query) | Q(pincode__icontains=query)
        )

    # Filtering zones based on the selected district
    if selected_district:
        deliverable_locations = Zone.objects.filter(district=selected_district)

    if request.method == 'POST':
        location_pks = request.POST.getlist('deliverable_location')

        page = request.GET.get('page', 1)
        paginator = Paginator(deliverable_locations, 100)
        try:
            deliverable_locations = paginator.page(page)
        except PageNotAnInteger:
            deliverable_locations = paginator.page(1)
        except EmptyPage:
            deliverable_locations = paginator.page(paginator.num_pages)
        # instance.deliverable_location.clear()
        instance.deliverable_location.remove(*deliverable_locations)

        for item in location_pks:
            zone = Zone.objects.get(pk=item)
            instance.deliverable_location.add(zone)

        response_data = {
            "status": "true",
            "title": "Successfully Updated",
            "message": "Deliverable zones updated successfully.",
            "redirect": "true",
            "redirect_url": reverse('warehouses:warehouse', kwargs={'pk': instance.pk})
        }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        array_p = list(instance.deliverable_location.all().values_list('pk', flat=True))

        context = {
            "query": query,
            "district": selected_district,
            "is_edit": True,
            "array_p": array_p,
            'DISTRICTS': DISTRICTS,
            "instance": instance,
            "title": "Set Deliverable Locations" + instance.name,
            "url": reverse('warehouses:set_locations', kwargs={'pk': instance.pk}),
            "deliverable_locations": deliverable_locations,
        }
        return render(request, 'warehouses/set_locations.html', context)


@login_required
@role_required(['superadmin'])
def set_non_deliverable_locations(request, pk):
    instance = get_object_or_404(Warehouse, pk=pk)
    DISTRICTS = Zone.DISTRICTS
    deliverable_locations = instance.deliverable_location.all()

    selected_district = request.GET.get('district')
    query = request.GET.get('q')
    if query:
        deliverable_locations = deliverable_locations.filter(
            Q(name__icontains=query) | Q(taluk__icontains=query) | Q(district__icontains=query) | Q(pincode__icontains=query)
        )
    if request.method == 'POST':
        location_pks = request.POST.getlist('deliverable_location')

        page = request.GET.get('page', 1)
        paginator = Paginator(deliverable_locations, 100)

        try:
            deliverable_locations = paginator.page(page)
        except PageNotAnInteger:
            deliverable_locations = paginator.page(1)
        except EmptyPage:
            deliverable_locations = paginator.page(paginator.num_pages)

        # instance.no_express_delivery.clear()
        instance.no_express_delivery.remove(*deliverable_locations)


        for item in location_pks:
            zone = Zone.objects.get(pk=item)
            instance.no_express_delivery.add(zone)

        response_data = {
            "status": "true",
            "title": "Successfully Updated",
            "message": "Non-deliverable zones updated successfully.",
            "redirect": "true",
            "url": reverse('warehouses:set_non_deliverable_locations', kwargs={'pk': instance.pk}),
            "redirect_url": reverse('warehouses:warehouse', kwargs={'pk': instance.pk})
        }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        array_p = list(instance.no_express_delivery.all().values_list('pk', flat=True))


        context = {
            "query": query,
            "district": selected_district,
            "is_edit": True,
            "array_p": array_p,
            "instance": instance,
            "DISTRICTS": DISTRICTS,
            "title": "Zones not available for express delivery",
            "url": reverse('warehouses:set_non_deliverable_locations', kwargs={'pk': pk}),
            "deliverable_locations": deliverable_locations,
        }
        return render(request, 'warehouses/set_locations.html', context)


@login_required
@role_required(['superadmin'])
def delete_selected_warehouses(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                Warehouse.objects.filter(pk=pk, is_deleted=False))
            Warehouse.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Warehouse Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('warehouses:warehouses')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_warehouse_variant(request):
    pk = request.GET.get('id')

    if Warehouse.objects.filter(pk=pk, is_deleted=False,).exists():
        warehouse = Warehouse.objects.get(pk=pk)
        variants = ProductVariant.objects.filter(warehouse=warehouse, is_admin_approved=True, is_deleted=False)
        variants_arr = []
        results = []
        for i in variants:
            if i.product.brand:
                name = str(i.product.brand)+str('-') + str(i.product.name)+str('-')+str(i.title)
            else:
                name = str(i.product.name)+str('-')+str(i.title)
            dic = {
                'id': str(i.id),
                'name': name,
            }
            variants_arr.append(dic)
        response_data = {
            "status": 'true',
            "variants": variants_arr,

        }
    else:
        response_data = {
            "status": "false",
            "message": "Warehouse is not exists."
        }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin'])
def create_location(request):

    if request.method == 'POST':
        form = LocationForm(request.POST)

        if form.is_valid():

            auto_id = get_auto_id(Warehouse)

            # create location

            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.auto_id = auto_id

            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Warehouse Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:warehouse', kwargs={'pk': data.pk})
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
        form = LocationForm()
        context = {
            "title": "Create Location ",
            "form": form,
            "url": reverse('warehouses:create_location'),


        }
        return render(request, 'warehouses/location_entry.html', context)


@login_required
@role_required(['superadmin'])
def locations(request):

    instances = Location.objects.filter(is_deleted=False)
    title = "Location"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Location - %s" % query

    context = {
        "instances": instances,
        'title': title,

    }
    return render(request, 'warehouses/locations.html', context)


@login_required
@role_required(['superadmin'])
def location(request, pk):
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))
    context = {
        "instance": instance,
        "title": "Location : " + instance.name,
        "single_page": True,

    }
    return render(request, 'warehouses/location.html', context)


@login_required
@role_required(['superadmin'])
def edit_location(request, pk):
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = LocationForm(request.POST, instance=instance)

        if form.is_valid():

            # update stock location
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Warehouse Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:location', kwargs={'pk': data.pk})
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
        form = LocationForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Location : " + instance.name,
            "instance": instance,
            "url": reverse('warehouses:edit_location', kwargs={'pk': instance.pk}),
            "redirect": True,

        }
        return render(request, 'warehouses/location_entry.html', context)


@login_required
@role_required(['superadmin'])
def delete_location(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))

    Location.objects.filter(pk=pk).update(
        is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id),deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Location Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('warehouses:locations')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin'])
def delete_selected_locations(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                Location.objects.filter(pk=pk, is_deleted=False))
            Location.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Location Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('warehouses:locations')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin'])
def create_location(request):

    if request.method == 'POST':
        form = LocationForm(request.POST)

        if form.is_valid():

            name = form.cleaned_data['name']
            pincode = form.cleaned_data['pincode']

            latitude = None
            longitude = None

            baseurl_1 = f"https://api.postalpincode.in/pincode/{pincode}"
            baseurl_2 = f"https://maps.googleapis.com/maps/api/geocode/json?address={pincode}&key={SETTINGS.PLACES_MAPS_API_KEY}"

            postofficeapi_response = requests.get(baseurl_1).json()
            googleapi_response = requests.get(baseurl_2).json()

            if postofficeapi_response[0]["Status"] == 'Success' and googleapi_response['status'] == 'OK':

                if 'PostOffice' in postofficeapi_response[0] and 'postal_code' in googleapi_response['results'][0][
                    'types']:
                    for post_offices in postofficeapi_response[0]['PostOffice']:
                        response = post_offices
            else:
                response = False

            latitude = googleapi_response['results'][0]['geometry']['location']['lat']
            longitude = googleapi_response['results'][0]['geometry']['location']['lng']

            auto_id = get_auto_id(Location)

            # create location
            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.latitude = latitude
            data.longitude = longitude
            data.auto_id = auto_id

            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Location Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:location', kwargs={'pk': data.pk})
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
        form = LocationForm()
        context = {
            "title": "Create Location ",
            "form": form,
            "url": reverse('warehouses:create_location'),
            "location": True,
        }
        return render(request, 'warehouses/location_new_entry.html', context)



@login_required
@role_required(['superadmin'])
def locations(request):

    instances = Location.objects.filter(is_deleted=False)
    title = "Location"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Location - %s" % query

    context = {
        "instances": instances,
        'title': title,
    }

    return render(request, 'warehouses/locations.html', context)


@login_required
@role_required(['superadmin'])
def location(request, pk):
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))
    context = {
        "instance": instance,
        "title": "Location : " ,
        "single_page": True,

    }
    return render(request, 'warehouses/location.html', context)


@login_required
@role_required(['superadmin'])
def edit_location(request, pk):
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = LocationForm(request.POST, instance=instance)

        if form.is_valid():

            name = form.cleaned_data['name']
            pincode = form.cleaned_data['pincode']

            latitude = None
            longitude = None

            baseurl_1 = f"https://api.postalpincode.in/pincode/{pincode}"
            baseurl_2 = f"https://maps.googleapis.com/maps/api/geocode/json?address={pincode}&key={SETTINGS.PLACES_MAPS_API_KEY}"

            postofficeapi_response = requests.get(baseurl_1).json()
            googleapi_response = requests.get(baseurl_2).json()

            if postofficeapi_response[0]["Status"] == 'Success' and googleapi_response['status'] == 'OK':

                if 'PostOffice' in postofficeapi_response[0] and 'postal_code' in googleapi_response['results'][0][
                    'types']:
                    for post_offices in postofficeapi_response[0]['PostOffice']:
                        response = post_offices
            else:
                response = "false"

            latitude = googleapi_response['results'][0]['geometry']['location']['lat']
            longitude = googleapi_response['results'][0]['geometry']['location']['lng']

            auto_id = get_auto_id(Location)

            # create location
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.latitude = latitude
            data.longitude = longitude

            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Location Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:location', kwargs={'pk': data.pk})
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
                "location": True,
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = LocationForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Location : " + instance.name,
            "instance": instance,
            "url": reverse('warehouses:edit_location', kwargs={'pk': instance.pk}),
            "redirect": True,
            "location": True,
            "is_location_edit":True,
        }
        print("jiii")
        return render(request, 'warehouses/location_new_entry.html', context)


@login_required
@role_required(['superadmin'])
def delete_location(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(
        Location.objects.filter(pk=pk, is_deleted=False))

    Location.objects.filter(pk=pk).update(
        is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id),deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "LocationSuccessfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('warehouses:locations')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin'])
def delete_selected_locations(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                Location.objects.filter(pk=pk, is_deleted=False))
            Location.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Location Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('warehouses:warehouses')
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
def our_orders(request):

    staff_instance = Staff.objects.get(user=request.user)
    instances = Orders.objects.filter(is_deleted=False, warehouse=staff_instance.warehouse)

    query = request.GET.get('query')
    if query:
        if 'unassigned' in query:
            instances = instances.filter(delivery_agent__isnull=True)

        elif 'pending' in query:
            instances = instances.filter(order_status="10")

        elif 'assigned' in query:
            instances = instances.filter(delivery_agent__isnull=False, order_status__in=["10", "20"])

        elif 'shipped' in query:
            instances = Orders.objects.filter(is_deleted=False, order_status="20")

        elif 'completed' in query:
            instances = Orders.objects.filter(is_deleted=False, order_status="30")

        elif 'cancelled' in query:
            instances = Orders.objects.filter(is_deleted=False, order_status="40")

    context = {
        "title": "All Orders",
        "instances": instances,
    }
    return render(request, 'orders/orders/orders.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def zones(request):

    instances = Zone.objects.all()
    title = "Zone"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(municipality__icontains=query) | Q(name__icontains=query) | Q(pincode__icontains=query) | Q(district__icontains=query) | Q(taluk__icontains=query))
        title = "zone - %s" % query

    context = {
        "instances": instances,
        'title': title,
    }

    return render(request, 'warehouses/zones.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def zone(request, pk):
    instance = get_object_or_404(Zone.objects.filter(pk=pk))

    context = {
        "instance": instance,
        "title": "zone : " ,
        "single_page": True,

    }
    return render(request, 'warehouses/zone.html', context)



@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_warehouse_delivery(request):
    DeliveryChargeFormset = formset_factory(DeliveryChargeForm, extra=1)

    if request.method == 'POST':

        delivery_charge_formset = DeliveryChargeFormset(request.POST, prefix='delivery_charge_formset')

        if delivery_charge_formset.is_valid() and len(delivery_charge_formset) > 0:

            for form_item in delivery_charge_formset:
                to_zone = form_item.cleaned_data["to_zone"]
                warehouse = form_item.cleaned_data["warehouse"]
                normal_charge = form_item.cleaned_data["normal_charge"]
                express_charge = form_item.cleaned_data["express_charge"]

                if not DeliveryCharge.objects.filter(warehouse=warehouse, to_zone=to_zone).exists():

                # create time-slot
                    DeliveryCharge.objects.create(
                        warehouse = warehouse,
                        to_zone = to_zone,
                        normal_charge = normal_charge,
                        express_charge = express_charge,
                    )

                    response_data = {
                        "status": "true",
                        "title": "Successfully Created",
                        "message": "Delivery Charge Created Successfully.",
                        "redirect": "true",
                        "redirect_url": reverse('warehouses:warehouse_delivery_charges')
                    }
                else:
                    message = f"Delivery charge with zone already exists {to_zone}"

                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Duplication Found",
                        "message": str(message)
                    }

        else:
            if len(delivery_charge_formset) == 0:
                message = "Please select a To Zone and enter value"
            else:
                message = generate_form_errors(delivery_charge_formset, formset=True)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        delivery_charge_formset = DeliveryChargeFormset(prefix='delivery_charge_formset')

        context = {
            "title": "Create Delivery Charge ",
            "delivery_charge_formset": delivery_charge_formset,
            "url": reverse('warehouses:create_warehouse_delivery'),
        }

        return render(request, 'warehouses/delivery_charges/delivery_charge_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def warehouse_delivery_charges(request):
    instances = DeliveryCharge.objects.filter(is_deleted=False,warehouse__manager__user=request.user)

    filter_data = {}
    query = request.GET.get("q")

    if query:

        instances = instances.filter(
            Q(to_zone__name__icontains=query) |
            Q(warehouse__name__icontains=query)  )

        filter_data['q'] = query

    context = {
        "title": "Delivery Charges",
        "instances": instances,
        "filter_data" : filter_data
    }

    return render(request, 'warehouses/delivery_charges/delivery_charges.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_warehouse_delivery(request, pk):
    instance = get_object_or_404(DeliveryCharge.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = EditDeliveryChargeForm(request.POST, instance=instance)

        if form.is_valid():
            # update offer
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Delivery Charge Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('warehouses:warehouse_delivery_charges', )
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
        form = EditDeliveryChargeForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Delivery Charge : " ,
            "instance": instance,
            "url": reverse('warehouses:edit_warehouse_delivery', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'warehouses/delivery_charges/edit_delivery_charge.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager', 'warehouse_user'])
def delete_warehouse_delivery(request, pk):

    instance = DeliveryCharge.objects.filter(pk=pk)
    instance.delete()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Delivery Charge Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('warehouses:warehouse_delivery_charges')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def warehouse_delivery(request, pk):
    instance = DeliveryCharge.objects.filter(is_deleted=False,pk=pk)


    context = {
        "title": "Delivery Charge : ",
        "pk": pk,
        "instance": instance,
    }

    return render(request, 'warehouses/delivery_charges/delivery_charge.html', context)


class ZoneAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        zones = Zone.objects.all()

        if self.q:
            zones = zones.filter(
                Q(name__istartswith=self.q) |
                Q(pincode__icontains=self.q) |
                Q(district__icontains=self.q)
            )

        return zones

# def upload_and_convert(request):
#     if request.method == 'POST':
#         form = FileForm(request.POST, request.FILES)

#         if form.is_valid():
#             input_excel = request.FILES['file']
#             book = xlrd.open_workbook(file_contents=input_excel.read())
#             sheet = book.sheet_by_index(0)

#             dict_list = []
#             keys = [str(sheet.cell(0, col_index).value) for col_index in range(sheet.ncols)]
#             for row_index in range(1, sheet.nrows):
#                 d = {keys[col_index]: str(sheet.cell(row_index, col_index).value)
#                     for col_index in range(sheet.ncols)}
#                 dict_list.append(d)

#             # Convert the list of dictionaries to JSON
#             json_data = json.dumps(dict_list, indent=4)

#             return render(request, 'your_template.html', {'form': form, 'json_data': json_data})

#     else:
#         form = FileForm()

#     return render(request, 'your_template.html', {'form': form})


# def show_zones(request):
#     json_file_relative_path = 'pincodes.json'
#     json_file_path = f"{SETTINGS.STATIC_FILE_ROOT}/{json_file_relative_path}"

#     try:
#         with open(json_file_path) as file:
#             data = json.load(file)
#     except FileNotFoundError:
#         data = []
#         print("File not found")
#     except Exception as e:
#         data = []
#         print("Error reading JSON file:", str(e))

#     # print(data)
#     zone_datas = []
#     for entry in data:
#         taluk = entry.get('taluk')
#         district = entry.get('districtName')
#         state = entry.get('stateName')
#         pincode = entry.get('pincode')

#         if pincode:
#             zone = Zone(
#                 taluk = taluk,
#                 district = district,
#                 state = state,
#                 pincode = pincode
#             )
#             zone_datas.append(zone)

#     Zone.objects.bulk_create(zone_datas)
#     zone_datas = list(Zone.objects.all().values())

#     response_data = {
#         "status": 'true',
#         "zone_datas":zone_datas
#     }
#     return HttpResponse(json.dumps(response_data), content_type='application/javascript')


# def delete_zones(request):
#     zone = Zone.objects.all()
#     zone.delete()
