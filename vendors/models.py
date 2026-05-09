from __future__ import unicode_literals

from decimal import Decimal

from django.core.validators import MinValueValidator
from django.db import models
from django.utils.translation import ugettext_lazy as _
from main.models import BaseModel
from versatileimagefield.fields import VersatileImageField

from orders.models import OrderItem

COMMISSION_TYPE = (
    ('monthly', 'Monthly'),
    ('weekly', 'Weekly'),
    ('daily', 'Daily'),
    ('product_based', 'Product Based'),
)

OPENING_TYPE = (
    ('debit', 'Debit'),
    ('credit', 'Credit')
)

class Vendor(BaseModel):
    name = models.CharField(max_length=128)
    vendor_type = models.CharField(max_length=128, null=True)
    type_arabic = models.CharField(max_length=128, null=True, blank=True)
    arabic_name = models.CharField(max_length=128, null=True, blank=True)

    address = models.TextField()
    phone = models.CharField(max_length=128)
    email = models.EmailField(null=True, blank=True)

    bank_name = models.CharField(max_length=128, blank=True, null=True)
    bank_account_name = models.CharField(max_length=128, blank=True, null=True)
    branch = models.CharField(max_length=128, blank=True, null=True)
    ifsc_code = models.CharField(max_length=128, blank=True, null=True)
    account_num = models.CharField(max_length=128, blank=True, null=True)
    opening_type = models.CharField(max_length=128, choices=OPENING_TYPE, default="debit")
    opening_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    country = models.CharField(max_length=128, default="India")
    current_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15)

    image = VersatileImageField(upload_to="media/")
    place = models.CharField(max_length=128, blank=True, null=True)
    commission_type = models.CharField(choices=COMMISSION_TYPE, default="monthly", max_length=128)
    commission_percentage = models.DecimalField(default=0, decimal_places=2, max_digits=15)

    zone = models.ForeignKey('warehouses.Zone', on_delete=models.CASCADE, related_name='vendor_zone',)
    location = models.ForeignKey("warehouses.Location", limit_choices_to={'is_deleted': False},  on_delete=models.CASCADE, related_name='vendor_location')
    location_arabic = models.CharField(max_length=128, null=True, blank=True)
    deliverable_location = models.ManyToManyField('warehouses.Zone', blank=True)
    user = models.OneToOneField("auth.user", blank=True, null=True, on_delete=models.CASCADE)
    password = models.CharField(max_length=128, blank=True, null=True)
    delivery_availability = models.CharField(
        max_length=128,
        choices=[
            ("all_india", "All India"),
            ("all_kerala", "All Kerala"),
            ("district", "District"),
        ],
        default="all_india",
        blank=True
    )

    class Meta:
        db_table = 'vendors_vendor'
        verbose_name = _('vendor')
        verbose_name_plural = _('vendors')

    def __str__(self):
        return str(self.name)

    def get_balance_data(self):
        if self.current_balance < 0:
            return {'balance_type': 'Credit', 'balance': abs(self.current_balance), }
        else:
            return {'balance_type': 'Debit', 'balance': self.current_balance, }


class VendorCommission(models.Model):
    vendor = models.ForeignKey("vendors.Vendor", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)

    date = models.DateField(auto_now_add=True)
    commission_amount = models.DecimalField(default=0.0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    is_paid = models.BooleanField(default=False)
    order_item = models.OneToOneField(OrderItem, related_name='order_items',on_delete=models.CASCADE,null=True)

    class Meta:
        db_table = 'vendors_commission'
        verbose_name = _('Vendor Commission')
        verbose_name_plural = _('Vendor Commissions')

    def __str__(self):
        return str(self.commission_amount)
