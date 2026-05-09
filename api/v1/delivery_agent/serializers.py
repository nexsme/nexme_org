from fcm_django.models import FCMDevice
from delivery_agent.models import *
from main.models import DeliveryAppUpdate
from orders.models import *
from rest_framework import serializers
from users.models import Notification
from web.models import ProductReturn

from delivery_agent.functions import get_total_distance
from api.v1.location.serializers import LocationSerializer
from api.v1.delivery_agent.functions import get_delivery_distance
from delivery_agent.functions import serializer_return


class OrderItemMiniSerializer(serializers.ModelSerializer):
    product_name = serializers.SerializerMethodField()

    class Meta:
        model = OrderItem
        fields = '__all__'

    def get_product_name(self, instances):
        return {"name": f"{instances.product_variant.product.name} x {instances.qty}",
                "variant": instances.product_variant.title}


class OrderSerializer(serializers.ModelSerializer):
    customer_name = serializers.SerializerMethodField()
    order_items = serializers.SerializerMethodField()
    destination = serializers.SerializerMethodField()
    agent_status = serializers.SerializerMethodField()
    order_status_value = serializers.SerializerMethodField()
    delivery_date = serializers.SerializerMethodField()
    date_added = serializers.SerializerMethodField()
    time_slot = serializers.SerializerMethodField()
    delivery_distance = serializers.SerializerMethodField()
    shop_location = serializers.SerializerMethodField()
    customer_location = serializers.SerializerMethodField()
    order_number = serializers.SerializerMethodField()
    zone = serializers.SerializerMethodField()
    amount_distribution = serializers.SerializerMethodField()

    class Meta:
        model = Orders
        fields = ['customer_name', 'total_amt', 'order_id', 'order_items', 'destination', 'pk', 'order_status', 'agent_status',
                  'pickup_status', 'order_status_value', 'billing_phone', 'payment_method', 'delivery_date', "date_added",
                  'delivery_distance', 'time_slot', 'shop_location', 'customer_location', 'zone', 'order_number', 'delivery_agent_accepted_time',
                  'delivery_agent_declined_time', 'pickup_time', 'delivered_time', 'amount_distribution'
                  ]

    def get_customer_name(self, instances):
        return instances.customer.name

    def get_amount_distribution(self, instance):
        return {
            'product_total': instance.get_product_total(),
            'delivery_charge': instance.delivery_charge,
            'voucher_amount': instance.voucher_amount,
            'wallet_amount': instance.wallet_amount,
            'total_amt': instance.total_amt,
        }

    def get_order_items(self, instance):
        order_item_instances = OrderItem.objects.filter(order=instance)
        request = self.context.get("request")
        serialized = OrderItemMiniSerializer(order_item_instances, context={"request": request}, many=True)
        return serialized.data

    def get_destination(self, instance):
        data = {
            "customer_name": instance.billing_name,
            "customer_address": instance.get_full_address(),
        }
        if instance.warehouse:
            data["warehouse"] = instance.warehouse.name
            data["warehouse_location"] = str(instance.warehouse.zone)
        elif instance.vendor:
            data["vendor"] = instance.vendor.name
            data["vendor_location"] = str(instance.vendor.zone)

        return data

    def get_time_slot(self, instance):
        if instance.time_slot:
            start_time = instance.time_slot.start_time.strftime("%I:%M %p")
            end_time = instance.time_slot.end_time.strftime("%I:%M %p")

            return f"Between {start_time} & {end_time} on {instance.time_slot.get_day_display()}"

        return "Sooner (time not specified)"

    def get_delivery_date(self, instance):
        return instance.delivery_date

    def get_date_added(self, instance):
        return instance.assigned_time

    def get_agent_status(self, instance):
        return instance.delivery_agent_is_accept

    def get_order_status_value(self, instance):
        return instance.get_order_status_display()

    def get_delivery_distance(self, instance):
        delivery_distance = 0

        if instance.billing_latitude and instance.billing_longitude:

            destination_latitude = instance.billing_latitude
            destination_longitude= instance.billing_longitude

            if instance.vendor:
                origin = Vendor.objects.get(pk=instance.vendor.pk)
                origin_latitude = origin.location.latitude
                origin_longitude = origin.location.longitude
            else:
                origin = Warehouse.objects.get(pk=instance.warehouse.pk)
                origin_latitude = origin.location.latitude
                origin_longitude = origin.location.longitude

            delivery_distance = get_delivery_distance(origin_latitude,origin_longitude, destination_latitude, destination_longitude)

        return delivery_distance

    def get_customer_location(self, instance):
        data = {
            "latitude": instance.billing_latitude,
            "longitude": instance.billing_longitude
        }

        return data

    def get_shop_location(self, instance):

        if instance.vendor:
            origin = Vendor.objects.get(pk=instance.vendor.pk)
            data = {
                "latitude": origin.location.latitude,
                "longitude": origin.location.longitude
            }
        else:
            origin = Warehouse.objects.get(pk=instance.warehouse.pk)
            data = {
                "latitude": origin.location.latitude,
                "longitude": origin.location.longitude
            }

        return data

    def get_zone(self, instance):
        request = self.context.get("request")
        serialized = LocationSerializer(instance.zone, context={"request": request})

        return serialized.data

    def get_order_number(self, instance):
        return instance.get_order_number()


class PaymentCollectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CollectPayment
        exclude = ['creator', 'updater', 'auto_id', 'delivery_agent']


class DeliveryAgentLocationSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryAgentTravel
        fields = '__all__'


class ProductReturnSerializer(serializers.ModelSerializer):
    product = serializers.SerializerMethodField()
    customer_address = serializers.SerializerMethodField()
    shop_location = serializers.SerializerMethodField()
    destination = serializers.SerializerMethodField()
    customer_location = serializers.SerializerMethodField()

    class Meta:
        model = ProductReturn
        fields = ['pk','return_id','date_added','amount','return_type','status','agent_status','payment_status','order_item', 'order', 'product', 'customer_address',
                  'customer_latitude','customer_longitude','customer_name','customer_phone','customer_street','customer_landmark',
                  'shop_location','destination','customer_location', 'is_handover_required']

    def get_product(self, instance):
        request = self.context.get("request")
        return {"product_name": instance.order_item.product_variant.get_fullname(),
                "image": request.build_absolute_uri(instance.order_item.product_variant.image.url),
                "price": str(instance.amount)}

    def get_customer_address(self, instance):
        return instance.order_item.order.get_full_address()

    def get_shop_location(self, instance):

        if instance.order.vendor:
            origin = Vendor.objects.get(pk=instance.order.vendor.pk)
            data = {
                "latitude": origin.location.latitude,
                "longitude": origin.location.longitude
            }
        else:
            origin = Warehouse.objects.get(pk=instance.order.warehouse.pk)
            data = {
                "latitude": origin.location.latitude,
                "longitude": origin.location.longitude
            }

        return data

    def get_destination(self, instance):
        data = {
            "customer_name": instance.customer_name,
            "customer_address": instance.order.get_full_address(),
        }
        if instance.order.warehouse:
            data["warehouse"] = instance.order.warehouse.name
            data["warehouse_location"] = str(instance.order.warehouse.zone)
        elif instance.order.vendor:
            data["vendor"] = instance.order.vendor.name
            data["vendor_location"] = str(instance.order.vendor.zone)

        return data

    def get_customer_location(self, instance):
        data = {
            "latitude": instance.customer_latitude,
            "longitude": instance.customer_longitude
        }

        return data


class NotificationSerializer(serializers.ModelSerializer):
    notification_subject = serializers.SerializerMethodField()
    order_id = serializers.SerializerMethodField()
    order_status= serializers.SerializerMethodField()
    agent_status= serializers.SerializerMethodField()

    class Meta:
        model = Notification
        fields = ['notification_subject','message',  'pk','order','order_id','is_read','time','order_status','agent_status']

    def get_notification_subject(self, instance):
        return instance.subject.name

    def get_order_id(self, instance):
        return instance.order.order_id

    def get_order_status(self, instance):
        return instance.order.order_status

    def get_agent_status(self, instance):
        return instance.order.delivery_agent_is_accept


class DeliveryAgentSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryAgents
        fields = ['name', 'email', 'phone1', 'email','image', 'id_proof', 'phone2']



class DeliveryAgentExportSerializer(serializers.ModelSerializer):

    total_distance_covered = serializers.SerializerMethodField()
    date_of_join = serializers.SerializerMethodField()

    class Meta:
        model = DeliveryAgents
        fields = ['name', 'email', 'phone1', 'email','total_distance_covered','date_of_join']

    def get_total_distance_covered(self,instance):
        total_distance = get_total_distance(instance)
        return serializer_return(total_distance, total_distance)

    def get_date_of_join(self,instance):
        return serializer_return('date_added', instance.date_added.strftime("%Y-%m-%d"))


class FCMDeviceSerializer(serializers.ModelSerializer):

    class Meta:
        model = FCMDevice
        fields = ('registration_id', 'type', "name",)


class DeliveryAppAndroidUpdateSerializer(serializers.ModelSerializer):
    app_version  = serializers.CharField(source="android_version")
    force_upgrade  = serializers.BooleanField(source="android_force_upgrade")
    recommended_upgrade  = serializers.BooleanField(source="android_recommended_upgrade")
    class Meta:
        model = DeliveryAppUpdate
        fields = ('id', 'app_version', 'force_upgrade', 'recommended_upgrade')

class DeliveryAppIOSUpdateSerializer(serializers.ModelSerializer):
    app_version  = serializers.CharField(source="ios_version")
    force_upgrade  = serializers.BooleanField(source="ios_force_upgrade")
    recommended_upgrade  = serializers.BooleanField(source="ios_recommended_upgrade")
    class Meta:
        model = DeliveryAppUpdate
        fields = ('id', 'app_version', 'force_upgrade', 'recommended_upgrade')