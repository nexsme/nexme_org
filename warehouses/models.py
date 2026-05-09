import datetime
from django.db import models
from django.db import models
from decimal import Decimal
from django.db.models import Sum, manager
from django.core.validators import MinValueValidator, MaxValueValidator
from django.utils.translation import ugettext_lazy as _
from main.models import BaseModel
from main.variables import phone_regex
from versatileimagefield.fields import VersatileImageField



class Warehouse(BaseModel):
    name = models.CharField(max_length=128)
    zone = models.ForeignKey('warehouses.Zone', on_delete=models.CASCADE, related_name='warehouse_zone',)
    location = models.ForeignKey('warehouses.Location', on_delete=models.CASCADE, related_name='warehouse_location',)
    deliverable_location = models.ManyToManyField('warehouses.Zone', blank=True, related_name='deliverable_location')
    no_express_delivery = models.ManyToManyField('warehouses.Zone', verbose_name="Zones that cannot be delivered with express delivery", blank=True, related_name='no_express_delivery')
    manager = models.ForeignKey("staffs.Staff", null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, related_name='manager')

    phone = models.CharField(max_length=128, validators=[phone_regex])
    address = models.TextField()
    country = models.CharField(max_length=128, default="India")

    class Meta:
        db_table = 'warehouse'
        verbose_name = _('Warehouse')
        verbose_name_plural = _('Warehouse')
        ordering = ('auto_id',)

    def __str__(self):
        return str(self.name)


class Location(BaseModel):
    location = models.CharField(max_length=128)
    short_name = models.CharField(max_length=50, blank=True, null=True)
    latitude = models.CharField(max_length=128,blank=True,null=True)
    longitude = models.CharField(max_length=128,blank=True,null=True)

    class Meta:
        db_table = 'location'
        verbose_name = _('Location')
        verbose_name_plural = _('Location')
        ordering = ('auto_id',)

    def __str__(self):
        return str(self.location)


class Zone(models.Model):
    DISTRICTS = (
            ("Thiruvananthapuram", "Thiruvananthapuram"),
            ("Kollam", "Kollam"),
            ("Pathanamthitta", "Pathanamthitta"),
            ("Alappuzha", "Alappuzha"),
            ("Kottayam", "Kottayam"),
            ("Idukki", "Idukki"),
            ("Ernakulam", "Ernakulam"),
            ("Thrissur", "Thrissur"),
            ("Palakkad", "Palakkad"),
            ("Malappuram", "Malappuram"),
            ("Kozhikode", "Kozhikode"),
            ("Wayanad", "Wayanad"),
            ("Kannur", "Kannur"),
            ("Kasaragod", "Kasaragod")
        )

    name = models.CharField(max_length=256)
    # arabic_name = models.CharField(max_length=256,null=True,blank=True)
    municipality = models.CharField(max_length=256)
    district = models.CharField(max_length=256, choices=DISTRICTS, default="Thiruvananthapuram")
    state = models.CharField(max_length=128, default="Kerala")
    taluk = models.CharField(max_length=128, default="Thiruvananthapuram")
    # municipality_arabic = models.CharField(max_length=256,null=True,blank=True)
    latitude = models.CharField(max_length=128,blank=True,null=True)
    longitude = models.CharField(max_length=128,blank=True,null=True)
    pincode = models.PositiveIntegerField(
        default=000000,
        validators=[
            MinValueValidator(100000, message="Pincode must be a 6-digit number."),
            MaxValueValidator(999999, message="Pincode must be a 6-digit number."),
        ]
    )

    class Meta:
        db_table = 'zone'
        verbose_name = _('Zone')
        verbose_name_plural = _('Zone')
        ordering = ('id',)

    def __str__(self):
        return f'{self.pincode} - {self.name}'



