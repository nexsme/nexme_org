from django import forms
from django.forms.widgets import TextInput, Textarea, HiddenInput, Select, FileInput, RadioSelect
from products.models import Category
from dal import autocomplete
from django.utils.translation import ugettext_lazy as _
from web.models import FeauturedCategory, ProductReturn, SocialLinks, SpotlightBanner
from customers.models import CustomerAccount, UserOtpData, Customer, Ticket
from warehouses.models import Location, Zone
from orders.models import TimeSlot


class FeauturedCategoryForm(forms.ModelForm):
    class Meta:
        model = FeauturedCategory
        exclude = ['creator', 'updater', 'deleted_reason', 'auto_id', 'is_deleted']
        widgets = {
            'category': autocomplete.ModelSelect2(url='products:category_autocomplete',
                                                  attrs={'data-placeholder': 'Category',
                                                         'class': 'required',
                                                         'data-minimum-input-length': 0}),
        }

        error_messages = {

            'category': {
                'required': _("Category field is required."),
            },
        }


class SpotlightBannerForm(forms.ModelForm):
    class Meta:
        model = SpotlightBanner
        exclude = ['creator', 'updater', 'deleted_reason', 'auto_id', 'is_deleted']
        widgets = {
            'banner_type': Select(attrs={"class": " selectpicker form-control", "data-live-search": "true"}),
            'offer_type': Select(attrs={"class": " selectpicker form-control", "data-live-search": "true"}),
            'product_variant': autocomplete.ModelSelect2(url='products:product_variant_autocomplete',
                                                         attrs={'data-placeholder': 'Product Variant', 'class': '',
                                                                'data-minimum-input-length': 0}),
            'category': autocomplete.ModelSelect2(url='products:category_autocomplete',
                                                  attrs={'data-placeholder': 'Category', 'class': '',
                                                         'data-minimum-input-length': 0}),
            'brand': autocomplete.ModelSelect2(url='products:brand_autocomplete',
                                               attrs={'data-placeholder': 'Brand', 'class': '',
                                                      'data-minimum-input-length': 0}),

        }

        error_messages = {

            'product_variant': {
                'required': _("Product field is required."),
            },
        }


class SignUpForm(forms.ModelForm):
    class Meta:
        model = UserOtpData
        fields = ['name', 'phone']
        widgets = {
            'phone': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Your Phone Number'}),
            'name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Your Phone Name'}),

        }

        error_messages = {

            'phone': {
                'required': _("Phone field is required."),
            },
            'name': {
                'required': _("Name field is required."),
            },
        }


class ProfileForm(forms.ModelForm):
    class Meta:
        model = Customer
        fields = ['name', 'email', 'phone', 'image',]
        widgets = {

            'phone': TextInput(attrs={'readonly' : '' , 'class': 'required form-control', 'placeholder': 'Enter Your Name' ,}),
            'name': forms.TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Your Name', 'pattern': '^[A-Za-z\s]+$', 'title': 'Only letters and spaces are allowed in the name', 'maxlength': '50'}),
            'email': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Your Email'}),
        }

        error_messages = {

            'phone': {
                'required': _("Phone field is required."),
            },
            'name': {
                'required': _("Name field is required."),
            },
            'email': {
                'required': _("Email field is required."),
            },
        }


class TicketForm(forms.ModelForm):
    class Meta:
        model = Ticket
        exclude = ['customer', 'status', 'reject_reason', 'message','auto_id']
        widgets = {
            'subject': TextInput(attrs={'class': 'required form-control issue_title' ,'placeholder': 'Enter Subject for Ticket'}),
            'description': Textarea(attrs={'class': 'required form-control','id': 'description','rows' : '4', 'placeholder': 'Enter Your Message'}),
            'priority': RadioSelect(attrs={'class': 'required form-control', 'display': 'inline-block','placeholder': 'Enter Your Phone Name'}),
            'attachment':  FileInput(attrs={'class': 'form-control issue_title' }),
        }


class PincodeForm(forms.Form):
    pincode = forms.ModelChoiceField(queryset=Location.objects.filter(is_deleted=False))


class SocialLinksForm(forms.ModelForm):
    class Meta:
        model = SocialLinks
        fields = ['facebook_link', 'instagram_link','twitter_link','whatsapp_link']
        widgets = {
            'facebook_link': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Facebook Link'}),
            'instagram_link': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Instagram Link'}),
            'twitter_link': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Twitter Link'}),
            'whatsapp_link': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Enter Whatsapp Link'}),

        }


class ProductReturnForm(forms.ModelForm):
    class Meta:
        model = ProductReturn
        fields = ['reason_for_return', 'return_specification']
        widgets = {
            'reason_for_return': Select(attrs={'class': 'required form-control', 'placeholder': 'Reason for return'}),
            'return_specification': Textarea(attrs={'class': 'required form-control', 'placeholder': 'Return Specification','rows': '4'}),
        }


class CustomerAccountForm(forms.ModelForm):
    class Meta:
        model = CustomerAccount
        fields = ['bank_name', 'account_holder','account_number','swift_code','branch','iban']
        widgets = {
            'bank_name': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Bank Name'}),
            'account_holder': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Account Holder Name'}),
            'account_number': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Account Number'}),
            'swift_code': TextInput(attrs={'class': 'required form-control', 'placeholder': 'IFSC Code'}),
            'branch': TextInput(attrs={'class': 'required form-control', 'placeholder': 'Bank Branch'}),
            'iban': TextInput(attrs={'class': 'required form-control', 'placeholder': 'IBAN'}),
        }


class CustomerPincodeForm(forms.Form):
    pincode = forms.ModelChoiceField(queryset=Zone.objects.all(), 
        widget=autocomplete.ModelSelect2(url='warehouses:zone_autocomplete', 
            attrs={'class': 'required', 'data-placeholder': 'Pincode', 'data-minimum-input-length': 0}),)
