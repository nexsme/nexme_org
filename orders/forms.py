from django import forms
from django.forms.widgets import TextInput, Textarea, HiddenInput, Select, FileInput
from products.models import Category
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _
from customers.models import CustomerAddress
from orders.models import *
from general.models import *


class TimeslotDayForm(forms.ModelForm):
    class Meta:
        model = TimeSlot
        fields = ['day']
        widgets = {
            'day': Select(attrs={'class': " form-control"}),
        }


class TimeslotTimeForm(forms.ModelForm):
    class Meta:
        model = TimeSlot
        # exclude = ['creator', 'updater','deleted_reason', 'auto_id', 'is_deleted', 'day']
        fields = ['start_time', 'end_time']
        widgets = {
            'start_time': TextInput(attrs={'class': 'required date-time-picker form-control','type': 'time', 'placeholder': 'Start Time'}),
            'end_time': TextInput(attrs={'class': 'required date-time-picker form-control','type': 'time', 'placeholder': 'End Time'}),
        }


class TimeslotForm(forms.ModelForm):
    class Meta:
        model = TimeSlot
        fields = ['day', 'start_time', 'end_time']

        widgets = {
            'day': Select(attrs={'class': "form-control"}),
            'start_time': TextInput(attrs={'class': 'required date-time-picker form-control','type': 'time', 'placeholder': 'Start Time'}),
            'end_time': TextInput(attrs={'class': 'required date-time-picker form-control','type': 'time', 'placeholder': 'End Time'}),
        }


class DeliveryAgentAssignForm(forms.ModelForm):
    class Meta:
        model = Orders
        fields = ['delivery_agent']
        widgets = {
            'delivery_agent': autocomplete.ModelSelect2(attrs={'data-placeholder': 'Category', 'class': 'required', 'data-minimum-input-length': 0}),

        }

        error_messages = {
            'delivery_agent': {
                'required': _("Day field is required."),
            },

        }


class OrderStatusForm(forms.Form):
    ORDER_CHOICES = (
            ("10", 'Pending'),
            ("20", 'Shipped'),
            ("30", 'Delivered'),
            ("40", 'Cancelled'),
        )
    order_status = forms.CharField(widget=forms.Select(choices=ORDER_CHOICES, attrs={'class':'form-control selectpicker'}))



class DeliveryChargeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        exclude = ['warehouse','vendor']
        widgets = {
            'to_zone': autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', attrs={'class': 'required form-control', 'data-placeholder': 'Select Zone', 'data-minimum-input-length': 0},),
            'normal_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Normal Delivery Charge'}),
            'express_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Express Delivery Charge'}),

        }


class DeliveryTypeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        fields = ['warehouse','vendor']
        widgets = {
            'vendor': autocomplete.ModelSelect2(url='vendors:vendor_autocomplete', attrs={'class': '', 'data-placeholder': 'Vendor', 'data-minimum-input-length': 0},),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': '', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
        }


class EditDeliveryChargeForm(forms.ModelForm):
    class Meta:
        model = DeliveryCharge
        fields = ['normal_charge','express_charge']
        widgets = {
            'normal_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Normal Delivery Charge'}),
            'express_charge': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Express Delivery Charge'}),
        }


class MinimumChargeForm(forms.ModelForm):
    class Meta:
        model = ChargeSetting
        fields = ['warehouse','vendor','no_delivery_charge_amount', 'no_free_delivery_amount']
        widgets = {
            'vendor': autocomplete.ModelSelect2(url='vendors:vendor_autocomplete', attrs={'class': '', 'data-placeholder': 'Vendor', 'data-minimum-input-length': 0},),
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': '', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
            'no_delivery_charge_amount': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Minimum Delivery Charge'}),
            'no_free_delivery_amount': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Free delivery if delivery charge is below amount'}),
        }


class OrdersForm(forms.ModelForm):
    address = forms.ModelChoiceField(required=True, queryset=CustomerAddress.objects.all(), widget=autocomplete.ModelSelect2(url='customers:address_autocomplete', forward=["customer"], attrs={'class': 'required', 'data-placeholder': 'Select Delivery address', 'data-minimum-input-length': 0},))

    class Meta:
        model = Orders
        fields = [
            'customer',
            'warehouse',
            'time_slot',
            'prefix',
            'order_id',
            'total_amt',

            'delivery_date',
            'delivery_agent',
            'is_express_delivery',
            'delivery_charge',
            'delivery_note',
        ]

        widgets = {
            'warehouse': autocomplete.ModelSelect2(url='warehouses:warehouse_autocomplete', attrs={'class': '', 'data-placeholder': 'Warehouse', 'data-minimum-input-length': 0},),
            'delivery_agent': autocomplete.ModelSelect2(attrs={'data-placeholder': 'Category', 'class': 'required', 'data-minimum-input-length': 0}),
            'customer': autocomplete.ModelSelect2(url='customers:customer_autocomplete', attrs={'data-placeholder': 'Customer', 'data-minimum-input-length': 0},),

            'prefix': Select(attrs={'class': 'required form-control'}),
            'order_id': TextInput(attrs={'class': 'required form-control','readonly': 'readonly','placeholder': 'Order Id'}),
            'time_slot': autocomplete.ModelSelect2(url='orders:timeslot_autocomplete', attrs={'class':'required', 'data-placeholder': 'Time Slot', 'data-minimum-input-length': 0},),

            'total_amt': TextInput(attrs={'class': 'required form-control','readonly': 'readonly','placeholder': 'Total Amount'}),
            'delivery_date': TextInput(attrs={'class': 'required form-control', 'type': 'date', 'placeholder': 'Order Date'}),
            'delivery_charge': TextInput(attrs={'class': 'form-control', 'placeholder': 'Delivery Charge'}),
            'delivery_note': TextInput(attrs={'class': 'form-control', 'placeholder': 'Delivery Note'}),
        }

        labels = {
            'total_amt': "Total Amount",
            'time_slot': 'Available Time Slots'
        }


class OrderItemForm(forms.ModelForm):
    class Meta:
        model = OrderItem
        fields = [
            'product_variant',
            'batch',
            'qty',
            'price',
            'igst_rate', 
            'cgst_rate',
            'sgst_rate',
            'igst_amount', 
            'sgst_amount', 
            'cgst_amount'
        ]

        widgets = {
            'product_variant': autocomplete.ModelSelect2(url='products:product_variant_autocomplete', forward=["warehouse"], attrs={'data-placeholder': 'Product', 'data-minimum-input-length': 0},),
            'batch': Select(attrs={"class": " selectpicker product form-control", "data-live-search": "true"}),

            'qty': TextInput(attrs={'class': ' number form-control', 'placeholder': 'Qty'}),
            'price': TextInput(attrs={'class': ' number form-control', 'placeholder': 'Price'}),

            'igst_rate': TextInput(attrs={'class': 'number form-control', 'placeholder': 'IGST %'}),
            'cgst_rate': TextInput(attrs={'class': 'number form-control', 'placeholder': 'CGST %'}),
            'sgst_rate': TextInput(attrs={'class': 'number form-control', 'placeholder': 'SGST %'}),
            'igst_amount': TextInput(attrs={'class': 'number form-control', 'placeholder': 'IGST Amount'}),
            'cgst_amount': TextInput(attrs={'class': 'number form-control', 'placeholder': 'CGST Amount'}),
            'sgst_amount': TextInput(attrs={'class': 'number form-control', 'placeholder': 'SGST Amount'}),
        }
