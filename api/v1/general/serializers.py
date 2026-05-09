import datetime
import decimal
from django.db.models import Sum
from django.urls import reverse

from rest_framework import pagination
from rest_framework import serializers

from offers.models import Offers
from products.models import Category, ProductVariant, SubCategory, ProductImages, Product
from users.models import Wishlistitem, CartItem
from vendors.models import Vendor
from general.models import Batch, DeliveryCharge
from web.models import ProductReview, SpotlightBanner
from customers.models import Customer
from purchases.models import Purchase
from sales.models import Sale
from main.models import AppUpdate


class BestOfferSerializer(serializers.ModelSerializer):
    product_name = serializers.SerializerMethodField()
    # product_name_arabic = serializers.SerializerMethodField()
    mrp = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()
    is_cart = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    # category_arabic = serializers.SerializerMethodField()
    subcategory = serializers.SerializerMethodField()
    # subcategory_arabic = serializers.SerializerMethodField()
    rating = serializers.SerializerMethodField()
    retail_price = serializers.SerializerMethodField()
    offer_price = serializers.SerializerMethodField()
    is_book_now_button = serializers.SerializerMethodField()

    class Meta:
        model = Offers
        fields = '__all__'

    def get_product_name(self, instance):
        if instance.product_variant:
            return instance.product_variant.get_fullname()
        return instance.title

    # def get_product_name_arabic(self, instance):
    #     if instance.product_variant:
    #         return instance.product_variant.get_arabic_name()
    #     return instance.title

    def get_mrp(self, instance):
        if instance.product_variant:
            mrp = instance.product_variant.mrp
        return mrp

    def get_image(self, instance):
        request = self.context.get("request")
        if instance.image:
            image_url = instance.image.url
            return request.build_absolute_uri(image_url)
        elif instance.product_variant:
            if instance.product_variant.image:
                image_url = instance.product_variant.image.url
                return request.build_absolute_uri(image_url)
        return ""

    def get_is_cart(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if CartItem.objects.filter(product_variant=instance.product_variant, customer__user=request.user).exists():
                return True
            return False
        else:
            return False

    def get_category(self, instance):
        if instance.category:
            return instance.category.name
        elif instance.product_variant:
            return instance.product_variant.product.category.name
        return ''

    # def get_category_arabic(self, instance):
    #     if instance.category:
    #         return instance.category.arabic_name
    #     elif instance.product_variant:
    #         return instance.product_variant.product.category.arabic_name
    #     return ''

    def get_subcategory(self, instance):
        if instance.subcategory:
            return instance.subcategory.name
        elif instance.product_variant:
            return instance.product_variant.product.subcategory.name
        return ''

    # def get_subcategory_arabic(self, instance):
    #     if instance.subcategory:
    #         return instance.subcategory.arabic_name
    #     elif instance.product_variant:
    #         return instance.product_variant.product.subcategory.arabic_name
    #     return ''

    def get_rating(self, instance):
        if instance.product_variant:
            rating = '{0:.1f}'.format(instance.product_variant.current_rating)
            return str(rating)
        return 0

    def get_retail_price(self, instance):
        """
        if location exists the batch retail price is taken, if not exists the retail price is picked on product variant model
        :param instance:
        """
        request = self.context.get('request')

        if instance.product_variant:
            if 'zone' in request.session:
                zone_in_session = request.session.get('zone', '')
                batch_instance = Batch.objects.filter(product_variant=instance.product_variant, warehouse__deliverable_location__in=[zone_in_session]).first()
                if batch_instance:
                    return batch_instance.retail_price
                else:
                    return instance.product_variant.retail_price
            else:
                return instance.product_variant.retail_price

    def get_is_book_now_button(self, instance):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if zone:
            # if a batch with zero stock exits it returns True
            variant = instance.product_variant

            if variant:
                if not variant.is_special_variant:
                    if Batch.objects.filter(product_variant=variant, stock__gt=0, warehouse__deliverable_location__in=[zone]).exists():
                        return False
                    elif Batch.objects.filter(product_variant=variant, stock__gt=0).exists():
                        return False
                    else:
                        return True
                else:
                    available_stock = 0
                    special_variant = variant.special_variant_added
                    variants = special_variant.product_variant.all()
                    all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False)
                    if zone:
                        all_batches = all_batches.filter(warehouse__deliverable_location__in=[zone])

                    for variant_item in variants:
                        if not all_batches.filter(product_variant_id=variant_item.pk).exists():
                            return True
                        stock = all_batches.filter(product_variant_id=variant_item.pk).aggregate(stock=Sum('stock')).get('stock', 0)
                        available_stock = min(stock, available_stock) if available_stock else stock

                    return available_stock <= 0 # True if there are no stock

        return None # offer is for product/category or zone is not selected

    def get_offer_price(self, instance):
        batch_instance = Batch.objects.filter(product_variant=instance.product_variant).first()

        if batch_instance:
            retail_price = batch_instance.retail_price
        else:
            retail_price = instance.product_variant.retail_price

        offer_price = retail_price - (retail_price * instance.offer_percentage / 100)

        return round(offer_price, 2)


class SubCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = SubCategory
        fields = ['name', 'pk']
        # fields = ['name', 'pk', 'arabic_name']


class CategorySerializer(serializers.ModelSerializer):
    
    sub_category = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = ['name', 'is_featured', 'pk', 'sub_category', 'image']

    def get_sub_category(self, instance):
        sub_category = SubCategory.objects.filter(category=instance)
        serialized = SubCategorySerializer(sub_category, many=True)
        return serialized.data


class SubCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = SubCategory
        fields = ['name',  'pk', 'category']
        # fields = ['name',  'pk', 'category', 'arabic_name']


class BestSellersSerializer(serializers.ModelSerializer):
    title = serializers.SerializerMethodField()
    # arabic_title = serializers.SerializerMethodField()
    is_wishlist = serializers.SerializerMethodField()
    is_cart = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    # category_arabic_name = serializers.SerializerMethodField()
    rating = serializers.SerializerMethodField()
    retail_price = serializers.SerializerMethodField()
    offer_price = serializers.SerializerMethodField()
    is_book_now_button = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        fields = ['id', 'title', 'image', 'mrp', 'current_rating', 'is_wishlist', 'is_cart', 'category', 'warranty',
                  'rating', 'retail_price', 'is_book_now_button', 'offer_price']
                #   'category_arabic_name', 'arabic_title', 'rating', 'retail_price', 'is_book_now_button', 'offer_price']

    def get_is_wishlist(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if Wishlistitem.objects.filter(product_variant=instance, customer__user=request.user).exists():
                return True
            return False
        else:
            return False

    def get_title(self, instance):
        return str(instance)

    # def get_arabic_title(self, instance):
    #     return str(instance.get_arabic_name())

    def get_is_cart(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if CartItem.objects.filter(product_variant=instance, customer__user=request.user).exists():
                return True
            return False
        else:
            return False

    def get_category(self, instance):
        if instance.product.category:
            return instance.product.category.name

    # def get_category_arabic_name(self, instance):
    #     if instance.product.category:
    #         return instance.product.category.arabic_name

    def get_rating(self, instance):
        return round(instance.current_rating, 1)

    def get_is_book_now_button(self, instance):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if zone:
            if not instance.is_special_variant:
                # if a batch with zero stock exits it returns True
                if Batch.objects.filter(product_variant=instance, stock__gt=0, warehouse__deliverable_location__in=[zone]).exists():
                    return False
                elif  Batch.objects.filter(product_variant=instance, stock__gt=0).exists():
                    return False
                else:
                    return True
            else:
                available_stock = 0
                special_variant = instance.special_variant_added
                variants = special_variant.product_variant.all()
                all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False)
                if zone:
                    all_batches = all_batches.filter(warehouse__deliverable_location__in=[zone])

                for variant_item in variants:
                    if not all_batches.filter(product_variant_id=variant_item.pk).exists():
                        return True
                    stock = all_batches.filter(product_variant_id=variant_item.pk).aggregate(stock=Sum('stock')).get('stock', 0)
                    available_stock = min(stock, available_stock) if available_stock else stock

                return available_stock <= 0 # True if there are no stock

        else:
            return None

    def get_retail_price(self, instance):
        """
        if location exists the batch retail price is taken, if not exists the retail price is picked on product variant model
        :param instance:
        """
        request = self.context.get('request')
        retail_price = round(instance.retail_price, 2)

        if 'zone' in request.session:
            zone_in_session = request.session.get('zone', '')
            batch_instance = Batch.objects.filter(product_variant=instance, warehouse__deliverable_location__in=[zone_in_session]).first()

            if batch_instance:
                retail_price = round(batch_instance.retail_price, 2)

        now = datetime.datetime.now()
        product_offers = Offers.objects.filter(is_deleted=False, start_time__lte=now, end_time__gte=now)

        if product_offers.exists():
            offer = None
            if product_offers.filter(product_variant=instance).order_by('offer_percentage').exists():
                offer = product_offers.filter(product_variant=instance).order_by('offer_percentage').last()
            elif product_offers.filter(category=instance.product.category).order_by('offer_percentage').exists():
                offer = product_offers.filter(category=instance.product.category).order_by('offer_percentage').last()
            elif product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').exists():
                offer = product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').last()

            if offer:
                offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

                return round(offer_price, 2)
        return retail_price


    def get_offer_price(self, instance):
        now = datetime.datetime.now()
        offer = None

        batch_instance = Batch.objects.filter(product_variant=instance).first()
        product_offers = Offers.objects.filter(is_deleted=False, start_time__lte=now, end_time__gte=now)

        if product_offers.exists():
            if product_offers.filter(product_variant=instance).order_by('offer_percentage').exists():
                offer = product_offers.filter(product_variant=instance).order_by('offer_percentage').last()

            elif product_offers.filter(category=instance.product.category).order_by('offer_percentage').exists():
                offer = product_offers.filter(category=instance.product.category).order_by('offer_percentage').last()

            elif product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').exists():
                offer = product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').last()

            if offer:
                if batch_instance:
                    retail_price = batch_instance.retail_price
                else:
                    retail_price = instance.retail_price

                offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

                return round(offer_price, 2)
            else:
                return None
        else:
            return None


class ShopSerializer(serializers.ModelSerializer):
    delivery_time = serializers.SerializerMethodField()
    delivery_fee = serializers.SerializerMethodField()
    location_name = serializers.SerializerMethodField()
    # location_name_arabic = serializers.SerializerMethodField()
    latitude = serializers.SerializerMethodField()
    longitude = serializers.SerializerMethodField()
    # zone_name_arabic = serializers.SerializerMethodField()
    zone_name = serializers.SerializerMethodField()
    # arabic_name = serializers.SerializerMethodField()

    class Meta:
        model = Vendor
        fields = ['name', 'id', 'email', 'image', 'location', 'country', 'place', 'address', 'delivery_time',
                  'delivery_fee', 'location_name', 'latitude','longitude',  'zone','zone_name']
        # fields = ['name','arabic_name',  'id', 'email', 'image', 'location', 'country', 'place', 'address', 'delivery_time',
        #           'delivery_fee', 'location_name', 'location_name_arabic', 'latitude','longitude',  'zone','zone_name','zone_name_arabic']
        
    def get_delivery_time(self, instance):
        return "25 m"

    def get_delivery_fee(self, instance):
        request = self.context.get('request')

        if 'zone' in request.session:
            zone_in_session = request.session.get('zone', '')

            if DeliveryCharge.objects.filter(to_zone=zone_in_session,vendor=instance).exists():
                delivery_instance = DeliveryCharge.objects.get(to_zone=zone_in_session,vendor=instance)
                delivery_charge = delivery_instance.normal_charge
            else:
                delivery_charge = 0
        else:
            delivery_charge = 0

        return delivery_charge

    def get_location_name(self, instance):
        return instance.location.location

    def get_latitude(self, instance):
        return instance.location.latitude

    def get_longitude(self, instance):
        return instance.location.longitude

    # def get_zone_name_arabic(self, instance):
    #     return instance.zone.arabic_name

    def get_zone_name(self, instance):
        return instance.zone.municipality

    # def get_arabic_name(self, instance):
    #     return instance.arabic_name

    # def get_location_name_arabic(self, instance):
    #     return instance.location_arabic


class ProductSubVariantsSerializer(serializers.ModelSerializer):
    product_name = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        # exclude = ['auto_id', 'date_added', 'date_updated','mrp','creator','updater','is_deleted']
        fields = ['id', 'product_name', 'title']

    def get_product_name(self, instance):
        return str(instance.get_fullname())


class VairantImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductImages
        fields = ['image', 'pk']


class ProductVariantSerializer(serializers.ModelSerializer):
    is_wishlist = serializers.SerializerMethodField()
    is_cart = serializers.SerializerMethodField()
    unit = serializers.SerializerMethodField()
    unit_of_measurement = serializers.SerializerMethodField()
    product_name = serializers.SerializerMethodField()
    # product_name_arabic = serializers.SerializerMethodField()
    cart_data = serializers.SerializerMethodField()
    off = serializers.SerializerMethodField()
    description = serializers.SerializerMethodField()
    # arabic_description = serializers.SerializerMethodField()
    # arabic_meta_description = serializers.SerializerMethodField()
    meta_description = serializers.SerializerMethodField()
    is_book_now_button = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    # category_arabic = serializers.SerializerMethodField()
    price_data = serializers.SerializerMethodField()
    variants = serializers.SerializerMethodField()
    product_review = serializers.SerializerMethodField()
    variant_images = serializers.SerializerMethodField()
    offer_price = serializers.SerializerMethodField()
    whole_sale = serializers.SerializerMethodField()
    shareable_link = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        exclude = ['auto_id', 'date_added', 'date_updated', 'creator', 'updater', 'deleted_reason', 'mrp']

    def get_is_wishlist(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if Wishlistitem.objects.filter(product_variant=instance, customer__user=request.user).exists():
                return True
        return False

    def get_is_cart(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if CartItem.objects.filter(product_variant=instance, customer__user=request.user).exists():
                return True
        return False

    def get_unit(self, instance):
        if instance.unit.unit:
            return instance.unit.unit
        return ""

    def get_description(self, instance):
        try:
            if instance.is_special_variant:
                return instance.special_variant_added.description or instance.product.description
        except:
            pass
        return instance.product.description

    # def get_arabic_description(self, instance):
    #     try:
    #         if instance.is_special_variant:
    #             return instance.special_variant_added.arabic_description or instance.special_variant_added.description or instance.product.arabic_description or instance.product.description
    #     except:
    #         pass
    #     return instance.product.arabic_description

    # def get_arabic_meta_description(self, instance):
    #     return instance.product.arabic_meta_description

    def get_meta_description(self, instance):
        return instance.product.meta_description

    def get_unit_of_measurement(self, instance):
        if instance.product.unit_of_measurement:
            return instance.product.unit_of_measurement.unit_of_measurement
        return ''

    def get_product_name(self, instance):
        return str(instance.get_fullname())

    # def get_product_name_arabic(self, instance):
    #     return str(instance.get_arabic_name())

    def get_cart_data(self, instance):
        request = self.context.get("request")
        if request.user.is_authenticated:
            if CartItem.objects.filter(product_variant=instance, customer__user=request.user).exists():
                cart_instance = CartItem.objects.get(product_variant=instance, customer__user=request.user)
                return {"id": cart_instance.pk, "qty": cart_instance.qty, }

        return ""

    def get_category(self, instance):
        return instance.product.category.name

    # def get_category_arabic(self, instance):
    #     return instance.product.category.arabic_name

    def get_off(self, instance):
        return 0

    def get_shareable_link(self, instance):
        request = self.context.get('request')
        return request.build_absolute_uri(reverse('web:product', kwargs={'pk': instance.pk}))

    def get_is_book_now_button(self, instance):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if zone:
            if not instance.is_special_variant:
                if Batch.objects.filter(product_variant=instance, stock__gt=0, warehouse__deliverable_location__in=[zone]).exists():
                    return False
                elif  Batch.objects.filter(product_variant=instance, stock__gt=0).exists():
                    return False
                return True # means stock is not avaialable in selected location
            else:
                available_stock = 0
                special_variant = instance.special_variant_added
                variants = special_variant.product_variant.all()
                all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False)
                if zone:
                    all_batches = all_batches.filter(warehouse__deliverable_location__in=[zone])

                for variant_item in variants:
                    if not all_batches.filter(product_variant_id=variant_item.pk).exists():
                        return True
                    stock = all_batches.filter(product_variant_id=variant_item.pk).aggregate(stock=Sum('stock')).get('stock', 0)
                    available_stock = min(stock, available_stock) if available_stock else stock

                return available_stock <= 0 # True if there are no stock

        return None

    def get_price_data(self, instance):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        off = ((instance.mrp - instance.retail_price) / instance.mrp) * 100
        price_data = {'mrp': instance.mrp, 'retail_price': instance.retail_price, 'off': round(off, 1)}

        if zone:
            # if a batch with zero stock exits it returns True
            if Batch.objects.filter(is_deleted=False, product_variant=instance, warehouse__deliverable_location__in=[zone]).exists():
                batch_instances = Batch.objects.filter(is_deleted=False, product_variant=instance,warehouse__deliverable_location__in=[zone]).order_by('-date_added').first()
                off = ((batch_instances.mrp - batch_instances.retail_price) / batch_instances.mrp) * 100
                price_data = {'mrp': batch_instances.mrp, 'retail_price': batch_instances.retail_price, 'off': round(off, 1)}

        now = datetime.datetime.now()
        product_offers = Offers.objects.filter(is_deleted=False, start_time__lte=now, end_time__gte=now)

        if product_offers.exists():
            offer = None
            if product_offers.filter(product_variant=instance).order_by('offer_percentage').exists():
                offer = product_offers.filter(product_variant=instance).order_by('offer_percentage').last()
            elif product_offers.filter(category=instance.product.category).order_by('offer_percentage').exists():
                offer = product_offers.filter(category=instance.product.category).order_by('offer_percentage').last()
            elif product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').exists():
                offer = product_offers.filter(subcategory=instance.product.subcategory).order_by('offer_percentage').last()

            if offer:
                offer_price = price_data['retail_price'] - (price_data['retail_price'] * offer.offer_percentage / 100)
                off = ((price_data['mrp'] - offer_price) / price_data['mrp']) * 100
                price_data["off"] = round(off, 1)
                price_data["retail_price"] = round(offer_price, 2)

        return price_data

    def get_variants(self, instance):
        request = self.context.get("request")
        variant_instances = ProductVariant.objects.filter(product=instance.product, is_admin_approved=True).exclude(pk=instance.pk)
        serialized = ProductSubVariantsSerializer(variant_instances, context={"request": request}, many=True)
        return serialized.data

    def get_product_review(self, instance):
        product_review_instances_count = ProductReview.objects.filter(product_variant=instance, is_deleted=False).count()
        reviews = {"total_customer_rating": str(product_review_instances_count),
                   "product_rating": str(round(instance.current_rating, 1))}
        return reviews

    def get_variant_images(self, instance):
        request = self.context.get("request")
        image_instances = ProductImages.objects.filter(product_variant=instance)

        serialized = VairantImageSerializer(image_instances, context={"request": request}, many=True)

        return serialized.data

    def get_offer_price(self, instance):
        now = datetime.datetime.now()
        offer = None

        batch_instance = Batch.objects.filter(product_variant=instance).first()

        if Offers.objects.filter(product_variant=instance, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(product_variant=instance, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(category=instance.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(category=instance.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(subcategory=instance.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(subcategory=instance.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        if offer:
            if batch_instance:
                retail_price = batch_instance.retail_price
            else:
                retail_price = instance.retail_price

            offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

            return round(offer_price, 2)
        else:
            return None

    def get_whole_sale(self, instance):
        if instance.whole_sale_quantity == 0:
            return {'is_available': False}

        all_batches = Batch.objects.filter(is_deleted=False, product_variant=instance)

        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if all_batches.exists():
            if zone and all_batches.filter(warehouse__deliverable_location__in=[zone]).exists():
                batch = all_batches.filter(warehouse__deliverable_location__in=[zone]).order_by('-date_added').first()
                price = batch.whole_sale_price
                retail_price = batch.retail_price
            else:
                batch = all_batches.first()
                price = batch.whole_sale_price
                retail_price = batch.retail_price

        else:
            retail_price = instance.retail_price
            price = instance.whole_sale_price

        return {
            "is_available": True,
            "item_price": price,
            "minimum_quantity": instance.whole_sale_quantity,
            "total_rate": (price * instance.whole_sale_quantity),
            "total_discount": (retail_price * instance.whole_sale_quantity) - (price * instance.whole_sale_quantity),
        }


class OfferSlidersSerializer(serializers.ModelSerializer):
    category = serializers.SerializerMethodField()
    subcategory = serializers.SerializerMethodField()
    product_variant_name = serializers.SerializerMethodField()
    # product_variant_name_arabic = serializers.SerializerMethodField()

    class Meta:
        model = Offers
        fields = '__all__'

    def get_category(self, instance):
        if instance.category:
            return {'name': instance.category.name, 'id': instance.category.pk}
                    # 'arabic_name': instance.category.arabic_name, }

    def get_subcategory(self, instance):
        if instance.subcategory:
            return {'name': instance.subcategory.name, 'id': instance.subcategory.id}
                    # 'arabic_name': instance.subcategory.arabic_name, }

    def get_product_variant_name(self, instance):
        if instance.product_variant:
            return instance.product_variant.get_fullname()

    # def get_product_variant_name_arabic(self, instance):
    #     if instance.product_variant:
    #         return instance.product_variant.get_arabic_name()


class ProductReviewSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()

    class Meta:
        model = ProductReview
        fields = ['rating', 'review', 'name', 'image']

    def get_name(self, instance):
        if instance.creator:
            customer_instance = Customer.objects.get(user=instance.creator)
            return customer_instance.name

    def get_image(self, instance):
        customer_instance = Customer.objects.get(user=instance.creator)
        request = self.context.get('request')
        if customer_instance.image:
            image_url = customer_instance.image.url
            return request.build_absolute_uri(image_url)


class PurchaseExportSerializer(serializers.ModelSerializer):
    supplier_name = serializers.SerializerMethodField()
    warehouse_name = serializers.SerializerMethodField()

    class Meta:
        model = Purchase
        fields = ['date', 'purchase_no', 'purchase_id', 'warehouse_name', 'supplier_name', 'product_total', 'discount',
                  'round_off', 'paid', 'payment_method']

    def get_supplier_name(self, instance):
        if instance.supplier:
            return instance.supplier.name
        else:
            return "-"

    def get_warehouse_name(self, instance):
        if instance.warehouse:
            return instance.warehouse.name
        else:
            return "-"


class SaleExportSerializer(serializers.ModelSerializer):
    warehouse_name = serializers.SerializerMethodField()

    class Meta:
        model = Sale
        exclude = ['id', 'is_deleted', 'date_added', 'date_updated', 'deleted_reason', 'is_updated', 'add_gst',
                   'customer', 'creator', 'updater', 'auto_id', 'receipt_voucher', 'warehouse', 'sale_prefix']

    def get_warehouse_name(self, instance):
        if instance.warehouse:
            return instance.warehouse.name
        else:
            return "-"


class VariantExportSerializer(serializers.ModelSerializer):
    product_name = serializers.SerializerMethodField()
    unit_name = serializers.SerializerMethodField()
    # warehouse_name = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        exclude = ['id', 'product', 'warehouse', 'unit', 'is_deleted', 'auto_id', 'warranty',
                   'deleted_reason', 'is_default', 'creator', 'updater', 'image', 'date_added',
                   'date_updated']

    def get_product_name(self, instance):
        if instance.product:
            return instance.product.name
        else:
            return "-"

    def get_unit_name(self, instance):
        if instance.unit:
            return instance.unit.unit
        else:
            return "-"

    # def get_warehouse_name(self, instance):
    #     if instance.warehouse:
    #         return instance.warehouse.name
    #     else:
    #         return "-"


class ProductExportSerializer(serializers.ModelSerializer):
    brand_name = serializers.SerializerMethodField()
    category_name = serializers.SerializerMethodField()
    subcategory_name = serializers.SerializerMethodField()
    hsn_code = serializers.SerializerMethodField()
    vendor_name = serializers.SerializerMethodField()
    total_stock = serializers.SerializerMethodField()
    unit_of_measurement_name = serializers.SerializerMethodField()

    class Meta:
        model = Product
        exclude = ['id', 'is_deleted', 'date_added', 'date_updated', 'deleted_reason', 'creator', 'updater', 'auto_id',
                    'image', 'brand', 'category', 'subcategory', 'hsn', 'vendor', 'special_category', 'unit_of_measurement']
                #    'arabic_name', 'image', 'brand', 'category', 'subcategory', 'hsn', 'vendor']

    def get_brand_name(self, instance):
        if instance.brand:
            return instance.brand.name
        else:
            return "-"

    def get_category_name(self, instance):
        if instance.category:
            return instance.category.name
        else:
            return "-"

    def get_unit_of_measurement_name(self, instance):
        if instance.unit_of_measurement:
            return instance.unit_of_measurement.unit_of_measurement
        else:
            return "-"

    def get_subcategory_name(self, instance):
        if instance.subcategory:
            return instance.subcategory.name
        else:
            return "-"

    def get_hsn_code(self, instance):
        if instance.hsn:
            return instance.hsn.hsn_number
        else:
            return "-"

    def get_vendor_name(self, instance):
        if instance.vendor:
            return instance.vendor.name
        else:
            return "-"

    def get_total_stock(self,instance):
        # total_stock = get_all_stock(instance)
        return instance.total_stock()


class BannerSerializer(serializers.ModelSerializer):

    class Meta:
        model = SpotlightBanner
        fields = "__all__"


class AppAndroidUpdateSerializer(serializers.ModelSerializer):
    app_version  = serializers.CharField(source="android_version")
    force_upgrade  = serializers.BooleanField(source="android_force_upgrade")
    recommended_upgrade  = serializers.BooleanField(source="android_recommended_upgrade")
    class Meta:
        model = AppUpdate
        fields = ('id', 'app_version', 'force_upgrade', 'recommended_upgrade')

class AppIOSUpdateSerializer(serializers.ModelSerializer):
    app_version  = serializers.CharField(source="ios_version")
    force_upgrade  = serializers.BooleanField(source="ios_force_upgrade")
    recommended_upgrade  = serializers.BooleanField(source="ios_recommended_upgrade")
    class Meta:
        model = AppUpdate
        fields = ('id', 'app_version', 'force_upgrade', 'recommended_upgrade')


class VariantSerializer(serializers.ModelSerializer):
    title = serializers.SerializerMethodField()
    stock = serializers.SerializerMethodField()
    price = serializers.SerializerMethodField()
    variant = serializers.SerializerMethodField()

    class Meta:
        model = ProductVariant
        fields = ['id', 'title', 'stock', 'price', 'image', 'variant']

    def get_title(self, instance):
        variation_type = self.context.get('variation_type')

        if variation_type == "colour" and instance.colour_variation:
            title = instance.colour_variation.name
        elif variation_type == "size" and instance.size_variation:
            title = instance.size_variation.name
        elif variation_type == "other" and instance.other_variation:
            title = instance.other_variation.name
        else:
            title = instance.title

        return title

    def get_stock(self, instance):
        if instance.is_special_variant:
            return instance.total_stock() > 0

        else:
            batches = self.context.get('batches')
            if batches.filter(product_variant_id=instance.pk, stock__gt=0).exists():
                return True
        return False

    def get_price(self, instance):
        batches = self.context.get('batches')
        if batches.filter(product_variant_id=instance.pk).exists():
             return batches.filter(product_variant_id=instance.pk).first().retail_price
        return instance.retail_price

    def get_variant(self, instance):
        is_api = self.context.get('is_api')
        if is_api:
            return instance.title
        return instance
