from __future__ import unicode_literals
from django.db import models
from decimal import Decimal
from django.db.models import Sum
from django.core.validators import MinValueValidator
from django.utils.translation import ugettext_lazy as _
from main.models import BaseModel
from versatileimagefield.fields import VersatileImageField
# from general.models import Batch
import datetime
from django.utils import timezone
from general.models import Batch
from offers.models import Offers

DAY_TYPE_CHOICES = (
    ("day", 'Day'),
    ("hours", 'Hours'),
)


class Category(BaseModel):
    name = models.CharField(max_length=128)
    image = VersatileImageField(upload_to="media/", blank=True, null=True)
    is_featured = models.BooleanField(default=False)
    # arabic_name = models.CharField(max_length=128,null=True,blank=True)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_category'
        verbose_name = _('category')
        verbose_name_plural = _('categories')
        ordering = ('name',)

    def __str__(self):
        return str(self.name)

    def sub_category_names(self):
        names = SubCategory.objects.filter(is_deleted=False, category=self).values_list('name', flat=True)
        return ', '.join(names)

    def get_subcategory(self):
        return SubCategory.objects.filter(is_deleted=False, category=self)

    def get_products(self):
        return ProductVariant.objects.filter(product__category=self, is_admin_approved=True, is_deleted=False,is_default=True).order_by("?")[:20]


