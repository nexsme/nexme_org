from django import forms
from django.forms.widgets import TextInput, Textarea, FileInput, Select, CheckboxInput, DateInput
from django.utils.translation import ugettext_lazy as _
from registration.forms import RegistrationForm
from django.contrib.auth.models import User

from main.models import CompanyProfile


class UserForm(RegistrationForm):
    
    username = forms.CharField(label=_("Username"), 
                               max_length=254,
                               widget=forms.TextInput(
                                    attrs={'placeholder': _('Enter username'),'class':'required form-control'})
                               )
    email = forms.EmailField(label=_("Email"), 
                             max_length=254,
                             widget=forms.TextInput(
                                attrs={'placeholder': _('Enter email'),'class':'required form-control'})
                             )
    password1 = forms.CharField(label=_("Password"), 
                               widget=forms.PasswordInput(
                                    attrs={'placeholder': _('Enter password'),'class':'required form-control'})
                               )
    password2 = forms.CharField(label=_("Repeat Password"), 
                               widget=forms.PasswordInput(
                                    attrs={'placeholder': _('Enter password again'),'class':'required form-control'})
                               )
    
    bad_domains = ['guerrillamail.com']
    
    def clean_email(self):
        email_domain = self.cleaned_data['email'].split('@')[1]
        if User.objects.filter(email__iexact=self.cleaned_data['email'],is_active=True):
            raise forms.ValidationError(_("This email address is already in use."))        
        elif email_domain in self.bad_domains:
            raise forms.ValidationError(_("Registration using %s email addresses is not allowed. Please supply a different email address." %email_domain))
        return self.cleaned_data['email']
    
    min_password_length = 6
    
    def clean_password1(self):
        password1 = self.cleaned_data.get('password1', '')
        if len(password1) < self.min_password_length:
            raise forms.ValidationError("Password must have at least %i characters" % self.min_password_length)
        else:
            return password1
    
    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError(
                self.error_messages['password_mismatch'],
                code='password_mismatch',
            )
        return password2
        
    min_username_length = 6

    def clean_username(self):
        username = self.cleaned_data['username']
        existing = User.objects.filter(username__iexact=self.cleaned_data['username'])
        if existing.exists():
            raise forms.ValidationError(_("A user with that username already exists."))
        elif len(username) < self.min_username_length:
            raise forms.ValidationError("Username must have at least %i characters" % self.min_password_length)
        else:
            return self.cleaned_data['username']  
        
class CompanyProfileForm(forms.ModelForm):
    class Meta:
        model = CompanyProfile
        fields = ["company_name","legal_name","tagline","about_us","email","phone_number","website","address","city","state","zip_code","logo","favicon","tax_id","registration_number","date_established"]
        
        widgets = {
            "company_name": forms.TextInput(attrs={"class": "required form-control","placeholder": "Name"}),
            "legal_name": forms.TextInput(attrs={"class": "required form-control","placeholder": "Legal Name"}),
            "tagline": forms.TextInput(attrs={"class": "required form-control","placeholder": "Tagline"}),
            "email": forms.TextInput(attrs={"class": "required form-control","placeholder": "Email"}),
            "phone_number": forms.TextInput(attrs={"class": "required form-control","placeholder": "Phone Number"}),
            "website": forms.TextInput(attrs={"class": "required form-control","placeholder": "Website"}),
            "address": forms.Textarea(attrs={"class": "required form-control","placeholder": "Address"}),
            "city": forms.TextInput(attrs={"class": "required form-control","placeholder": "City"}),
            "state": forms.TextInput(attrs={"class": "required form-control","placeholder": "State"}),
            "zip_code": forms.TextInput(attrs={"class": "required form-control","placeholder": "Zip Code"}),
            # "logo": forms.FileInput(attrs={"class": "required form-control","placeholder": "Logo"}),
            # "favicon": forms.FileInput(attrs={"class": "required form-control","placeholder": "Fav Icon"}),
            "tax_id": forms.TextInput(attrs={"class": "required form-control","placeholder": "Tax ID"}),
            "registration_number": forms.TextInput(attrs={"class": "required form-control","placeholder": "Registration No"}),
            "date_established": forms.TextInput(attrs={"type": "date","class": "required form-control","placeholder": "Date Established"}),
        }