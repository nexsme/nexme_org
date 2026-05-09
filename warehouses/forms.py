from django import forms
from django.forms.widgets import TextInput, Textarea, HiddenInput, Select, FileInput
from general.models import DeliveryCharge
from warehouses.models import Warehouse, Location
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _
from django.core.exceptions import ValidationError


class WarehouseForm(forms.ModelForm):

    class Meta:
        model = Warehouse
        exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'is_deleted', 'location']
        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'location': autocomplete.ModelSelect2(url='warehouses:warehouse_location_autocomplete', attrs={'data-placeholder': 'Warehouse Location', 'data-minimum-input-length': 0},),
            'zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Warehouse Zone', 'data-minimum-input-length': 0},),
            # 'deliverable_location': autocomplete.ModelSelect2Multiple(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Deliverable Zones', 'data-minimum-input-length': 0},),
            'manager': autocomplete.ModelSelect2(url='staffs:warehouse_manager_autocomplete', attrs={'data-placeholder': 'Warehouse Manager', 'data-minimum-input-length': 0},),

            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'address': Textarea(attrs={'class': 'required form-control', 'rows': 4, 'placeholder': 'Address'}),
            'country': TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),
        }

        error_messages = {
            'name': {
                'required': _("Name field is required."),
            },
            'location': {
                'required': _("Location field is required."),
            },
            'zone': {
                'required': _("Zone field is required."),
            },
        }

        labels = {
            "deliverable_location": "Deliverable Locations"
        }

class LocationForm(forms.ModelForm):

    class Meta:
        model = Location
        exclude = ['creator', 'updater', 'auto_id', 'is_deleted', 'short_name', 'delete_reason']
        widgets = {
            'location': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Location'}),
            'latitude': TextInput(attrs={'class': 'required form-control ', 'readonly': 'readonly', 'placeholder': 'Latitude'}),
            'longitude': TextInput(attrs={'class': 'required form-control ', 'readonly': 'readonly', 'placeholder': 'Longitude'}),
        }


class DeliveryChargeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        exclude = ['vendor']
        widgets = {
            'to_zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Select Zone', 'data-minimum-input-length': 0},),
            'normal_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Normal Delivery Charge'}),
            'express_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Express Delivery Charge'}),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': '', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
        }


class EditDeliveryChargeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        fields = ['warehouse','vendor','to_zone','normal_charge','express_charge']
        widgets = {
            'vendor': autocomplete.ModelSelect2(url='vendors:vendor_autocomplete', attrs={'class': '', 'data-placeholder': 'Vendor', 'data-minimum-input-length': 0},),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': '', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
            'to_zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Select Zone', 'data-minimum-input-length': 0},),
            'normal_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Normal Delivery Charge'}),
            'express_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Express Delivery Charge'}),

        }