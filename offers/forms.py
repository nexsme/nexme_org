from django import forms
from django.forms.widgets import TextInput, Textarea, HiddenInput, Select, FileInput, CheckboxInput
from offers.models import Offers, DealOfDay, VoucherCode
from products.models import ProductVariant, Product
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _
from django.core.exceptions import ValidationError


class OffersForm(forms.ModelForm):
    class Meta:
        model = Offers
        exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'is_deleted']
        widgets = {
            'title': TextInput(attrs={'class': 'required form-control', 'placeholder': 'title'}),
            'offer_type': Select(attrs={'class': 'required form-control'}),
            'offer_percentage': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Offer Percentage'}),

            'start_time': TextInput(attrs={'class': 'required date-time-picker form-control', 'type': 'date', 'placeholder': 'Start Time'}),
            'end_time': TextInput(attrs={'class': 'required date-time-picker form-control', 'type': 'date', 'placeholder': 'End Time'}),

            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': 'required', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
            'product_variant': autocomplete.ModelSelect2(url='products:product_variant_autocomplete', attrs={'data-placeholder': 'Product', 'data-minimum-input-length': 0},),
            'category': autocomplete.ModelSelect2(url='products:category_autocomplete', attrs={'data-placeholder': 'Category', 'data-minimum-input-length': 0},),
            'subcategory': Select(attrs={'class': 'form-control'}),
            'image': FileInput(attrs={'class': 'form-control'}),
        }

        error_messages = {
            'start_time': {
                'required': _("Start Time field is required."),
            },
            'end_time': {
                'required': _("End Time field is required."),
            },
            'warehouse': {
                'required': _("Warehouse field is required."),
            },
            'product_variant': {
                'required': _("Product Variant field is required."),
            },
            'offer_percentage': {
                'required': _("Offer Percentage field is required."),
            }
        }


class DealOfDayForm(forms.ModelForm):
    class Meta:
        model = DealOfDay
        exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'is_deleted']

        widgets = {
            'deal_date': TextInput(attrs={'class': 'required form-control', 'type': 'date', 'placeholder': 'Deal Date'}),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete',attrs={'class': 'required', 'data-placeholder': 'Warehouse','data-minimum-input-length': 0}, ),
            'product_variant': autocomplete.ModelSelect2(url='products:product_variant_autocomplete',attrs={'class': 'required', 'data-placeholder': 'Product','data-minimum-input-length': 0}, ),
            'offer_percentage': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Offer Percentage'}),
        }

        error_messages = {
            'deal_date': {
                'required': _("Deal Date field is required."),
            },
            'warehouse': {
                'required': _("Warehouse field is required."),
            },
            'product_variant': {
                'required': _("Product Variant field is required."),
            },
            'offer_percentage': {
                'required': _("Offer Percentage field is required."),
            }
        }


class VoucherForm(forms.ModelForm):

    class Meta:
        model = VoucherCode
        fields = [
            'customer',
            'product',
            'product_variant',
            'voucher_type',
            'percentage',
            'voucher_code',
            'title',
            'description',
            'start_time',
            'end_time',
            'upto_limit',
            'minimum_order_amount',
            'is_limited_once',
            'is_expired'
        ]

        widgets = {
            'customer': autocomplete.ModelSelect2(url='customers:customer_autocomplete', attrs={'data-placeholder': 'Select Customer', 'data-minimum-input-length': 0}, ),
            'product': autocomplete.ModelSelect2(url='products:product_autocomplete', attrs={'data-placeholder': 'Select Product', 'data-minimum-input-length': 0}, ),
            'product_variant': autocomplete.ModelSelect2(url='products:product_variant_autocomplete', attrs={'data-placeholder': 'Select Variant', 'data-minimum-input-length': 0},),
            'voucher_type': Select(attrs={'class': 'form-control required'}),

            'percentage': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Percentage'}),
            'voucher_code': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Voucher Code'}),
            'title': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Title'}),
            'description': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Description'}),
            'start_time': TextInput(attrs={'class': 'form-control', 'type': 'date', 'placeholder': 'Start Time'}),
            'end_time': TextInput(attrs={'class': 'form-control', 'type': 'date', 'placeholder': 'End Time'}),
            'upto_limit': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Upto Limit'}),
            'minimum_order_amount': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Minimum Order Amount'}),
        }

        labels = {
            'upto_limit': "Upto limit (Maximum discount given in ₹)"
        }
