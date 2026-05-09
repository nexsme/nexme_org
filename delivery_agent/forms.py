from dal import autocomplete
from delivery_agent.models import *
from django import forms
from django.forms.widgets import TextInput, FileInput
from django.utils.translation import ugettext_lazy as _


class DeliveryAgentForm(forms.ModelForm):
    class Meta:
        model = DeliveryAgents
        exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'user']

        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'email': TextInput(attrs={'class': 'email form-control', 'placeholder': 'Email'}),
            'phone1': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'phone2': TextInput(attrs={'class': 'form-control', 'placeholder': 'Phone'}),
            'password': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Password'}),
            'image': FileInput(attrs={'class': 'form-control dropify'}),
            'id_proof': FileInput(attrs={'class': 'form-control dropify'}),
            'license': FileInput(attrs={'class': 'form-control dropify'}),
            'license_expiry_date': TextInput(attrs={'class': 'required form-control','type': 'date', 'placeholder': 'License expiry date'}),
            'company_id': FileInput(attrs={'class': 'form-control dropify'}),
            'company_id_expiry_date': TextInput(attrs={'class': 'required form-control','type': 'date', 'placeholder': 'Company ID expiry date'}),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': 'required', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0}, ),
        }

        def clean_phone1(self):

            phone1 = self.cleaned_data.get('phone1')
            if not phone1.isnumeric() :
                raise forms.ValidationError("Enter a valid phone number")
            return phone1

        def clean_phone2(self):

            phone2 = self.cleaned_data.get('phone2')
            if not phone2.isnumeric() :
                raise forms.ValidationError("Enter a valid phone number")
            return phone2

        error_messages = {
            'name': {
                'required': _("Name field is required."),
            },
            'email': {
                'required': _("Email field is required."),
            },
            'phone': {
                'required': _("Phone field is required."),
            },
            'address': {
                'required': _("Addess field is required."),
            },
            'license': {
                'required': _("License field is required."),
            },
            'license_expiry_date': {
                'required': _("License expiry date field is required."),
            },
            'company_id': {
                'required': _("Company ID field is required."),
            },
            'company_id_expiry_date': {
                'required': _("Company ID expiry ate field is required."),
            },
            }




