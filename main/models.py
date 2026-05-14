import uuid
from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.validators import MinValueValidator
from decimal import Decimal

from ckeditor_uploader.fields import RichTextUploadingField
from versatileimagefield.fields import VersatileImageField

class BaseModel(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    auto_id = models.PositiveIntegerField(db_index=True, unique=True)
    creator = models.ForeignKey(
        "auth.User", blank=True, related_name="creator_%(class)s_objects", on_delete=models.CASCADE)
    updater = models.ForeignKey("auth.User", blank=True, null=True,
                                related_name="updater_%(class)s_objects", on_delete=models.CASCADE)
    date_added = models.DateTimeField(db_index=True, auto_now_add=True)
    date_updated = models.DateTimeField(auto_now_add=True)
    is_deleted = models.BooleanField(default=False)
    deleted_reason = models.CharField(max_length=128, blank=True, null=True)

    class Meta:
        abstract = True


class Mode(models.Model):
    readonly = models.BooleanField(default=False)
    maintenance = models.BooleanField(default=False)
    down = models.BooleanField(default=False)

    class Meta:
        db_table = 'mode'
        verbose_name = _('mode')
        verbose_name_plural = _('mode')
        ordering = ('id',)

    class Admin:
        list_display = ('id', 'readonly', 'maintenance', 'down')

    def __str__(self):
        return str(self.id)


class Settings(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    counter = models.PositiveIntegerField()
    prefix = models.CharField(max_length=128)
    project_prefix = models.CharField(max_length=128)
    product_prefix = models.CharField(max_length=128)
    purchase_prefix = models.CharField(max_length=128)
    sale_prefix = models.CharField(max_length=128)
    payment_prefix = models.CharField(max_length=128)

    is_deleted = models.BooleanField(default=False)

    class Meta:
        db_table = 'setting'
        verbose_name = _('setting')
        verbose_name_plural = _('settings')
        ordering = ('prefix',)

    def __unicode__(self):
        return self.prefix


class AppUpdate(models.Model):
    date_added = models.DateTimeField(db_index=True, auto_now_add=True)

    android_version = models.CharField(max_length=16)
    android_force_upgrade = models.BooleanField(default=False)
    android_recommended_upgrade = models.BooleanField(default=False)

    ios_version = models.CharField(max_length=16)
    ios_force_upgrade = models.BooleanField(default=False)
    ios_recommended_upgrade = models.BooleanField(default=False)


    class Meta:
        db_table = 'app_update'
        verbose_name = _('App update')
        verbose_name_plural = _('App updates')
        ordering = ('date_added',)

    def __str__(self):
        return str(self.id)


class DeliveryAppUpdate(models.Model):
    date_added = models.DateTimeField(db_index=True, auto_now_add=True)

    android_version = models.CharField(max_length=16)
    android_force_upgrade = models.BooleanField(default=False)
    android_recommended_upgrade = models.BooleanField(default=False)

    ios_version = models.CharField(max_length=16)
    ios_force_upgrade = models.BooleanField(default=False)
    ios_recommended_upgrade = models.BooleanField(default=False)


    class Meta:
        db_table = 'delivery_app_update'
        verbose_name = _('Delivery Application Update')
        verbose_name_plural = _('Delivery Application Updates')
        ordering = ('id',)

    def __str__(self):
        return str(self.id)


class CompanyProfile(BaseModel):
    # --- Basic Information ---
    company_name = models.CharField(max_length=255)
    legal_name = models.CharField(max_length=255, help_text="Official name for invoicing")
    tagline = models.CharField(max_length=500, blank=True, null=True)
    
    # infomations
    about_us = RichTextUploadingField(blank=True, null=True)
    privacy_policy = RichTextUploadingField(blank=True, null=True)
    terms_and_conditions = RichTextUploadingField(blank=True, null=True)
    our_mission = RichTextUploadingField(blank=True, null=True)
    our_vision = RichTextUploadingField(blank=True, null=True)
    our_inspiration = RichTextUploadingField(blank=True, null=True)
    delivery_infomation = RichTextUploadingField(blank=True, null=True)
    
    # --- Contact Details ---
    email = models.EmailField()
    phone_number = models.CharField(max_length=20)
    website = models.URLField(blank=True, null=True)
    address = models.TextField()
    city = models.CharField(max_length=100)
    state = models.CharField(max_length=100)
    zip_code = models.CharField(max_length=20)
    
    # --- Branding ---
    logo = VersatileImageField('Logo', upload_to="company/logos/", blank=True, null=True)
    favicon = VersatileImageField('Favicon', upload_to="company/favicons/", blank=True, null=True)
    
    # --- Legal & Tax ---
    tax_id = models.CharField(max_length=50, verbose_name="GST/VAT/Tax ID")
    registration_number = models.CharField(max_length=100, blank=True, null=True)
    
    # --- Meta ---
    is_active = models.BooleanField(default=True)
    date_established = models.DateField(blank=True, null=True)

    class Meta:
        verbose_name = "Company Profile"
        verbose_name_plural = "Company Profile"

    def __str__(self):
        return self.company_name