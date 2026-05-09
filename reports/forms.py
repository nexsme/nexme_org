from django import forms
from products.models import SpecialCategory
from dal import autocomplete


class SpecialCategoryReportForm(forms.Form):
    special_category = forms.ModelChoiceField(
        queryset = SpecialCategory.objects.all(),
        required = True,
        widget = autocomplete.ModelSelect2(
            url = 'products:special_category_autocomplete',
            attrs = {'data-placeholder': 'Special Category', 'data-minimum-input-length': 0},
        )
    )

    from_date = forms.DateField(
        required = True,
        widget = forms.TextInput(attrs={'type': 'date', 'class': 'required form-control'})
    )

    to_date = forms.DateField(
        required = True,
        widget = forms.TextInput(attrs={'type': 'date', 'class': 'required form-control'})
    )

    include_sold = forms.BooleanField(
        required = False,
        widget = forms.CheckboxInput(),
        label = 'Include products with stock changes only'
    )