class SubCategory(BaseModel):
    category = models.ForeignKey("products.Category", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    name = models.CharField(max_length=128)
    # arabic_name = models.CharField(max_length=128,null=True,blank=True)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_sub_category'
        verbose_name = _('Sub category')
        verbose_name_plural = _('Sub categories')
        ordering = ('name',)

    def __str__(self):
        return str(self.name)


class SpecialCategory(BaseModel):
    name = models.CharField(max_length=128)

    class Meta:
        db_table = 'products_special_category'
        verbose_name = _('Special Category')
        verbose_name_plural = _('Special Categories')
        ordering = ('name',)

    def __str__(self):
        return str(self.name)

    class Admin:
        list_display = ['auto_id', 'name']


class Brand(BaseModel):
    name = models.CharField(max_length=128)
    # arabic_name = models.CharField(max_length=128,null=True,blank=True)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_brand'
        verbose_name = _('brand')
        verbose_name_plural = _('brands')
        ordering = ('name',)

    def __str__(self):
        return str(self.name)


class UnitOfMeasurement(BaseModel):
    unit_of_measurement = models.CharField(max_length=128)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_unit_measurement'
        verbose_name = _('Unit measurement')
        verbose_name_plural = _('Unit measurements')
        ordering = ('auto_id',)

    def __str__(self):
        return str(self.unit_of_measurement)


class Unit(BaseModel):
    unit_of_measurement = models.ForeignKey("products.UnitOfMeasurement", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    unit = models.CharField(max_length=128)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_unit'
        verbose_name = _('Proudct unit')
        verbose_name_plural = _('Proudct unit')
        ordering = ('unit',)

    def __str__(self):
        return str(self.unit)


class HsnCodes(BaseModel):
    unit = models.ForeignKey("products.Unit", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    name = models.CharField(max_length=128)
    hsn_number = models.CharField(max_length=128)
    description = models.CharField(max_length=30, blank=True, null=True)

    igst_rate = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    sgst_rate = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    cgst_rate = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'product_hsn_code'
        verbose_name = _('product_hsn_code')
        verbose_name_plural = _('product_hsn_codes')
        ordering = ('name',)

    def __str__(self):
        return f"{self.hsn_number} - {self.name}"


class VariationType(models.Model):
    colour = 10
    size = 20
    other = 30

    VARIATION_TYPES = (
        (colour, "Colour"),
        (size, "Size"),
        (other, "Others"),
    )

    name = models.CharField(verbose_name="Variation Name", max_length=128)
    variation_type = models.SmallIntegerField(choices=VARIATION_TYPES)
    other_type = models.CharField(verbose_name="Type of variation (if other)", max_length=128, blank=True, null=True)

    is_deleted = models.BooleanField(default=False)

    class Meta:
        db_table = 'product_variation_type'
        verbose_name = _('Product variation Type')
        verbose_name_plural = _('Product variation Types')
        ordering = ('name',)

    def __str__(self):
        if self.variation_type == 30:
            if self.other_type:
                return f"{self.other_type}: {self.name}"
            return self.name
        return f"{self.get_variation_type_display()}: {self.name}"


class Product(BaseModel):
    brand = models.ForeignKey(Brand, null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    subcategory = models.ForeignKey(SubCategory, null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    special_category = models.ForeignKey(SpecialCategory, null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    unit_of_measurement = models.ForeignKey(UnitOfMeasurement, null=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    hsn = models.ForeignKey('products.HsnCodes', blank=True, null=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    vendor = models.ForeignKey("vendors.Vendor", null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)

    name = models.CharField(max_length=128)
    # arabic_name = models.CharField(max_length=128,null=True,blank=True)
    image = VersatileImageField(upload_to="media/", null=True)

    description = models.TextField(blank=True, null=True)
    # arabic_description = models.TextField(blank=True, null=True)
    # arabic_meta_description = models.TextField(blank=True, null=True)
    meta_description = models.CharField(max_length=128)

    is_active = models.BooleanField(default=True)
    is_varying_price = models.BooleanField(default=False)
    has_special_variant = models.BooleanField(default=False)

    cancellable_duration = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    cancellable_duration_type = models.CharField(max_length=7,choices=DAY_TYPE_CHOICES)
    returnable_duration = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    returnable_duration_type = models.CharField(max_length=7,choices=DAY_TYPE_CHOICES)

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_product'
        verbose_name = _('product')
        verbose_name_plural = _('products')
        ordering = ('name',)

    def __str__(self):
        return str(self.name)

    def total_stock(self):
        stock = 0
        if Batch.objects.filter(product_variant__product=self).exists():
            stock = Batch.objects.filter(product_variant__product=self).aggregate(stock=Sum('stock')).get('stock', 0)
            self.stock = stock
            self.save()
        return stock

    def get_variant_names(self):
        names = ProductVariant.objects.filter(is_deleted=False, is_admin_approved=True, product_id=self.pk).values_list('title', flat=True)
        return ', '.join(names)

    def get_product_name(self):
        if self.brand:
            return str(self.brand.name + " - " + self.name)
        else:
            return str(self.name)


class ProductVariant(BaseModel):
    product = models.ForeignKey("products.Product", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    unit = models.ForeignKey("products.Unit", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    warehouse = models.ForeignKey("warehouses.Warehouse", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, null=True)
    
    colour_variation = models.ForeignKey(VariationType, related_name="colour", on_delete=models.CASCADE, null=True, blank=True)
    size_variation = models.ForeignKey(VariationType, related_name="size", on_delete=models.CASCADE, null=True, blank=True)
    other_variation = models.ForeignKey(VariationType, related_name="other", on_delete=models.CASCADE, null=True, blank=True)

    title = models.CharField(max_length=120)
    product_code = models.CharField(max_length=128, unique=True)
    image = VersatileImageField(upload_to="media/product_variant/", null=True)
    current_rating = models.DecimalField(default=0, decimal_places=1, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    stock = models.DecimalField(default=0, decimal_places=3, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    warranty = models.CharField(max_length=120, blank=True, null=True)

    discount_limit = models.DecimalField(default=0, decimal_places=3, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    low_stock_limit = models.PositiveIntegerField(default=1)
    # tax_percent = models.DecimalField(default=0, decimal_places=3, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    first_time_stock = models.DecimalField(default=0, decimal_places=3, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    batch_number = models.CharField(max_length=128, blank=True, null=True)
    expire_date = models.DateField(null=True, blank=True)
    retail_price = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    manufacturing_date = models.DateField(null=True, blank=True)
    cost = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    mrp = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    commission_percentage = models.DecimalField(decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))], blank=True,null=True)

    whole_sale_quantity = models.DecimalField(default=0, decimal_places=0, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    whole_sale_price = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    tax_included = models.BooleanField(default=False)
    is_featured = models.BooleanField(default=False)
    is_default = models.BooleanField(default=False)
    is_special_variant = models.BooleanField(default=False) # True only if there is a special variant

    # for vendors
    vendor_created = models.BooleanField(default=False)
    is_admin_approved = models.BooleanField(null=True)

    class Meta:
        db_table = 'products_product_variant'
        verbose_name = _('product_variant')
        verbose_name_plural = _('product_variants')
        ordering = ('auto_id',)

    def __str__(self):
        if self.product.brand:
            return f'{self.product.brand} {self.product.name} {self.title}'
        else:
            return f'{self.product.name} {self.title}'

    # def get_arabic_name(self):
    #     if self.product.brand:
    #         if self.product.brand.arabic_name:
    #             return f'{self.product.brand.arabic_name} {self.product.arabic_name if self.product.arabic_name else self.product.name} {self.title}'
    #         else:
    #             return f'{self.product.brand.name} {self.product.arabic_name if self.product.arabic_name else self.product.name} {self.title}'
    #     else:
    #         return f'{self.product.arabic_name if self.product.arabic_name else self.product.name} {self.title}'

    def total_stock(self):
        if not self.is_special_variant:
            # update stock of special variant if there is any
            sp_variants = SpecialVariant.objects.filter(product_variant=self, is_deleted=False)
            if sp_variants.exists():
                for sp_variant_item in sp_variants:
                    print(sp_variant_item.created_variant.total_stock(), '---- total stock: update for specail variant')

            stock = 0
            if Batch.objects.filter(product_variant=self).exists():
                stock = Batch.objects.filter(product_variant=self).aggregate(stock=Sum('stock')).get('stock', 0)
                self.stock = stock
                self.save()
            return stock
        else:
            special_variant = self.special_variant_added
            variants = special_variant.product_variant.all()
            all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0)
            smallest_stock = 0

            for variant_item in variants:
                if not all_batches.filter(product_variant_id=variant_item.pk).exists():
                    self.stock = 0
                    self.save()
                    return 0
                stock = all_batches.filter(product_variant_id=variant_item.pk).aggregate(stock=Sum('stock')).get('stock', 0)
                smallest_stock = min(stock, smallest_stock) if smallest_stock else stock

            self.stock = smallest_stock
            self.save()
            return smallest_stock

    def get_category(self):
        category = Category.objects.get(pk=self.product.category.pk)
        return category.name

    def get_fullname(self):
        if self.product.brand:
            return f'{self.product.brand} {self.product.name} {self.title}'
        else:
            return f'{self.product.name} {self.title}'

    def offer_price(self):
        now = datetime.datetime.now()
        offer = None

        batch_instance = Batch.objects.filter(product_variant=self).first()
        all_offers = Offers.objects.filter(start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage')

        if all_offers.filter(product_variant=self).exists():
            offer = all_offers.filter(product_variant=self).order_by('offer_percentage').last()

        elif all_offers.filter(category=self.product.category).exists():
            offer = all_offers.filter(category=self.product.category).order_by('offer_percentage').last()

        elif all_offers.filter(subcategory=self.product.subcategory).exists():
            offer = all_offers.filter(subcategory=self.product.subcategory).order_by('offer_percentage').last()

        if offer:
            if batch_instance:
                retail_price = batch_instance.retail_price
            else:
                retail_price = self.retail_price

            offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

            return round(offer_price, 2)
        else:
            return None


class ProductImages(BaseModel):
    product_variant = models.ForeignKey("products.ProductVariant", limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE,null=True,blank=True)
    image = VersatileImageField(upload_to="media/", blank=True, null=True)

    is_deleted = models.BooleanField(default=False)

    class Meta:
        db_table = 'products_product_image'
        verbose_name = _('product_image')
        verbose_name_plural = _('product_images')
        ordering = ('auto_id',)

    def __str__(self):
        return str(self.auto_id)


class ProductStock(models.Model):
    product_variant = models.ForeignKey("products.ProductVariant", null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    batch = models.ForeignKey('general.Batch', limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE, blank=True, null=True)
    warehouse = models.ForeignKey("warehouses.Warehouse", null=True, blank=True, limit_choices_to={'is_deleted': False}, on_delete=models.CASCADE)
    category = models.CharField(max_length=128)
    date = models.DateField()
    increment = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    decrement = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])

    class Meta:
        db_table = 'product_stock'
        verbose_name = _('product_stock')
        verbose_name_plural = _('product_stocks')
        ordering = ('date',)

    def __str__(self):
        return str(self.product.name)


class SpecialVariant(BaseModel):
    product_variant = models.ManyToManyField(ProductVariant)
    created_variant = models.OneToOneField(ProductVariant, on_delete=models.CASCADE, related_name='special_variant_added') # creates a product variant for special variant

    name = models.CharField(max_length=128)
    product_code = models.CharField(max_length=128)
    description = models.TextField(blank=True, null=True)
    # arabic_description = models.TextField(blank=True, null=True)

    actual_price = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    amount = models.DecimalField(default=0, decimal_places=2, max_digits=15, validators=[MinValueValidator(Decimal('0.00'))])
    quantity = models.DecimalField('Number of stock (if only product variant)', default=1, decimal_places=2, max_digits=15)

    class Meta:
        db_table = 'special_variant'
        verbose_name = _('Special Variant')
        verbose_name_plural = _('Special Variants')
        ordering = ('name', )

    def __str__(self):
        return str(self.name)
