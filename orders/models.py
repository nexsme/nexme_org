from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.validators import MinValueValidator
from django.db.models import F

from main.models import BaseModel
from general.models import UserBaseModel
from general.models import Batch
from customers.models import Customer
from vendors.models import *
from warehouses.models import Warehouse, Zone
from products.models import *


DAY_CHOICES = (
    (1, 'Monday'),
    (2, 'Tuesday'),
    (3, 'Wednesday'),
    (4, 'Thursday'),
    (5, 'Friday'),
    (6, 'Saturday'),
    (7, 'Sunday')
)

ORDER_CHOICES = (
    ("10", 'Pending'),
    ("20", 'Shipped'),
    ("30", 'Delivered'),
    ("40", 'Cancelled')
)

VENDOR_CHOICES = (
    (10, 'Pending'),
    (20, 'Accepted'),
    (30, 'Packed'),
    (40, 'Declined'),
)

PAYMENT_CHOICES = (
    ("10", 'Pending'),
    ("20", 'Recieved'),
    ("30", 'Failed')
)

BOOKING_STATUS_CHOICES = (
    ('pending', 'pending'),
    ('confirmed', 'Confirmed'),
)

DELIVERY_AGENT_DECLINED_CHOICES = (
    ('too_long', 'Too Long'),
    ('time_waste', 'Time Waste'),
    ('large_order_list', 'Large Order List'),
)

PICKUP_CHOICES = (
    ('reached', 'Reached Pickup Location'),
    ('picked_up', 'Picked Up'),
)

class TimeSlot(BaseModel):
    day = models.IntegerField(choices=DAY_CHOICES, default=1)
    start_time = models.TimeField()
    end_time = models.TimeField()

    is_active = models.BooleanField(default=True)

    class Meta:
        verbose_name = 'time slot'
        verbose_name_plural = 'time slots'
        ordering = ('start_time', 'auto_id')

    def __str__(self):
        start_time = self.start_time.strftime("%I:%M %p")
        end_time = self.end_time.strftime("%I:%M %p")
        return f"{start_time} - {end_time}"


class Orders(BaseModel):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, )
    zone = models.ForeignKey(Zone, on_delete=models.CASCADE)
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE, null=True, blank=True)
    time_slot = models.ForeignKey(TimeSlot, on_delete=models.CASCADE, null=True)
    vendor = models.ForeignKey('vendors.Vendor', on_delete=models.CASCADE, null=True, blank=True)
    prefix = models.ForeignKey('finance.InvoicePrefix', on_delete=models.CASCADE, null=True, blank=True)
    delivery_agent = models.ForeignKey('delivery_agent.DeliveryAgents', on_delete=models.CASCADE, null=True, blank=True)
    receipt_voucher = models.ForeignKey('finance.ReceiptVoucher', on_delete=models.CASCADE, null=True, blank=True)

    billing_name = models.CharField(max_length=50)
    billing_phone = models.CharField(max_length=10)
    billing_street = models.CharField(max_length=128)
    billing_address = models.TextField(max_length=128, null=True, blank=True)
    billing_landmark = models.CharField(max_length=128, null=True)
    billing_state = models.CharField(max_length=128, null=True)
    billing_city = models.CharField(max_length=128, null=True)

    billing_latitude = models.TextField(max_length=128, null=True, blank=True)
    billing_longitude = models.TextField(max_length=128, null=True, blank=True)

    delivery_date = models.DateField(null=True, blank=True)
    order_status = models.CharField(choices=ORDER_CHOICES,max_length=5, null=False, default=10)
    payment_method = models.CharField(max_length=128, null=False)
    payment_status = models.CharField(choices=PAYMENT_CHOICES,max_length=5, null=False)

    assigned_time = models.DateTimeField(null=True, blank=True)
    delivery_agent_is_accept = models.BooleanField(null=True,blank=True)
    delivery_agent_accepted_time = models.DateTimeField(null=True, blank=True)
    delivery_agent_declined_time = models.DateTimeField(null=True, blank=True)
    delivery_agent_declined_reason = models.CharField(choices=DELIVERY_AGENT_DECLINED_CHOICES,max_length=100, null=True,blank=True)
    delivery_agent_declined_reason_text = models.TextField(null=True, blank=True)
    pickup_status = models.CharField(max_length=256, choices=PICKUP_CHOICES,null=True,blank=True)
    pickup_time = models.DateTimeField(null=True, blank=True)
    delivered_time = models.DateTimeField(null=True, blank=True)

    total_amt = models.FloatField()
    wallet_amount = models.FloatField(default=0, null=True, blank=True) # used in this order (as discount)
    voucher_amount = models.FloatField(default=0, null=True, blank=True) # used in this order (as discount)

    card_name = models.CharField(max_length=128, null=True, blank=True)
    card_number = models.CharField(max_length=128, null=True, blank=True)
    transaction_id = models.CharField(max_length=128, null=True, blank=True)
    payment_order_id = models.CharField(max_length=128, null=True, blank=True)
    delivery_note = models.TextField(null=True,blank=True)

    order_no = models.IntegerField()
    order_id = models.TextField(null=True,blank=True)
    is_express_delivery = models.BooleanField(default=False)
    delivery_charge = models.FloatField(null=True,blank=True)

    is_manual = models.BooleanField(default=False)

    class Meta:
        verbose_name = _('Order')
        verbose_name_plural = _('Orders')
        ordering = ('-date_added',)

    def __str__(self):
        return f"{self.order_id} - {self.customer} - {self.order_status}"

    def get_order_items(self):
        return OrderItem.objects.filter(order=self)

    def get_order_number(self):
        orders = Orders.objects.filter(customer=self.customer, is_deleted=False).exclude(order_status=40, pk=self.pk)
        number = 1

        if orders.filter(date_added__lte=self.date_added).exists():
            number += orders.filter(date_added__lte=self.date_added).count()

        return number

    def get_full_address(self):
        address = ''
        if self.billing_address:
            address += f"House number: {self.billing_address} "
        if self.billing_landmark:
            address += f"Building number: {self.billing_landmark} "
        if self.billing_street:
            address += f"Street Number: {self.billing_street}"
        return address

    def get_full_timeslot(self):
        if not self.delivery_date:
            return "-"
        date = self.delivery_date.strftime('%d-%m-%Y')

        if self.time_slot:
            return f"{date} - {self.time_slot}"
        return f"{date}"

    def get_product_total(self):
        order_items = self.orderitem_set.filter(is_deleted=False).annotate(total=F('qty') * F('price'))

        total = order_items.aggregate(Sum('total')).get('total__sum', 0) or 0

        return round(total, 2)


