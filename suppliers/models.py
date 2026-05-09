from __future__ import unicode_literals
from django.db import models
from django.utils.translation import ugettext_lazy as _
from main.models import BaseModel
from decimal import Decimal
from django.core.validators import MinValueValidator, RegexValidator


OPENING_TYPE = (
    ('debit', 'Debit'),
    ('credit', 'Credit')
)
phone_regex = RegexValidator(
    # regex=r'^\+?1?\d{8,15}$', message="Not a valid number") 
    regex=r'^\+?1?\d{10}$', message="Not a valid number, 10 digits required") #10 digits required

name_regex = RegexValidator(
    regex=r'^[A-Za-z.]+$', message="Enter a Valid Bank Name",  code='invalid_bank_name'
)




class Supplier(BaseModel):
    name = models.CharField(max_length=128)
    address = models.TextField()
    phone = models.CharField(max_length=128, validators=[phone_regex])
    email = models.EmailField(null=True, blank=True)
    user = models.OneToOneField("auth.User", on_delete=models.CASCADE, blank=True, null=True)

    bank_name = models.CharField(max_length=128, blank=True, null=True, validators=[name_regex])
    bank_account_name = models.CharField(max_length=128, blank=True, null=True)
    branch = models.CharField(max_length=128, blank=True, null=True)
    ifsc_code = models.CharField(max_length=128, blank=True, null=True)
    account_num = models.CharField(max_length=20, blank=True, null=True)

    opening_type = models.CharField(max_length=128, choices=OPENING_TYPE, default="debit")
    opening_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    credit_limit = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    debit_limit = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    current_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15)

    state = models.CharField(max_length=128, default="Kerala")
    district = models.CharField(max_length=128, blank=True, null=True)
    country = models.CharField(max_length=128, default="India")

    gst_number = models.CharField(max_length=128, blank=True, null=True)

    class Meta:
        db_table = 'suppliers_supplier'
        verbose_name = _('supplier')
        verbose_name_plural = _('suppliers')

    def __str__(self):
        return str(self.name)

    def get_balance_data(self):
        if self.current_balance < 0:
            return {'balance_type': 'Credit',
                    'balance': abs(self.current_balance), }
        else:
            return {'balance_type': 'Debit',
                    'balance': self.current_balance, }
