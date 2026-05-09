from decimal import Decimal
from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.urls import reverse
from django.core.validators import MinValueValidator

from versatileimagefield.fields import VersatileImageField
from main.models import BaseModel
from orders.models import Orders, OrderItem
from products.models import Category, SubCategory, Brand, ProductVariant
from delivery_agent.models import DeliveryAgents
from customers.models import CustomerAddress, CustomerAccount

RATING_CHOICES = (
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
)

RETURN_CHOICES = (
    ("product_damage","Product Damage"),
    ("size_not_fit", "Size Not Fit"),
    ("others", "Others"),
)

RETURN_TYPES = (
    ("cash","Cash"),
    ("bank", "Bank"),
)


STATUS_CHOICES = (
    ("10", "Pending"),
    ("20", "Accepted"),
    ("30", "Product Collected"),
    ("40", "Reached Store"),
    ("50", "Product Returned"),
    ("60", "Rejected"),
)

PAYMENT_CHOICES = (
    ("10", "Pending"),
    ("20", "Completed"),
)

AGENT_CHOICES = (
    ("10", "Accepted"),
    ("20", "Reached location"),
    ("30", "Picked up"),
    ("40", "Rejected"),
)

SERIAL_CHOICES = (
    ("10", "Verified"),
    ("20", "Not Verified"),
    ("30", "No Serial Number"),
)

class FeauturedCategory(BaseModel):
    category = models.ForeignKey(Category, limit_choices_to={
        'is_deleted': False}, on_delete=models.CASCADE)

    class Meta:
        db_table = 'web_FeauturedCategory'
        verbose_name = _('Feautured Category')
        verbose_name_plural = _('Feautured Categories')

    def __unicode__(self):
        return self.category.name

    def get_subcategory(self):
        return SubCategory.objects.filter(is_deleted=False, category=self)

    def get_products(self):
        return ProductVariant.objects.filter(is_deleted=False, product__category=self.category)


class TrendingCategory(BaseModel):
    category = models.ForeignKey(Category, limit_choices_to={
        'is_deleted': False}, on_delete=models.CASCADE)

    class Meta:
        db_table = 'web_TrendingCategory'
        verbose_name = _('Trending Category')
        verbose_name_plural = _('Trending Categories')

    def __unicode__(self):
        return self.category.name

    def get_subcategory(self):
        return SubCategory.objects.filter(is_deleted=False, category=self)


class ProductReview(BaseModel):
    product_variant = models.ForeignKey(ProductVariant, on_delete=models.CASCADE)
    rating = models.IntegerField(choices=RATING_CHOICES)
    review = models.TextField(null=True, blank=True)

    class Meta:
        verbose_name = _('review')
        verbose_name_plural = _('reviews')

    def __str__(self):
        return f'{self.product_variant.product.name}-{self.product_variant.title} - {self.rating}'


class ProductReturn(BaseModel):
    return_id = models.TextField(null=True,blank=True)
    order_item = models.ForeignKey(OrderItem, on_delete=models.CASCADE)
    order = models.ForeignKey(Orders, on_delete=models.CASCADE)
    customer_address = models.ForeignKey(CustomerAddress, on_delete=models.CASCADE,null=True,blank=True )
    customer_account = models.ForeignKey(CustomerAccount, on_delete=models.CASCADE,null=True,blank=True )

    reason_for_return = models.CharField(max_length=256,choices=RETURN_CHOICES)
    return_type = models.CharField(max_length=256,choices=RETURN_TYPES)
    return_specification = models.TextField(null=True,blank=True)

    status = models.CharField(choices=STATUS_CHOICES,default="10",max_length=100)
    payment_status = models.CharField(choices=PAYMENT_CHOICES,default="10",max_length=100)
    agent_status = models.CharField(max_length=256, choices=AGENT_CHOICES,null=True,blank=True)

    rejected_reason = models.TextField(blank=True,null=True)
    agent_rejected_reason = models.TextField(blank=True,null=True)
    delivery_boy = models.ForeignKey(DeliveryAgents,on_delete=models.CASCADE,null=True,blank=True)
    amount = models.DecimalField(default=0.0, decimal_places=2, max_digits=15,validators=[MinValueValidator(Decimal('0.00'))])

    is_same_product = models.BooleanField(default=False)
    is_damaged_product = models.BooleanField(default=False)
    is_same_quantity = models.BooleanField(default=False)
    damaged_reason = models.TextField(blank=True,null=True)
    serial_status = models.CharField(max_length=256, choices=SERIAL_CHOICES,null=True,blank=True)
    extra_notes = models.TextField(blank=True,null=True)

    customer_name = models.CharField(max_length=50, null=True, blank=True)
    customer_phone = models.CharField(max_length=10, null=True, blank=True)
    customer_street = models.CharField(max_length=128, null=True, blank=True)
    customer_landmark = models.CharField(max_length=128,blank=True, null=True)

    customer_latitude = models.TextField(max_length=128, null=True, blank=True)
    customer_longitude = models.TextField(max_length=128, null=True, blank=True)

    reached_image = models.ImageField(upload_to="media/Returns/", blank=True, null=True)
    is_handover_required = models.BooleanField(default=False)

    class Meta:
        verbose_name = _('product return')
        verbose_name_plural = _('product returns')
        ordering = ('-date_added',)

    def __str__(self):
        return f'{self.order_item.product_variant.title} - {self.order.customer.name}'


class ReturnImage(BaseModel):
    product_return = models.ForeignKey(ProductReturn, on_delete=models.CASCADE )
    image = models.ImageField(upload_to="media/Returns/", blank=True, null=True)

    class Meta:
        db_table = 'return_images'
        verbose_name = _('Return image')
        verbose_name_plural = _('Return images')

    def __str__(self):
        return str(self.product_return.return_id)


class SpotlightBanner(BaseModel):
    BANNER_TYPE = (
        ("primary", "Primary"),
        ("secondary", "Secondary"),
        ("tertiary", "Tertiary"),
    )

    OFFER_TYPE = (
        ("product","Product"),
        ("category", "Category"),
        ("brand", "Brand"),
    )
    product_variant = models.ForeignKey(ProductVariant, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, null=True, blank=True)
    category = models.ForeignKey(Category, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, null=True, blank=True)
    brand = models.ForeignKey(Brand, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, null=True, blank=True)

    offer_type = models.CharField(choices=OFFER_TYPE, null=True, blank=True, max_length=100)
    banner_type = models.CharField(choices=BANNER_TYPE, max_length=100)
    image = VersatileImageField(upload_to="media/")

    class Meta:
        verbose_name = _('spotlight banner')
        verbose_name_plural = _('spotlight banner')

    def __str__(self):
        return str(self.auto_id)

    def get_url(self):
        if self.offer_type == 'product' and self.product_variant:
            return reverse('web:product', kwargs={'pk': self.product_variant_id})
        elif self.offer_type == 'category' and self.category:
            return reverse('web:category', kwargs={'pk': self.category_id})
        elif self.offer_type == 'brand' and self.brand:
            return reverse('web:brand', kwargs={'pk': self.brand_id})
        return '#'


class SocialLinks(models.Model):
    facebook_link = models.URLField()
    instagram_link = models.URLField()
    twitter_link = models.URLField()
    whatsapp_link = models.URLField()

    class Meta:
        verbose_name = _('social links')
        verbose_name_plural = _('social links')

    def __str__(self):
        return str(self.id)
