from __future__ import unicode_literals
from email.policy import default
from django.db import models
from django.utils.translation import ugettext_lazy as _
import os
import uuid
from main.models import BaseModel
from main.variables import phone_regex
from decimal import Decimal
from general.models import UserBaseModel
from warehouses.models import Location, Zone
from django.core.validators import MinValueValidator
from versatileimagefield.fields import VersatileImageField
from django.db import models
from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError


OPENING_TYPE = (
    ('debit', 'Debit'),
    ('credit', 'Credit')
)

CATEGORY = (
    ('b2b', 'B2B'),
    ('b2c', 'B2C')
)


TICKET_STATUS = (
    ('pending', 'Pending'),
    ('in_progress', 'In Progress'),
    ('rejected', 'Rejected'),
    ('solved', 'Solved'),
)

ADDRESS_TYPE = (
    (10, "Home"),
    (20, "Office"),
)

PRIORITY = (
    ('10', "Low"),
    ('20', "Medium"),
    ('30', "High"),
)

letters_and_spaces_validator = RegexValidator(
    regex=r'^[A-Za-z\s]*$',
    message='Name can only contain letters and spaces.',
)

numbers_validator = RegexValidator(
    regex=r'^[0-9]*$',
    message='Phone can only contain numbers.',
)

class Customer(BaseModel):
    user = models.OneToOneField("auth.User", on_delete=models.CASCADE, blank=True, null=True)
    name = models.CharField(max_length=50)
    phone = models.CharField(validators=[phone_regex],max_length=10)
    email = models.EmailField(max_length=128, null=True)
    gst_number = models.CharField(max_length=128, blank=True, null=True)
    country = models.CharField(max_length=128, blank=True, null=True, default="India")
    state = models.CharField(max_length=128, blank=True, null=True)

    house = models.CharField('House No/Name', max_length=128, blank=True, null=True)
    building = models.CharField('Building No/Name', max_length=128, blank=True, null=True)
    street = models.CharField('Street No/Name', max_length=128, blank=True, null=True)

    opening_type = models.CharField(max_length=128, choices=OPENING_TYPE, default="debit", blank=True, null=True)
    opening_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    current_balance = models.DecimalField(default=0, decimal_places=2, max_digits=15)
    current_privilege_points = models.DecimalField(default=0, decimal_places=0, max_digits=15)
    privilege_points = models.DecimalField(default=0, decimal_places=0, max_digits=15)

    image = VersatileImageField(upload_to="customers/images/",null=True,blank=True)
    is_web_registered = models.BooleanField(default=False)

    class Meta:
        db_table = 'customers_customer'
        verbose_name = _('customer')
        verbose_name_plural = _('customers')
        ordering = ('-date_added', 'name')

    def __str__(self):
        if self.phone:
            return f'{self.auto_id} - {self.name} - {self.phone}'
        else:
            return f'{self.auto_id} - {self.name}'

    def get_balance_data(self):
        if self.current_balance < 0:
            return {'balance_type': 'Credit',
                    'balance': abs(self.current_balance), }
        elif self.current_balance == 0:
            return {'balance_type': '',
                    'balance': self.current_balance, }
        else:
            return {'balance_type': 'Debit',
                    'balance': self.current_balance, }


class CustomerAddress(UserBaseModel):
    zone = models.ForeignKey(Zone, on_delete=models.CASCADE,)
    location = models.ForeignKey(Location, on_delete=models.CASCADE, limit_choices_to={'is_deleted': False})
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, )
    address_type = models.IntegerField(choices=ADDRESS_TYPE)

    name = models.CharField(max_length=50, validators=[letters_and_spaces_validator])
    phone = models.CharField(max_length=10, validators=[numbers_validator])
    email = models.EmailField(null=True, blank=True)


    house_name = models.CharField(max_length=50)
    street = models.CharField(max_length=128)


    city = models.CharField(max_length=50, null=True, blank=True)
    landmark = models.CharField(max_length=256, null=True, blank=True)
    state = models.CharField(max_length=128, default="Kerala", null=True)

    is_default = models.BooleanField(default=True)

    class Meta:
        ordering = ('-is_default','name',)
        verbose_name = 'customer address'
        verbose_name_plural = 'customer addresses'

    def __str__(self):
        return f"{self.name} , {self.house_name} -  {self.zone}, {self.location}  "


class UserOtpData(models.Model):
    name = models.CharField(max_length=256)
    phone = models.CharField(max_length=10, validators=[numbers_validator])
    otp = models.PositiveIntegerField()
    attempts = models.PositiveIntegerField(default=1)
    resend_otp_index = models.BooleanField(default=False)
    is_deleted = models.BooleanField(default=False)
    password = models.CharField(max_length=256, null=True, blank=True)

    class Meta:
        verbose_name = _('OTP Record')
        verbose_name_plural = _('OTP Records')

    def __str__(self):
        return self.phone


class PrivilegePoint(BaseModel):
    minimum_amount = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    value_of_point = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    point_gained_online = models.DecimalField(decimal_places=0, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    point_gained_offline = models.DecimalField(decimal_places=0, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    class Meta:
        db_table = 'privilege_points'
        verbose_name = _('privilege_point')
        verbose_name_plural = _('privilege_points')
        ordering = ('date_added', )

    def __str__(self):
        return str(self.value_of_point)


class PrivilegePointHistory(models.Model):
    POINT_TYPE = (
        (10, "gained"),
        (20, "used")
    )
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    title = models.CharField(max_length=256)
    point_type = models.PositiveSmallIntegerField(choices=POINT_TYPE, default=10)
    points = models.DecimalField(decimal_places=0, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    value_in_amount = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    date_added = models.DateTimeField(db_index=True, auto_now_add=True)
    is_deleted = models.BooleanField(default=False)

    class Meta:
        db_table = 'privilege_point_history'
        verbose_name = _('Privilege Point History')
        verbose_name_plural = _('Privilege Point Histories')
        ordering = ('-id', )

    def __str__(self):
        return f"{self.customer} - {self.points} points"


class Ticket(BaseModel):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, )

    subject = models.CharField(max_length=256, null=True)
    description = models.TextField(null=True,blank=True, max_length=256)

    status = models.CharField(max_length=50,choices=TICKET_STATUS)
    priority = models.CharField(max_length=50,choices=PRIORITY)
    attachment = models.FileField(upload_to="tickets/attachment/",null=True,blank=True)

    reject_reason = models.CharField(max_length=256,null=True)
    message = models.CharField(max_length=256,null=True,blank=True)

    class Meta:
        db_table = 'tickets'
        verbose_name = _('ticket')
        verbose_name_plural = _('tickets')
        ordering = ('date_added', )

    def __str__(self):
        return f"{self.customer.name} - {self.subject}"


class CustomerAccount(UserBaseModel):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, )

    bank_name = models.CharField(max_length=128,blank=True,null=True)
    account_number = models.CharField(max_length=128)
    account_holder = models.CharField(max_length=128,blank=True,null=True)
    swift_code = models.CharField(max_length=128,blank=True,null=True)
    branch = models.CharField(max_length=128,blank=True,null=True)
    iban = models.CharField(max_length=128)


    class Meta:
        db_table = 'customer_bank_account'
        verbose_name = _('customer bank account')
        verbose_name_plural = _('customer bank accounts')
        ordering = ('date_added', )

    def __str__(self):
        return f'{self.account_holder} - {self.account_number} '
    
    # color: rgb(255, 26, 26);
    # padding: 4% 0%;
    # border-radius: 8px;
    # border: 1px solid rgb(179, 0, 0);
    # margin-top: 22px;
    # width: 100%;