class OrderItem(UserBaseModel):
    order = models.ForeignKey(Orders, on_delete=models.CASCADE, )
    product_variant = models.ForeignKey(ProductVariant, on_delete=models.CASCADE)
    batch = models.ForeignKey(Batch, on_delete=models.CASCADE, null=True, blank=True)

    qty = models.DecimalField(default=0.00, decimal_places=2, max_digits=15,validators=[MinValueValidator(Decimal('0.00'))])
    price = models.DecimalField(default=0.00, decimal_places=2, max_digits=15,validators=[MinValueValidator(Decimal('0.00'))])
    status = models.PositiveIntegerField(default=10, choices=VENDOR_CHOICES,null=True,blank=True)

    igst_rate = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    cgst_rate = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    sgst_rate = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    igst_amount = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    cgst_amount = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    sgst_amount = models.DecimalField(default=0.00, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    is_cancelled = models.BooleanField(default=False)
    date_cancelled = models.DateTimeField(blank=True, null=True)

    class Meta:
        ordering = ('qty',)
        verbose_name = 'order item'
        verbose_name_plural = 'order items'

    def total(self):
        total = (self.qty * self.price)

        return(total)

    def __str__(self):
        return f"{self.product_variant} - {self.order.customer}"


class Booking(UserBaseModel):
    product_variant = models.ForeignKey(ProductVariant, on_delete=models.CASCADE, )
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, )
    message = models.TextField()
    status = models.CharField(max_length=10,choices=BOOKING_STATUS_CHOICES)
    order = models.ForeignKey(Orders, on_delete=models.CASCADE, null=True, blank=True)

    class Meta:
        verbose_name = 'booking'
        verbose_name_plural = 'bookings'
        ordering = ('-date_added', 'status')

    def __str__(self):
        return str(self.customer.name)


# class DeliveryCharge(BaseModel):
#     from_location = models.ForeignKey("warehouses.Zone", limit_choices_to={'is_deleted': False},  on_delete=models.CASCADE, related_name='from_location')
#     to_location = models.ForeignKey("warehouses.Zone", limit_choices_to={'is_deleted': False},  on_delete=models.CASCADE, related_name='to_location')
#     charge = models.DecimalField(default=0.0, decimal_places=3, max_digits=15,validators=[MinValueValidator(Decimal('0.00'))])
#     express_charge = models.DecimalField(default=0.0, decimal_places=3, max_digits=15,validators=[MinValueValidator(Decimal('0.00'))])
#     distance = models.TextField(blank=True, null=True)

#     class Meta:
#         verbose_name = 'delivery_charge'
#         verbose_name_plural = 'delivery_charges'

#     def __str__(self):
        # return f"{self.from_location} - {self.to_location}"