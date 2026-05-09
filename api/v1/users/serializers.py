import datetime
from api.v1.general.functions import is_zone_exists, get_zone
from customers.models import Customer, Ticket, CustomerAddress, PrivilegePointHistory, CustomerAccount
from django.db.models import Sum, F
from general.models import Batch
from offers.models import Offers, VoucherCode
from orders.models import TimeSlot, Orders, OrderItem, Booking
from rest_framework import serializers
from users.models import Wishlistitem, CartItem, Notification
from web.functions import get_orginal_price, get_mrp
from web.models import ProductReview
from api.v1.users.functions import get_privileged_points, is_eligible_for_return
from delivery_agent.models import DeliveryRating
from web.models import ProductReturn


class PhoneNumberSerializer(serializers.Serializer):
    phone = serializers.CharField()


class CustomerRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ['name', 'phone', 'image','email']


class WishlistSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    # arabic_name = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()
    mrp = serializers.SerializerMethodField()
    price = serializers.SerializerMethodField()
    offer_price = serializers.SerializerMethodField()
    is_wishlist = serializers.SerializerMethodField()
    is_cart = serializers.SerializerMethodField()
    category = serializers.SerializerMethodField()
    current_rating = serializers.SerializerMethodField()
    # arabic_category = serializers.SerializerMethodField()
    is_book_now_button = serializers.SerializerMethodField()

    class Meta:
        model = Wishlistitem
        fields = ['product_variant', 'name', 'image', 'is_wishlist', 'is_cart', 'mrp', 'price', 'category',
                     'is_book_now_button', 'offer_price', 'current_rating',]
                #   'arabic_category', 'arabic_name', 'is_book_now_button', 'offer_price']

    def get_name(self, instances):
        return instances.product_variant.get_fullname()

    # def get_arabic_name(self, instances):
    #     return instances.product_variant.get_arabic_name()

    def get_image(self, instances):
        request = self.context.get('request')
        if instances.product_variant.image:
            image_url = instances.product_variant.image.url
            return request.build_absolute_uri(image_url)

    def get_mrp(self, instances):
        if instances.product_variant.mrp:
            return instances.product_variant.mrp
        
    def get_current_rating(self, instances):
        if instances.product_variant.current_rating:
            return instances.product_variant.current_rating

    def get_price(self, instance):
        """
        if location exists the batch retail price is taken, if not exists the retail price is picked on product variant model
        :param instance:
        """
        request = self.context.get('request')
        variant_instance = instance.product_variant
        retail_price = round(variant_instance.retail_price, 1)

        if 'zone' in request.session:
            zone_in_session = request.session.get('zone', '')
            batch_instance = Batch.objects.filter(product_variant=variant_instance, warehouse__deliverable_location__in=[zone_in_session]).first()

            if batch_instance:
                retail_price = round(batch_instance.retail_price, 2)

        now = datetime.datetime.now()
        product_offers = Offers.objects.filter(is_deleted=False, start_time__lte=now, end_time__gte=now)

        if product_offers.exists():
            offer = None
            if product_offers.filter(product_variant=variant_instance).order_by('offer_percentage').exists():
                offer = product_offers.filter(product_variant=variant_instance).order_by('offer_percentage').last()
            elif product_offers.filter(category=variant_instance.product.category).order_by('offer_percentage').exists():
                offer = product_offers.filter(category=variant_instance.product.category).order_by('offer_percentage').last()
            elif product_offers.filter(subcategory=variant_instance.product.subcategory).order_by('offer_percentage').exists():
                offer = product_offers.filter(subcategory=variant_instance.product.subcategory).order_by('offer_percentage').last()

            if offer:
                offer_price = retail_price - (retail_price * offer.offer_percentage / 100)
                return round(offer_price, 2)

        return retail_price

    def get_is_cart(self, instances):
        request = self.context.get("request")
        if CartItem.objects.filter(product_variant=instances.product_variant, customer__user=request.user).exists():
            return True
        return False

    def get_is_wishlist(self, instances):
        request = self.context.get("request")
        if Wishlistitem.objects.filter(product_variant=instances.product_variant, customer__user=request.user).exists():
            return True
        return False

    def get_category(self, instances):
        if instances.product_variant.product.category:
            return instances.product_variant.product.category.name

    # def get_arabic_category(self, instances):
    #     if instances.product_variant.product.category:
    #         return instances.product_variant.product.category.arabic_name

    def get_is_book_now_button(self, instances):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if zone:
            # if a batch with zero stock exits it returns True
            if Batch.objects.filter(product_variant=instances.product_variant, stock__gt=0, warehouse__deliverable_location__in=[zone]).exists():
                return False
            elif  Batch.objects.filter(product_variant=instances.product_variant, product_variant__product__vendor__zone = zone, stock__gt=0).exists():
                return False
            else:
                return True
        else:
            return None

    def get_offer_price(self, instances):
        now = datetime.datetime.now()
        offer = None

        batch_instance = Batch.objects.filter(product_variant=instances.product_variant).first()

        if Offers.objects.filter(product_variant=instances.product_variant, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(product_variant=instances.product_variant, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(category=instances.product_variant.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(category=instances.product_variant.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(subcategory=instances.product_variant.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(subcategory=instances.product_variant.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        if offer:
            if batch_instance:
                retail_price = batch_instance.retail_price
            else:
                retail_price = instances.product_variant.retail_price

            offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

            return round(offer_price, 2)
        else:
            return None


class CustomerAddressSerializer(serializers.ModelSerializer):
    location_name = serializers.SerializerMethodField()
    latitude = serializers.SerializerMethodField()
    longitude = serializers.SerializerMethodField()
    zone_data = serializers.SerializerMethodField()
    address_type_name = serializers.SerializerMethodField()

    class Meta:
        model = CustomerAddress
        # exclude = ['customer']
        fields = ['name', 'id', 'house_name', 'phone', 'email',  'street', 'city', 'landmark', 'latitude', 'longitude',
                  'state', 'address_type', 'address_type_name', 'is_default','location_name','zone_data']

        read_only_fields = ['location_name','zone_data']

    def get_address_type_name(self, instance):
        if instance.address_type == 10:
            return "Home"
        elif instance.address_type == 20:
            return "Office"

    def get_location_name(self, instance):
        return(instance.location.location)

    def get_latitude(self, instance):
        return(instance.location.latitude)

    def get_longitude(self, instance):
        return(instance.location.longitude)

    def get_zone_data(self, instance):
        return {'id': str(instance.zone.pk), 'name': instance.zone.municipality, 'places': instance.zone.name}


class CartItemSerializer(serializers.ModelSerializer):
    date_added = serializers.SerializerMethodField()
    name = serializers.SerializerMethodField()
    # arabic_name = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()
    mrp = serializers.SerializerMethodField()
    retail_price = serializers.SerializerMethodField()
    offer_price = serializers.SerializerMethodField()
    sub_category = serializers.SerializerMethodField()
    # arabic_sub_category = serializers.SerializerMethodField()
    uom = serializers.SerializerMethodField()

    class Meta:
        model = CartItem
        exclude = ['customer']

    def get_date_added(self, instances):
        return str(instances.date_added)

    def get_name(self, instances):
        return instances.product_variant.get_fullname()

    # def get_arabic_name(self, instances):
    #     return instances.product_variant.get_arabic_name()

    def get_image(self, instances):
        request = self.context.get('request')
        if instances.product_variant.image:
            image_url = instances.product_variant.image.url
            return request.build_absolute_uri(image_url)

    def get_mrp(self, instances):
        request = self.context.get('request')
        return get_mrp(instances.product_variant, request)


    def get_sub_category(self, instances):
        if instances.product_variant.product.subcategory:
            return instances.product_variant.product.subcategory.name

    # def get_arabic_sub_category(self, instances):
    #     if instances.product_variant.product.subcategory:
    #         return instances.product_variant.product.subcategory.arabic_name

    def get_uom(self, instance):
        if instance.product_variant.product.unit_of_measurement:
            return instance.product_variant.product.unit_of_measurement.unit_of_measurement

    def get_retail_price(self, instance):
        request = self.context.get('request')
        # get mrp defined in web.functions
        # return get_orginal_price(instance.product_variant, request)
        """
        if location exists the batch retail price is taken, if not exists the retail price is picked on product variant model
        :param instance:
        """
        request = self.context.get('request')
        variant_instance = instance.product_variant
        retail_price = round(variant_instance.retail_price, 1)

        if 'zone' in request.session:
            zone_in_session = request.session.get('zone', '')
            batch_instance = Batch.objects.filter(product_variant=variant_instance, warehouse__deliverable_location__in=[zone_in_session]).first()

            if batch_instance:
                retail_price = round(batch_instance.retail_price, 2)

        now = datetime.datetime.now()
        product_offers = Offers.objects.filter(is_deleted=False, start_time__lte=now, end_time__gte=now)

        if product_offers.exists():
            offer = None
            if product_offers.filter(product_variant=variant_instance).order_by('offer_percentage').exists():
                offer = product_offers.filter(product_variant=variant_instance).order_by('offer_percentage').last()
            elif product_offers.filter(category=variant_instance.product.category).order_by('offer_percentage').exists():
                offer = product_offers.filter(category=variant_instance.product.category).order_by('offer_percentage').last()
            elif product_offers.filter(subcategory=variant_instance.product.subcategory).order_by('offer_percentage').exists():
                offer = product_offers.filter(subcategory=variant_instance.product.subcategory).order_by('offer_percentage').last()

            if offer:
                offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

                return round(offer_price, 2)
        return retail_price



    def get_offer_price(self, instances):
        now = datetime.datetime.now()
        offer = None

        batch_instance = Batch.objects.filter(product_variant=instances.product_variant).first()

        if Offers.objects.filter(product_variant=instances.product_variant, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(product_variant=instances.product_variant, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(category=instances.product_variant.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(category=instances.product_variant.product.category, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        elif Offers.objects.filter(subcategory=instances.product_variant.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').exists():
            offer = Offers.objects.filter(subcategory=instances.product_variant.product.subcategory, start_time__lte=now, end_time__gte=now, is_deleted=False).order_by('offer_percentage').last()

        if offer:
            if batch_instance:
                retail_price = batch_instance.retail_price
            else:
                retail_price = instances.product_variant.retail_price

            offer_price = retail_price - (retail_price * offer.offer_percentage / 100)

            return round(offer_price, 2)
        else:
            return None


class VoucherSerializer(serializers.ModelSerializer):
    is_applied = serializers.SerializerMethodField()

    class Meta:
        model = VoucherCode
        fields = ['id', 'title', 'description', 'voucher_code', 'percentage', 'is_applied']

    def get_is_applied(self, instances):
        request = self.context.get('request')
        coupon_id = request.session.get('coupon_id', '')
        if coupon_id:
            if str(instances.pk) == coupon_id:
                return True
        else:
            return False


class CustomerSerializer(serializers.ModelSerializer):
    privilege_points = serializers.SerializerMethodField()
    default_address = serializers.SerializerMethodField()

    class Meta:
        model = Customer
        fields = ['phone', 'name', 'email', 'privilege_points', 'default_address', 'image']

    def get_privilege_points(self, instance):
        request = self.context.get('request')
        points = get_privileged_points(request)

        return points

    def get_default_address(self, instances):
        request = self.context.get("request")
        addresses = CustomerAddress.objects.filter(is_default=True, is_deleted=False, customer__user=request.user)
        if addresses.exists():
            serialized = CustomerAddressSerializer(addresses.first())
            return serialized.data


class CustomerProfileUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = ['phone', 'name', 'email']


class TimeSlotSerializer(serializers.ModelSerializer):
    start_time = serializers.SerializerMethodField()
    end_time = serializers.SerializerMethodField()

    class Meta:
        model = TimeSlot
        fields = ['day', 'start_time', 'end_time', 'id']

    def get_start_time(self, instances):
        return instances.start_time.strftime('%I:%M %p')

    def get_end_time(self, instances):
        return instances.end_time.strftime('%I:%M %p')


class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Orders
        fields = ['pk', 'payment_method', 'card_name', 'card_number', 'time_slot', 'delivery_date', 'delivery_note','is_express_delivery']
        optional_fields = ['']


class OrderViewSerializer(serializers.ModelSerializer):
    order_items = serializers.SerializerMethodField()
    order_status = serializers.CharField(source='get_order_status_display')
    class Meta:
        model = Orders
        fields = ['id', 'order_no', 'delivery_charge', 'total_amt', 'order_status', 'delivery_date',  'order_items']

    def get_order_items(self, instance):
        request = self.context.get('request')
        order_items = OrderItem.objects.filter(order=instance)
        order_items_serializer = OrderItemSerializer(order_items, many=True, context={'request': request})
        return order_items_serializer.data


class OrderListSerializer(serializers.ModelSerializer):
    order_status = serializers.CharField(source='get_order_status_display')
    class Meta:
        model = Orders
        fields = ['id', 'order_no', 'delivery_charge', 'total_amt', 'order_status', 'delivery_date']



class OrderItemSerializer(serializers.ModelSerializer):
    user = serializers.SerializerMethodField()
    order_status = serializers.SerializerMethodField()
    is_cancelled = serializers.SerializerMethodField()
    is_returnable = serializers.SerializerMethodField()
    product_image = serializers.SerializerMethodField()
    product_name = serializers.SerializerMethodField()
    # product_name_arabic = serializers.SerializerMethodField()
    order_id = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = '__all__'

    def get_user(self, instances):
        return instances.order.customer.name

    def get_is_returnable(self, instances):
        if instances.order.order_status == "30":
            return is_eligible_for_return(instances.product_variant_id, instances.order_id)
        else:
            return False

    def get_is_cancelled(self, instances):
        if instances.is_cancelled:
            return True
        
        if instances.order.order_status == '40':
            return True
        return False

    def get_order_status(self, instances):
        order_status_data = {
            "name": instances.order.billing_name,
            "address": f"{instances.order.billing_address}, {instances.order.billing_landmark}, {instances.order.billing_city}, {instances.order.billing_state}",
            "phone": instances.order.billing_phone,
            "status": instances.order.order_status

        }
        return order_status_data

    def get_product_image(self, instances):
        request = self.context.get('request')
        if instances.product_variant.image:
            image_url = instances.product_variant.image.url
            return request.build_absolute_uri(image_url)

    def get_product_name(self, instances):
        if instances.product_variant.get_fullname():
            return instances.product_variant.get_fullname()

    # def get_product_name_arabic(self, instances):
    #     if instances.product_variant.get_arabic_name():
    #         return instances.product_variant.get_arabic_name()

    def get_order_id(self, instances):
        if instances.order:
            return instances.order.order_id


class BookingSerializer(serializers.ModelSerializer):
    product_image = serializers.SerializerMethodField()
    product_name = serializers.SerializerMethodField()
    # product_name_arabic = serializers.SerializerMethodField()
    # product_category_arabic = serializers.SerializerMethodField()
    product_category = serializers.SerializerMethodField()
    # product_subcategory_arabic = serializers.SerializerMethodField()
    product_subcategory = serializers.SerializerMethodField()
    product_mrp = serializers.SerializerMethodField()
    product_rating = serializers.SerializerMethodField()

    class Meta:
        model = Booking
        fields = '__all__'

    def get_product_image(self, instances):
        request = self.context.get('request')
        if instances.product_variant.image:
            image_url = instances.product_variant.image.url
            return request.build_absolute_uri(image_url)

    def get_product_name(self, instances):
        if instances.product_variant.get_fullname():
            return instances.product_variant.get_fullname()

    # def get_product_name_arabic(self, instances):
    #     if instances.product_variant.get_arabic_name():
    #         return instances.product_variant.get_arabic_name()

    def get_product_subcategory(self, instances):
        if instances.product_variant.product.subcategory:
            return instances.product_variant.product.subcategory.name

    # def get_product_subcategory_arabic(self, instances):
    #     if instances.product_variant.product.subcategory:
    #         return instances.product_variant.product.subcategory.arabic_name

    def get_product_category(self, instances):
        if instances.product_variant.product.category:
            return instances.product_variant.product.category.name

    # def get_product_category_arabic(self, instances):
    #     if instances.product_variant.product.category:
    #         return instances.product_variant.product.category.arabic_name

    def get_product_rating(self, instances):
        return instances.product_variant.current_rating

    def get_product_mrp(self, instances):
        request = self.context.get('request')
        if is_zone_exists(request):
            zone = get_zone(request)
            if Batch.objects.filter(product_variant=instances.product_variant,
                                    warehouse__deliverable_location__in=[zone]).exists():
                batch_instance = Batch.objects.filter(product_variant=instances.product_variant,
                                                      warehouse__deliverable_location__in=[zone]).order_by(
                    '-date_added').first()
                return batch_instance.mrp


class TicketPostSerializer(serializers.ModelSerializer):

    class Meta:
        model = Ticket
        fields = ['description', 'attachment', 'subject','priority']


class TicketsViewSerializer(serializers.ModelSerializer):
    priority_type = serializers.SerializerMethodField()

    class Meta:
        model = Ticket
        fields = ['description', 'attachment', 'subject','priority','priority_type','message','reject_reason']

    def get_priority_type(self,instance):
        if instance.priority == "10":
            return str("high")
        elif instance.priority == "20":
            return str("medium")
        elif instance.priority == "30":
            return str("low")

class OrderItemRatingSerializer(serializers.ModelSerializer):
    user = serializers.SerializerMethodField()
    description = serializers.SerializerMethodField()
    delivered_time = serializers.SerializerMethodField()
    product_image = serializers.SerializerMethodField()
    product_name = serializers.SerializerMethodField()
    product_rating = serializers.SerializerMethodField()
    delivery_rating = serializers.SerializerMethodField()
    product_pk = serializers.SerializerMethodField()
    product_price = serializers.SerializerMethodField()
    product_category = serializers.SerializerMethodField()
    order_pk = serializers.SerializerMethodField()
    rated_time = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = ['user', 'description', 'delivered_time', 'product_image', 'product_name', 'product_rating',
                  'delivery_rating', 'product_pk', 'product_price', 'product_category', 'order_pk','rated_time']

    def get_user(self, instances):
        return instances.order.customer.name

    def get_description(self, instances):
        return f"Your order for-{instances.product_variant.get_fullname()} successfully delivered"

    def get_delivered_time(self, instances):
        return instances.order.date_updated

    def get_product_image(self, instances):
        request = self.context.get('request')
        if instances.product_variant.image:
            image_url = instances.product_variant.image.url
            return request.build_absolute_uri(image_url)

    def get_product_name(self, instances):
        if instances.product_variant.get_fullname():
            return instances.product_variant.get_fullname()

    def get_product_rating(self, instances):
        request = self.context.get('request')
        if ProductReview.objects.filter(product_variant=instances.product_variant, creator=request.user, is_deleted=False):
            instance = ProductReview.objects.filter(product_variant=instances.product_variant, creator=request.user, is_deleted=False).first()
            return instance.rating

    def get_delivery_rating(self, instances):
        request = self.context.get('request')
        if DeliveryRating.objects.filter(order=instances.order, customer__user=request.user, is_deleted=False):
            instance = DeliveryRating.objects.filter(order=instances.order, customer__user=request.user, is_deleted=False).first()
            return instance.rating

    def get_product_pk(self, instances):
        if instances.product_variant.pk:
            return instances.product_variant.pk

    def get_product_price(self, instances):
        request = self.context.get("request")
        zone = request.session.get('zone', '')

        if zone:
            # if a batch with zero stock exits it returns True
            if Batch.objects.filter(is_deleted=False, product_variant=instances.product_variant,
                                    warehouse__deliverable_location__in=[zone]).exists():
                batch_instances = Batch.objects.filter(is_deleted=False, product_variant=instances.product_variant,
                                                       warehouse__deliverable_location__in=[zone]).order_by(
                    '-date_added').first()
                return batch_instances.mrp

        return instances.product_variant.mrp

    def get_product_category(self, instances):
        if instances.product_variant.product.category:
            return instances.product_variant.product.category.name

    def get_order_pk(self, instances):
        if instances.order:
            return instances.order.pk

    def get_rated_time(self, instances):
        request = self.context.get('request')
        if ProductReview.objects.filter(product_variant=instances.product_variant, creator=request.user, is_deleted=False):
            instance = ProductReview.objects.filter(product_variant=instances.product_variant, creator=request.user, is_deleted=False).first()
            return instance.date_added


class RatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductReview
        exclude = ['auto_id', 'creator', 'updater', 'product_variant']


class DeliveryRatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryRating
        fields = ['rating', ]


class CustomerExportSerializer(serializers.ModelSerializer):
    total_orders = serializers.SerializerMethodField()

    class Meta:
        model = Customer
        fields = ['phone', 'name', 'email',  'country', 'total_orders','current_privilege_points']

    def get_total_orders(self, instance):
        total_orders = Orders.objects.filter(customer=instance).count()
        return total_orders


class PrivilegeHistorySerializer(serializers.ModelSerializer):

    class Meta:
        model = PrivilegePointHistory
        # exclude = ['customer']
        fields = ['title','point_type','points','value_in_amount','date_added']


class CustomerNotificationSerializer(serializers.ModelSerializer):
    time = serializers.SerializerMethodField()
    title = serializers.SerializerMethodField()
    image = serializers.SerializerMethodField()

    class Meta:
        model = Notification
        fields = [
            'pk',
            'time',
            'title',
            'image',
            'message',
            'is_read',
        ]

    def get_time(self, instance):
        return instance.time

    def get_title(self, instance):
        if instance.subject:
            return str(instance.subject.name)
        return None

    def get_image(self, instance):
        request = self.context.get('request')
        try:
            image_url = instance.order.orderitem_set.first().product_variant.image.url
            return request.build_absolute_uri(image_url)
        except Exception as e:
            print('\n\n\n\n', e, '\n\n')
            return None


class CustomerAccountSerializer(serializers.ModelSerializer):

    class Meta:
        model = CustomerAccount
        fields = ['account_number','account_holder','bank_name','swift_code','iban','branch']


class ReturnSerializer(serializers.ModelSerializer):
    product = serializers.SerializerMethodField()
    customer_address = serializers.SerializerMethodField()

    class Meta:
        model = ProductReturn
        fields = ['return_type','amount','status','payment_status','order_item', 'order', 'product', 'customer_address', 'pk',]

    def get_product(self, instance):
        request = self.context.get("request")
        return {"product_name": instance.order_item.product_variant.get_fullname(),
                "image": request.build_absolute_uri(instance.order_item.product_variant.image.url)}

    def get_customer_address(self, instance):
        return instance.order_item.order.get_full_address()