from django import forms
from django.forms.widgets import TextInput, Select
from general.models import DeliveryCharge
from vendors.models import Vendor
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _


class VendorForm(forms.ModelForm):
    username = forms.CharField(label=_("Username"), max_length=254, widget=forms.TextInput(
        attrs={'class': 'required form-control',}))

    password = forms.CharField(label=_("Password"), max_length=254, widget=forms.TextInput(
        attrs={'class': 'required form-control', }))

    class Meta:
        model = Vendor
        exclude = ['creator', 'updater','deleted_reason', 'auto_id',
                   'is_deleted', 'current_balance', 'location']
        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'vendor_type': TextInput(attrs={'class': 'required form-control', 'placeholder': 'eg: Grocery, Home Appliances, etc...'}),
            # 'type_arabic': TextInput(attrs={'class': 'required form-control', 'placeholder': '... ,بقالة ، أجهزة منزلية '}),
            # 'arabic_name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'اسم عربي'}),
            'address': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Address'}),
            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'email': TextInput(attrs={'class': 'form-control', 'placeholder': 'Email'}),
            'opening_type': Select(attrs={'class': 'required form-control'}),

            'district': TextInput(attrs={'class': 'form-control', 'placeholder': 'District'}),
            'country': TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),
            # 'location_arabic': TextInput(attrs={'class': 'required form-control', 'placeholder': '   أدخل موقعك باللغة العربية'}),

            'place': TextInput(attrs={'class': 'form-control', 'placeholder': 'Place'}),
            'zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Vendor Zone', 'data-minimum-input-length': 0},),
            # 'deliverable_location': autocomplete.ModelSelect2Multiple(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Deliverable Location', 'data-minimum-input-length': 0},),
            'commission_type': Select(attrs={'class': 'required form-control'}),
            'commission_percentage': TextInput(attrs={'class': 'form-control', 'placeholder': ' Commission Percentage'}),

            'opening_balance': TextInput(attrs={'class': 'form-control', 'placeholder': ' Opening Balance'}),
            'state': Select(attrs={'class': 'form-control', 'placeholder': 'State code'}),
            'bank_name': TextInput(attrs={'class': 'form-control', 'placeholder': 'Bank Name'}),
            'branch': TextInput(attrs={'class': 'form-control', 'placeholder': 'Branch'}),
            'bank_account_name': TextInput(attrs={'class': 'form-control', 'placeholder': 'Bank Account Name'}),
            'ifsc_code': TextInput(attrs={'class': 'form-control', 'placeholder': 'IFSC Code'}),
            'account_num': TextInput(attrs={'class': 'form-control', 'placeholder': 'Account Number'}),


        }
        error_messages = {
            'name': {
                'required': _("Name field is required."),
            },
            'address': {
                'required': _("Address field is required."),
            },
            'phone': {
                'required': _("Phone field is required."),
            }
        }
        labels = {
            'account_num': "Account Number",
            'opening_type': "Opening Type",
            'opening_balance': "Opening Balance",
            'ifsc_code': "IFSC Code",
        }


class VendorCreateFromForm(forms.ModelForm):

    class Meta:
        model = Vendor
        exclude = ['creator', 'updater','deleted_reason', 'auto_id',
                   'is_deleted', 'debit', 'credit', 'current_balance','']
        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'address': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Address'}),
            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'email': TextInput(attrs={'class': 'form-control', 'placeholder': 'Email'}),
            'opening_type': Select(attrs={'class': 'required form-control'}),

            'district': TextInput(attrs={'class': 'form-control', 'placeholder': 'District'}),
            'country': TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),

            'opening_balance': TextInput(attrs={'class': 'form-control', 'placeholder': ' Opening Balance'}),
            'state': Select(attrs={'class': 'form-control', 'placeholder': 'State code'}),
            'gst_number': TextInput(attrs={'class': 'form-control', 'placeholder': 'Gst Number'}),

        }


class DeliveryChargeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        exclude = ['warehouse','vendor','express_charge']
        widgets = {
            'to_zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'data-placeholder': 'Select Zone', 'data-minimum-input-length': 0},),
            'normal_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Normal Delivery Charge'}),

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