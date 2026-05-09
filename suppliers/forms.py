import re
from django import forms
from django.forms.widgets import TextInput, Select
from suppliers.models import Supplier
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _


class SupplierForm(forms.ModelForm):

    class Meta:
        model = Supplier
        exclude = ['creator', 'updater','deleted_reason', 'auto_id',
                   'is_deleted', 'user', 'current_balance', 'gst_number']
        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'address': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Address'}),
            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'email': TextInput(attrs={'class': 'form-control', 'placeholder': 'Email'}),
            'opening_type': Select(attrs={'class': 'required form-control'}),

            # 'district': TextInput(attrs={'class': 'form-control', 'placeholder': 'District'}),
            'state': TextInput(attrs={'class': 'form-control', 'placeholder': 'State'}),
            'country': TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),

            'credit_limit': TextInput(attrs={'class': 'form-control', 'placeholder': 'Credit Limit'}),
            'debit_limit': TextInput(attrs={'class': 'form-control', 'placeholder': 'Debit Limit'}),
            'opening_balance': TextInput(attrs={'class': 'form-control', 'placeholder': ' Opening Balance'}),
            'gst_number': TextInput(attrs={'class': 'form-control', 'placeholder': 'Gst Number'}),
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
            'credit': "Opening Credit",
            'debit': "Opening Debit",
            'ifsc_code': "IFSC Code",
        }
    def clean_bank_account_name(self):
        print("clean_bank_name method called")
        bank_account_name = self.cleaned_data.get('bank_account_name')
        if bank_account_name:
            if not re.match(r'^[A-Za-z. ]+$', bank_account_name):
                raise forms.ValidationError("Bank name can only contain letters and '.'")
        return bank_account_name

class SupplierCreateFromForm(forms.ModelForm):

    class Meta:
        model = Supplier
        exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'gst_number', 'district',
                   'is_deleted', 'debit', 'credit', 'current_balance']
        widgets = {
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Name'}),
            'address': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Address'}),
            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Phone'}),
            'email': TextInput(attrs={'class': 'form-control', 'placeholder': 'Email'}),
            'opening_type': Select(attrs={'class': 'required form-control'}),
            'credit_limit': TextInput(attrs={'class': 'form-control', 'placeholder': 'Credit Limit'}),
            'debit_limit': TextInput(attrs={'class': 'form-control', 'placeholder': 'Debit Limit'}),

            'country': TextInput(attrs={'class': 'form-control', 'placeholder': 'Country'}),
            # 'district': TextInput(attrs={'class': 'form-control', 'placeholder': 'District'}),
            'state': TextInput(attrs={'class': 'form-control', 'placeholder': 'State'}),

            'opening_balance': TextInput(attrs={'class': 'form-control', 'placeholder': ' Opening Balance'}),
            'gst_number': TextInput(attrs={'class': 'form-control', 'placeholder': 'Gst Number'}),

        }
