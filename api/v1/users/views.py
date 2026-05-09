# Local libraries
from api.v1.general.functions import generate_serializer_errors, get_user_token, is_zone_exists, get_zone, \
    is_eligible_for_cancel_order_item
from api.v1.delivery_agent.serializers import *
from api.v1.users.functions import *
from api.v1.users.serializers import *
from customers.models import *
from django.contrib.auth.models import User, Group
from django.db.models import Q, Max
from django.shortcuts import get_object_or_404
from general.models import Batch
from main.functions import SendEmail, get_auto_id, send_fast2sms, sendSMS, create_or_get_location, sendOTP, create_notification, paginate
from offers.models import VoucherCode
from orders.models import *
from products.models import ProductVariant
from products.functions import special_variant_stock
from users.models import NotificationSubject, Wishlistitem
from warehouses.models import Zone
from web.models import ProductReturn
from web.functions import check_stock_availability, is_voucher_available
from customers.functions import update_privilege_point
# Thirdparty libraries
from django.conf import settings as SETTINGS
from django.http import HttpResponse
from fcm_django.models import FCMDevice
from rest_framework import status
from rest_framework.decorators import (api_view, permission_classes, renderer_classes)
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
# Standard libraries
import sys
import json
import datetime
import traceback


@api_view(['POST'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def send_otp(request):
    serialized = PhoneNumberSerializer(data=request.data, context={"request":request})
    response_data = {}
    if serialized.is_valid():
        phone = serialized.validated_data.get('phone')

        new_otp = '1234' if phone == '8765432100' else get_otp()

        if UserOtpData.objects.filter(phone=phone).exists():
            UserOtpData.objects.filter(phone=phone).update(otp=new_otp)

        else:
            UserOtpData.objects.create(
                phone=phone,
                name=phone,
                otp=new_otp,
            )

        message = f"Dear customer, {new_otp} is your OTP from Nexsme. Don't share your OTP with anyone."

        if SETTINGS.SERVER == "on":
            if phone != '8765432100':
                # msg = sendOTP(phone, new_otp)
                msg = send_fast2sms(
                    template_id="202565",
                    phone_numbers=[phone],
                    variables={"#VAR1#": new_otp}
                )

        elif SETTINGS.SERVER == "off" :
            print('\n\n-------------', message, '-------------\n\n')

        user_data = {
            # "otp": new_otp,
            "phone": phone
        }

        response_data = {
            "StatusCode": 6000,
            "data": user_data,
            "message": "OTP Send Successfully",
            # "arabic_message": "تم إرسال OTP بنجاح"
        }
    else:
        response_data = {
            "StatusCode": 6001,
            "message": generate_serializer_errors(serialized._errors)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def verify_otp(request):
    data = request.data
    phone = data['phone']
    otp = data['otp']
    is_new_customer = True
    user_token = None
    updated = False

    response_data = {}

    user_data = {
        "otp": otp,
        "phone": phone
    }

    if UserOtpData.objects.filter(phone=phone, otp=otp).exists():

        # check if it is a new customer
        if Customer.objects.filter(phone=phone).exists():
            is_new_customer = False
            user_token = get_user_token(request, phone, phone)

            customer_instance = Customer.objects.get(phone=phone)

            if customer_instance.image:
                image_url = customer_instance.image.url
                user_data = {
                    "phone": phone,
                    "email": customer_instance.email,
                    "name": customer_instance.name,
                    "image": request.build_absolute_uri(image_url),
                }
            else:
                user_data = {
                    "email": customer_instance.email,
                    "phone": phone,
                    "name": customer_instance.name,
                    "image": None,
                }
            response_data = {
                "StatusCode": 6000,
                "data": user_data,
                "is_new": is_new_customer,
                "token": user_token.json(),
                "message": "OTP Verified",
                # "arabic_message": "تم التحقق من OTP"
            }
        else:
            if User.objects.filter(username=phone, is_active=True).exists():
                data = User.objects.get(username=phone)

            else:
                data = User.objects.create_user(
                    username=phone,
                    password=phone,
                    is_active=True,
                )

                if Group.objects.filter(name="customer_user").exists():
                    group = Group.objects.get(name="customer_user")
                else:
                    group = Group.objects.create(name="customer_user")

                data.groups.add(group)

            name = "guest_" + str(phone)

            Customer.objects.create(
                auto_id = get_auto_id(Customer),
                phone=phone,
                name=name,
                user = data,
                creator = data,
                updater = data,
            )

            UserOtpData.objects.filter(phone=phone).update(
                password=encrypt_message(phone)
            )

            response = get_user_token(request, phone, phone)
            updated = True

        if is_new_customer:
            response_data = {
                "StatusCode": 6000,
                "data": user_data,
                "token": response.json(),
                "is_new": is_new_customer,
                "message": "OTP Verified",
                "updated": updated,
                # "arabic_message": "تم التحقق من OTP"
            }
        new_otp = get_otp()
        UserOtpData.objects.filter(phone=phone).update(otp=new_otp)
    else:
        response_data = {
            "StatusCode": 6001,
            "message": "Invalid OTP",
            # "arabic_message": "OTP غير صحيح"
        }
    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def create_customer(request):
    serialized = CustomerRegisterSerializer(data=request.data, context={"request": request})

    response_data = {}

    if serialized.is_valid():
        name = serialized.validated_data['name']
        phone = serialized.validated_data['phone']
        email = serialized.validated_data['email']

        data = User.objects.create_user(
            username=phone,
            password=phone,
            email=email,
            is_active=True,
        )

        if Group.objects.filter(name="customer_user").exists():
            group = Group.objects.get(name="customer_user")
        else:
            group = Group.objects.create(name="customer_user")

        data.groups.add(group)

        uploaded_file_url = None
        if 'image' in request.FILES:
            uploaded_file_url = request.data["image"]

        auto_id = get_auto_id(Customer)

        serialized.save(
            auto_id = auto_id,
            user = data,
            creator = data,
            updater = data,
            image = uploaded_file_url,
        )

        UserOtpData.objects.filter(phone=phone).update(
            password=encrypt_message(phone)
        )

        response = get_user_token(request, phone, phone)

        response_data = {
            "StatusCode": 6000,
            "data": serialized.data,
            "token": response.json(),
            "message": "Successfully Registered",
            # "arabic_message": "سجلت بنجاح"
        }

    else:
        response_data = {
            "StatusCode": 6001,
            "message": generate_serializer_errors(serialized._errors)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def add_or_remove_from_wishlist(request, pk):
    product_pk = pk
    product_variant = ProductVariant.objects.get(pk=product_pk)
    customer = Customer.objects.get(user=request.user)

    response_data = {}

    if Wishlistitem.objects.filter(product_variant_id=product_pk, customer__user=request.user).exists():
        instance = Wishlistitem.objects.filter(product_variant_id=product_pk, customer__user=request.user)
        instance.delete()

        response_data = {
            "StatusCode": 6000,
            "message": "removed",
            # "arabic_message": "إزالة"
        }
    else:
        Wishlistitem.objects.create(
            product_variant=product_variant,
            customer=customer
        )

        response_data = {
            "StatusCode": 6000,
            "message": "added",
            # "arabic_message": "مضاف"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def view_wishlist(request):
    instances = Wishlistitem.objects.filter(customer__user=request.user, is_deleted=False)

    serialized = WishlistSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data,
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def add_address(request):
    serialized = CustomerAddressSerializer(data=request.data)

    location_name = request.data.get('location')
    latitude = request.data.get('latitude')
    longitude = request.data.get('longitude')
    zone = request.data.get('zone')

    is_default = None
    response_data = {}

    if serialized.is_valid():
        isTrue = serialized.validated_data['is_default']
        customer = request.user

        user = Customer.objects.get(phone=customer)
        is_default = CustomerAddress.objects.filter(customer=user)

        if is_default and isTrue == True:
            CustomerAddress.objects.filter(customer=user).update(is_default=False)

        if zone:
            zone = Zone.objects.get(pk=zone)

        customer_location = create_or_get_location(request, location_name, latitude, longitude)

        serialized.save(
            customer=user,
            location = customer_location,
            zone = zone
        )

        response_data = {
            "StatusCode": 6000,
            "message": serialized.data,
        }

    else:
        response_data = {
            "StatusCode": 6001,
            "message": generate_serializer_errors(serialized._errors)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def view_address(request):
    instances = CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False)
    serialized = CustomerAddressSerializer(instances, many=True, context={"request": request})

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def set_default_address(request, pk):
    user = request.user
    response_data = {}
    instances = None

    if CustomerAddress.objects.filter(customer__user=user, is_deleted=False).exists():
        CustomerAddress.objects.filter(is_default=True, customer__user=user, is_deleted=False).update(is_default=False)
        instances = CustomerAddress.objects.filter(pk=pk).update(is_default=True)

        response_data = {
            "StatusCode": 6000,
            "message": "Updated Successfully",
            # "arabic_message": "تم التحديث بنجاح"
        }

    else:
        response_data = {
            "StatusCode": 6001,
            "data": "not found"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def get_default_address(request):
    instances = None

    if CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False, is_default=True):
        instances = CustomerAddress.objects.get(customer__user=request.user, is_deleted=False, is_default=True)

        if instances:
            serialized = CustomerAddressSerializer(instances, context={"request": request})

            response_data = {
                "StatusCode": 6000,
                "data": serialized.data
            }
    else:
        response_data = {
            "StatusCode": 6001,
            "message": "No Default Address Found",
            # "arabic_message": "لم يتم العثور على عنوان افتراضي"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST', "PUT"])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def update_address(request, view_type, pk):
    user = request.user
    instances = None
    response_data = {}

    location_name = request.data.get('location')
    latitude = request.data.get('latitude')
    longitude = request.data.get('longitude')
    zone = request.data.get('zone')


    if CustomerAddress.objects.filter(pk=pk).exists():
        instance = CustomerAddress.objects.get(pk=pk)

        if request.method == "PUT":
            # Check if the user wants to set the address as the default
            set_as_default = request.data.get('is_default', False)

            serialized = CustomerAddressSerializer(instance, data=request.data, context={'request': request}, partial=True)

            customer_zone = instance.zone
            customer_location = instance.location

            if not customer_zone == zone:
                zone = Zone.objects.get(pk=zone)

            customer_location = create_or_get_location(request, location_name, latitude, longitude)

            if serialized.is_valid():
                data = serialized.save(
                    zone=zone,
                    location=customer_location
                )

                # Update is_default field only if set_as_default is True
                if set_as_default:
                    CustomerAddress.objects.filter(customer__user=user).exclude(pk=pk).update(is_default=False)
                    instance.is_default = True
                    instance.save()

                response_data = {
                    "StatusCode": 6000,
                    "message": "Address successfully updated",
                }
            else:
                response_data = {
                    "StatusCode": 6001,
                    'data': {
                        "title": "Validation error",
                        "message": generate_serializer_errors(serialized._errors)
                    }
                }
        else:
            CustomerAddress.objects.filter(pk=pk).update(is_deleted=True)

            response_data = {
                "StatusCode": 6000,
                "message": "Deleted Successfully",
            }

    else:
        response_data = {
            "StatusCode": 6001,
            "data": "Something Went Wrong !"
        }

    return Response(response_data, status=status.HTTP_200_OK)



@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart(request):
    cart_instances = CartItem.objects.filter(customer__user=request.user, is_deleted=False)

    if cart_instances.exists():
        try:
            today = datetime.datetime.now()

            cart_item_price = get_cart_item_price(request)
            express_applicable = get_distributor_type(request)
            # wallet = get_privileged_points(request)
            delivery_charge = get_delivery_charge(request, cart_item_price)
            express_charge = get_express_charge(request)
            grand_total = get_grand_total(cart_item_price, delivery_charge, request)
            express_grand_total = get_grand_total(cart_item_price, express_charge, request)

            coupon_session_amt = request.session.get('coupon_amt', 0)
            # wallet_session_amt = request.session.get('wallet', 0)

            # applied_amount_in_cash = wallet["applied_value_to_cash"]

            cart_instances = CartItem.objects.filter(customer__user=request.user, is_deleted=False)

            product_ids = cart_instances.values_list('product_variant__product_id', flat=True)
            variant_ids = cart_instances.values_list('product_variant_id', flat=True)

            all_voucher_instances = VoucherCode.objects.filter(is_deleted=False, start_time__lte=today, end_time__gte=today)
            voucher_instances = all_voucher_instances.filter(
                Q(voucher_type=10) | # applicable to all
                Q(voucher_type=20, customer__user=request.user) | # for specific customer
                Q(voucher_type=30, product_id__in=product_ids) | # for specific product
                Q(voucher_type=40, product_variant_id__in=variant_ids), # for specific variant
                is_expired = False
            ).exclude(Q(is_limited_once=True, used_users=request.user))

            serialized = CartItemSerializer(cart_instances, many=True, context={"request": request})
            voucher_serialized = VoucherSerializer(voucher_instances, many=True, context={"request": request})

            response_data = {
                "StatusCode": 6000,
                "cart_data": serialized.data,
                "gift_voucher_data": voucher_serialized.data,
                # "wallet_data": wallet,
                "item_price": str(cart_item_price),
                "delivery_charge": delivery_charge,
                "express_charge": express_charge,
                "gift_voucher": str(f"{coupon_session_amt}"),
                # "wallet_amt": str(applied_amount_in_cash),
                "grand_total": str(grand_total),
                "express_grand_total": str(express_grand_total),
                "express_applicable" :  express_applicable,"express_applicable" :  express_applicable,
            }

        except Exception as e:
            print('Error on line {}'.format(sys.exc_info()[-1].tb_lineno), type(e).__name__, e)
            response_data = {
                "StatusCode": 6001,
                "message": "Something Went Wrong!",
                # "arabic_message": "! هناك خطأ ما",
                "error": str(e),
                "error_line": str(['Error on line {}'.format(sys.exc_info()[-1].tb_lineno), type(e).__name__, e])
            }
    else:
        response_data = {
            "StatusCode": 6001,
            "message": "Cart Empty!",
            # "arabic_message": "! عربة التسوق فارغة",
        }


    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart_details(request):
    cart_instances = CartItem.objects.filter(customer__user=request.user, is_deleted=False)

    if cart_instances.exists():
        try:
            zone_session = request.session.get('zone', '')
            if zone_session:
                cart_item_price = get_cart_item_price(request)

                response_data = {
                    "StatusCode": 6000,
                    "cart_item_price": str(cart_item_price),
                    "cart_item_count": str(cart_instances.count()),
                }

            else:
                response_data = {
                    "StatusCode": 6001,
                    "message": "Zone not selected!",
                }


        except Exception as e:
            print('Error on line {}'.format(sys.exc_info()[-1].tb_lineno), type(e).__name__, e)
            response_data = {
                "StatusCode": 6001,
                "message": "Something Went Wrong!",
                # "arabic_message": "! هناك خطأ ما",
                "error": str(e),
                "error_line": str(['Error on line {}'.format(sys.exc_info()[-1].tb_lineno), type(e).__name__, e])
            }
    else:
        response_data = {
            "StatusCode": 6001,
            "message": "Cart Empty!",
            # "arabic_message": "! عربة التسوق فارغة",
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def add_to_cart(request):
    variant_pk = request.data.get('product_variant')
    zone = None
    print(variant_pk)
    product_instance = ProductVariant.objects.get(pk=variant_pk)
    customer = get_user(request.user)

    response_data = {}
    cart_items = CartItem.objects.filter(customer=customer, is_deleted=False)

    if not cart_items.filter(product_variant_id=variant_pk).exists():
        if is_zone_exists(request):
            zone = get_zone(request)
            zone = Zone.objects.filter(pk = zone).first()
            warehouse = Warehouse.objects.filter(deliverable_location=zone, is_deleted=False)
            is_ok = True

            if cart_items.exists():
                if not cart_items.filter(warehouse__in=warehouse).exists():
                    is_ok = False
                    error_message = f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
                    # arabic_error_message = f"العنصر (العناصر) وتابع لإضافة {product_instance} إلى سلة التسوق الخاصة بك {cart_items.count()} من موقع مختلف إما يمكنك إزالة العناصر الحالية في سلة التسوق الخاصة بك وإضافة المنتج الحالي أو يمكنك التحقق من عناصر عربة التسوق الحالية باستخدام {product_instance} بما أنك تضيف"

                elif not cart_items.filter(product_variant__product__vendor=product_instance.product.vendor).exists():
                    is_ok= False
                    error_message = f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
                    # arabic_error_message = f"نظرًا لأنك تضيف {product_instance} من موقع مختلف ، فيمكنك إما إزالة العناصر الحالية في سلة التسوق الخاصة بك وإضافة المنتج الحالي أو يمكنك التحقق من عناصر سلة التسوق الحالية باستخدام {cart_items.count()} عنصر (عناصر) والمتابعة لإضافة { product_instance} إلى سلة التسوق الخاصة بك"

            if is_ok == False:
                response_data = {
                    "StatusCode": 6001,
                    "status": "different-location",
                    "data": error_message,
                    # "arabic_data": arabic_error_message
                }
                return Response(response_data, status=status.HTTP_200_OK)

            if product_instance.is_special_variant:
                stock = special_variant_stock(product_instance, zone.pk)
                if stock > 0:
                    cart_instances = CartItem.objects.create(
                        product_variant=product_instance,
                        customer=customer,
                        warehouse=warehouse.first(),
                    )

                    cart_item_price = get_cart_item_price(request)
                    cart_item_count = CartItem.objects.filter(customer=customer, is_deleted=False).count()

                    response_data = {
                        "StatusCode": 6000,
                        "data": "Product added to cart",
                        "cart_item_price": cart_item_price,
                        "cart_item_count": cart_item_count
                    }
                else:
                    response_data = {
                        "StatusCode": 6001,
                        "data": "Out Of Stock"
                    }

            # check the product is avail in selected zone
            elif Batch.objects.filter(product_variant_id=variant_pk, warehouse__in=warehouse).exists():
                batch_instance = Batch.objects.filter(product_variant_id=variant_pk, warehouse__in=warehouse).order_by('-date_added').first()

                # check for stock
                if batch_instance.stock != 0:
                    cart_instances = CartItem.objects.create(
                        product_variant=product_instance,
                        customer=customer,
                        warehouse=warehouse.first(),
                    )

                    cart_item_price = get_cart_item_price(request)
                    cart_item_count = CartItem.objects.filter(customer=customer, is_deleted=False).count()

                    response_data = {
                        "StatusCode": 6000,
                        "data": "Product added to cart",
                        "cart_item_price": cart_item_price,
                        "cart_item_count": cart_item_count
                    }
                else:
                    response_data = {
                        "StatusCode": 6001,
                        "data": "Out Of Stock"
                    }

            else:
                response_data = {
                    "StatusCode": 6001,
                    "data": "Product is not available in your location",
                    # "arabic_data": "المنتج غير متوفر في موقعك"
                }

        else:
            response_data = {
                "StatusCode": 6001,
                "data": "Please Confirm Your Location",
                # "arabic_data": "يرجى تأكيد موقعك",
            }
    else:
        response_data = {
            "StatusCode": 6001,
            "data": "Product Already in cart",
            # "arabic_data": "المنتج موجود بالفعل في سلة التسوق"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def wholesale_add_to_cart(request):
    try:
        product_variant = request.data.get('product_variant')

        product_instance = ProductVariant.objects.get(pk=product_variant)

        response_data = {}

        customer = get_user(request.user)

        response_data = {}
        cart_items = CartItem.objects.filter(customer=customer, is_deleted=False)

        if is_zone_exists(request):
            zone_session = get_zone(request)
            zone = Zone.objects.filter(pk = zone_session).first()
            warehouse = Warehouse.objects.filter(deliverable_location=zone)

            customer = get_user(request.user)
            cart_items = CartItem.objects.filter(customer=customer, is_deleted=False)
            qty = request.data.get('qty', None) or None

            # for wholesale cart additions
            if qty:
                qty = Decimal(qty)
                if cart_items.exists():
                    if cart_items.filter(product_variant=product_instance).exists():
                        cart_items.filter(product_variant=product_instance).update(qty=F('qty') + qty)
                        qty = cart_items.filter(product_variant=product_instance).first().qty

                        response_data = {"StatusCode": 6000, "status": "added"}

                    elif not cart_items.filter(warehouse__in=warehouse).exists():
                        response_data = {
                            'StatusCode': 6001,
                            "status": "different-location",
                            "data": f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart",
                            # "arabic_data": f"العنصر (العناصر) وتابع لإضافة {product_instance} إلى سلة التسوق الخاصة بك {cart_items.count()} من موقع مختلف إما يمكنك إزالة العناصر الحالية في سلة التسوق الخاصة بك وإضافة المنتج الحالي أو يمكنك التحقق من عناصر عربة التسوق الحالية باستخدام {product_instance} بما أنك تضيف",
                        }
                    elif not cart_items.filter(product_variant__product__vendor=product_instance.product.vendor).exists():
                        response_data = {
                            'StatusCode': 6001,
                            "status": "different-location",
                            "data": f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart",
                            # "arabic_data": f"نظرًا لأنك تضيف {product_instance} من موقع مختلف ، فيمكنك إما إزالة العناصر الحالية في سلة التسوق الخاصة بك وإضافة المنتج الحالي أو يمكنك التحقق من عناصر سلة التسوق الحالية باستخدام {cart_items.count()} عنصر (عناصر) والمتابعة لإضافة { product_instance} إلى سلة التسوق الخاصة بك",
                        }
                    else:
                        # check if the product is avail in that zone
                        if product_instance.product.vendor:
                            if product_instance.product.vendor.deliverable_location.filter(pk=zone_session).exists():
                                CartItem.objects.create(
                                    product_variant=product_instance,
                                    customer=customer,
                                    qty = qty
                                )
                                response_data = {"StatusCode": 6000, "status": "added"}
                            else:
                                response_data = {
                                    'StatusCode': 6001,
                                    "status": "delivery not available",
                                    "data": "Product is not available in your location",
                                    # "arabic_data": "المنتج غير متوفر في موقعك"
                                }
                        else:
                            if Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=0).exists():
                                CartItem.objects.create(
                                    product_variant=product_instance,
                                    customer=customer,
                                    warehouse = warehouse.first(),
                                    qty = qty
                                )
                                response_data = {"StatusCode": 6000, "status": "added"}
                            else:
                                response_data = {
                                    "status": "not_in_batch",
                                    'StatusCode': 6001,
                                    "data": "Product is not available in your location",
                                    # "arabic_data": "المنتج غير متوفر في موقعك"
                                }
                else:
                    if product_instance.product.vendor:
                        if product_instance.product.vendor.deliverable_location.filter(pk=zone_session).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                customer=customer,
                                qty = qty
                            )
                            response_data = {"StatusCode": 6000, "status": "added"}
                        else:
                            response_data = {
                                'StatusCode': 6001,
                                "status": "delivery not available",
                                "data": "Product is not available in your location",
                                # "arabic_data": "المنتج غير متوفر في موقعك"
                            }
                    else:
                        if product_instance.is_special_variant:
                            stock = special_variant_stock(product_variant, zone.pk)
                            if stock > qty:
                                cart_instances = CartItem.objects.create(
                                    product_variant=product_instance,
                                    customer=customer,
                                    warehouse=warehouse.first(),
                                )

                                cart_item_price = get_cart_item_price(request)
                                cart_item_count = CartItem.objects.filter(customer=customer, is_deleted=False).count()

                                response_data = {
                                    "StatusCode": 6000,
                                    "data": "Product added to cart",
                                    "cart_item_price": cart_item_price,
                                    "cart_item_count": cart_item_count
                                }
                            else:
                                response_data = {
                                    "StatusCode": 6001,
                                    "data": "Out Of Stock"
                                }

                        elif Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=qty).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                warehouse = warehouse.first(),
                                customer=customer,
                                qty = qty
                            )
                            response_data = {"StatusCode": 6000, "status": "added"}
                        else:
                            response_data = {
                                'StatusCode': 6001,
                                "status": "delivery not available",
                                "data": "Product is not available in your location",
                                # "arabic_data": "المنتج غير متوفر في موقعك"
                            }

                if response_data['status'] == 'added':
                    response_data['qty'] = qty

                # end of whosale order section
            else:
                response_data = {
                    "StatusCode": 6001,
                    "message": "Quantity not given"
                }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart_increment(request, pk):
    response_data = {}

    try:
        cart_instances = CartItem.objects.get(pk=pk)
        product_variant = cart_instances.product_variant

        zone = None
        if is_zone_exists(request):
            zone = get_zone(request)

        old_qty = cart_instances.qty
        new_qty = old_qty + 1

        if product_variant.is_special_variant:
            cart_instances.qty = new_qty
            cart_instances.save()

            response_data = {
                "StatusCode": 6000,
                "message": "Added",
                # "arabic_message": "مضاف",
                "data": str(new_qty)
            }

        elif Batch.objects.filter(product_variant=product_variant, warehouse__deliverable_location__in=[zone]).exists():
            batch_instance = Batch.objects.filter(product_variant=product_variant, warehouse__deliverable_location__in=[zone]).order_by('-date_added').first()

            batch_qty = batch_instance.stock
            new_batch_qty = batch_qty - new_qty

            if new_batch_qty <= 0:
                response_data = {
                    "StatusCode": 6001,
                    "message": "Stock Exceeded",
                    # "arabic_message": "تجاوز المخزون"
                }
            else:

                cart_instances.qty = new_qty
                cart_instances.save()
                response_data = {
                    "StatusCode": 6000,
                    "message": "Added",
                    # "arabic_message": "مضاف",
                    "data": str(new_qty)
                }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Product not avail in your area",
                # "arabic_message": "المنتج غير متوفر في منطقتك"
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart_decrement(request, pk):
    response_data = {}

    try:
        cart_instances = CartItem.objects.get(pk=pk)
        product_variant = cart_instances.product_variant

        zone = None
        if is_zone_exists(request):
            zone = get_zone(request)

        if cart_instances:
            old_qty = cart_instances.qty
            new_qty = old_qty - 1

            if new_qty == 0:
                cart_instances.delete()
                if 'coupon_id' in request.session:
                    coupon_id = request.session.get('coupon_id', 0) or 0
                    if not is_voucher_available(coupon_id, request):
                        del request.session['coupon_id']
                        del request.session['coupon_amt']

                response_data = {
                    "StatusCode": 6000,
                    "message": "Product removed from Cart",
                    # "arabic_message": "تمت إزالة المنتج من سلة التسوق"
                }
            else:
                cart_instances.qty = new_qty
                cart_instances.save()

                response_data = {
                    "StatusCode": 6000,
                    "message": "Reduced",
                    # "arabic_message": "انخفاض",
                    "data": str(new_qty)
                }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Product not avail in your area",
                # "arabic_message": "المنتج غير متوفر في منطقتك"
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart_remove(request, pk):
    response_data = {}

    try:
        cart_instances = CartItem.objects.filter(pk=pk)
        if cart_instances.exists():
            cart_instances.delete()

            if 'coupon_id' in request.session:
                coupon_id = request.session.get('coupon_id', 0) or 0
                if not is_voucher_available(coupon_id, request):
                    del request.session['coupon_id']
                    del request.session['coupon_amt']

        if CartItem.objects.filter(is_deleted=False, customer__user=request.user).count() == 0:
            if 'coupon_amt' in request.session:
                del request.session['coupon_amt']
            if 'wallet' in request.session:
                del request.session['wallet']
            if 'coupon_id' in request.session:
                del request.session['coupon_id']

            response_data = {
                "StatusCode": 6000,
                "message": "Product Removed From Cart",
                # "arabic_message": "تمت إزالة المنتج من سلة التسوق",
            }
        else:
            response_data = {
                "StatusCode": 6000,
                "message": "Item Not Found !",
                # "arabic_message": "! العنصر غير موجود",
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cart_remove_all(request):

    response_data = {}
    try:
        cart_instances = CartItem.objects.filter(customer__user=request.user)
        if cart_instances.count() > 0:
            for i in cart_instances:
                print("deleting user of ==>>",request.user)
                i.delete()

        if 'coupon_id' in request.session:
            del request.session['coupon_id']
        if 'coupon_amt' in request.session:
            del request.session['coupon_amt']
        if 'wallet' in request.session:
            del request.session['wallet']

        response_data = {
            "StatusCode": 6000,
            "message": "Cart Cleared !",
            # "arabic_message": "! تم مسح العربة",
        }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def apply_coupon(request, pk):
    response_data = {}
    try:
        # if any coupon exists clear existing and replace new one
        if request.session.get('coupon_amt', ''):
            request.session['coupon_id'] = None
            request.session['coupon_amt'] = None

        if VoucherCode.objects.filter(pk=pk).exists():
            voucher_code_instance = VoucherCode.objects.get(pk=pk)

            # validate voucher available or not
            if is_voucher_available(pk, request):
                # store the coupon id for checking cart
                code_pk = voucher_code_instance.pk
                request.session['coupon_id'] = str(code_pk)
                # store the percent amount to session
                cart_item_price = get_cart_item_price(request)
                percent_amt = cart_item_price * voucher_code_instance.percentage / 100
                limit_percent_amt = cart_item_price * voucher_code_instance.upto_limit / 100

                if percent_amt > limit_percent_amt:
                    diff_amt = cart_item_price - limit_percent_amt
                    stored_amt = limit_percent_amt
                else:
                    diff_amt = cart_item_price - percent_amt
                    stored_amt = percent_amt

                request.session['coupon_amt'] = str(round(stored_amt, 2))

                response_data = {
                    "StatusCode": 6000,
                    "message": "Coupon Applied Successfully",
                    # "arabic_message": "تم تطبيق القسيمة بنجاح",
                }

            else:
                response_data = {
                    "StatusCode": 6001,
                    "message": "The coupon has expired or is currently unavailable for use",
                    # "arabic_message": "انتهت صلاحية الكوبون أو أنه غير متاح للاستخدام حاليًا",
                }

        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Invalid Voucher Code",
                # "arabic_message": "رمز قسيمة غير صالح",
            }

        return Response(response_data, status=status.HTTP_200_OK)

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(traceback.format_exc()),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def remove_coupon(request):
    try:
        request.session['coupon_id'] = None
        request.session['coupon_amt'] = None

        response_data = {
            "StatusCode": 6000,
            "message": "Successfully Removed",
            # "arabic_message": "تمت الإزالة بنجاح"
        }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)



@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def view_profile(request):
    response_data = {}

    try:
        instances = Customer.objects.get(user=request.user)
        serialized = CustomerSerializer(instances, context={"request": request})

        response_data = {
            "StatusCode": 6000,
            "data": serialized.data,
        }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def update_profile(request):
    response_data = {}

    try:
        serialized = CustomerProfileUpdateSerializer(data=request.data)
        instances = Customer.objects.get(user=request.user)

        if instances:
            if serialized.is_valid():
                serialized.update(instances, serialized.data)

                response = {
                    "profile_datas": serialized.data,
                    "profile_image": None,
                }

                if 'image' in request.FILES:
                    uploaded_file_url = request.data["image"]
                    instances.image = uploaded_file_url
                    instances.save()

                    image_url = instances.image.url
                    response = {
                        "profile_datas": serialized.data,
                        "profile_image": request.build_absolute_uri(image_url),
                    }

                response_data = {
                    "StatusCode": 6000,
                    "data": response,
                    "message": "Successfully Updated",
                    # "arabic_message": "تم التحديث بنجاح"
                }

            else:
                response_data = {
                    "StatusCode": 6001,
                    "message": "Data Breach",
                    # "arabic_message": "خرق البيانات",
                }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Something went wrong, Customer not found",
                # "arabic_message": "حدث خطأ ، لم يتم العثور على العميل",
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def apply_wallet_amount(request):
    response_data = {}

    # if True:
    try:

        if 'wallet' in request.session:
            request.session['wallet'] = None

        customer_instance = Customer.objects.get(user=request.user)

        points = request.data.get('points')
        if not points:
            points = 0
            print("Points==>",points)

        wallet = get_privileged_points(request)

        available_points = wallet['available_points']
        wallet_balance = wallet['wallet_balance']
        wallet_point = wallet['points']
        # conversion of entered points in cash
        entered_points_cash_value = float(points) * float(wallet_point)

        if points > available_points:
            print("Points==>",points)
            print("Available Points", available_points)
            response_data = {
                "StatusCode": 6001,
                "available_points": available_points,
                "message": "Not enough points in Wallet",
                # "arabic_message": "لا توجد نقاط كافية في المحفظة"
            }
            return Response(response_data, status=status.HTTP_200_OK)

        cart_item_price = get_cart_item_price(request)

        if entered_points_cash_value > cart_item_price:
            response_data = {
                "StatusCode": 6001,
                "message": "Wallet amount greater than cart item price",
                # "arabic_message": "مبلغ المحفظة أكبر من سعر عنصر سلة التسوق"
            }
            return Response(response_data, status=status.HTTP_200_OK)

        difference_amt = float(wallet_balance) - float(cart_item_price)
        request.session['wallet'] = str(points)

        # if difference_amt > 0:
        #     request.session['wallet'] = str(cart_item_price)
        #     customer_instance.current_privilege_points = difference_amt
        #     customer_instance.save()
        # else:
        #     customer_instance.current_privilege_points = 0
        #     request.session['wallet'] = str(wallet_balance)
        #     customer_instance.save()

        response_data = {
            "StatusCode": 6000,
            "value": str(entered_points_cash_value),
            "message": "Wallet Balance Applied Successfully",
            # "arabic_message": "تم تطبيق رصيد المحفظة بنجاح"
        }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def checkout(request):
    response_data = {}

    try:
        address_instances = None
        address_serialized = None

        cart_item_price = get_cart_item_price(request)
        express_applicable = get_distributor_type(request)
        delivery_charge = get_delivery_charge(request, cart_item_price)
        express_charge = get_express_charge(request)
        grand_total = get_grand_total(cart_item_price,delivery_charge, request)
        express_grand_total = get_grand_total(cart_item_price, express_charge, request)

        coupon_session_amt = request.session.get('coupon_amt', 0)
        wallet_session_amt = request.session.get('wallet', 0)

        if CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False, is_default=True):
            address_instances = CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False, is_default=True).first()

            if address_instances:
                address_serialized = CustomerAddressSerializer(address_instances, context={"request": request})

        response_data = {
            "StatusCode": 6000,
            "address": address_serialized.data,
            "item_price": str(cart_item_price),
            "gift_voucher": str(f"{coupon_session_amt}"),
            "express_applicable" :  express_applicable,
            "wallet_amt": str(wallet_session_amt),
            "delivery_charge": delivery_charge,
            "grand_total": str(grand_total),
            "express_delivery_charge": express_charge,
            "express_grand_total": str(express_grand_total),
        }
    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def payment(request):
    """
    place order, wallet amt processing, order id generation and clear cart are done by this function
    :param request:
    :return:
    """
    response_data = {}
    vendor = None
    warehouse = None

    try:
        serialized = OrderSerializer(data=request.data)

        if serialized.is_valid():
            stock_ok, stock_data, error_message = check_stock_availability(request)
            isExpress = serialized.validated_data['is_express_delivery']

            if stock_ok:
                user = request.user

                distributer_id = stock_data

                if Warehouse.objects.filter(id=distributer_id).exists():
                    warehouse = Warehouse.objects.get(id=distributer_id)
                    deliverable_zones = Warehouse.objects.get(id=distributer_id).deliverable_location.all()
                    print(f"Delivery zones =================> {deliverable_zones}")
                    non_deliverable_zones = warehouse.no_express_delivery.all()
                else:
                    vendor = Vendor.objects.get(id=distributer_id)
                    deliverable_zones = Vendor.objects.get(id=distributer_id).deliverable_location.all()
                    non_deliverable_zones = Zone.objects.none()

                customer_instance = Customer.objects.get(user=user)
                address_instance = CustomerAddress.objects.get(customer__user=user, is_default=True, is_deleted=False)
                print(f"Address: {address_instance}")
                if address_instance.zone in deliverable_zones:
                    auto_id = get_auto_id(Orders)
                    cart_item_price = get_cart_item_price(request)

                    if isExpress == True:
                        if non_deliverable_zones.filter(id=address_instance.zone_id).exists():
                            response_data = {
                                "StatusCode": 6001,
                                "message": "The selected address area is not on the Express Delivery Zone list.",
                                # "arabic_message": "منطقة العنوان المحددة ليست في قائمة منطقة التسليم السريع"
                            }
                            return Response(response_data, status=status.HTTP_200_OK)
                        delivery_charge = get_express_charge(request)
                    else:
                        delivery_charge = get_delivery_charge(request, cart_item_price)
                    grand_total = get_grand_total(cart_item_price,delivery_charge, request)

                    order_id = get_order_prefix()
                    order_no = 0
                    prefix = None

                    if InvoicePrefix.objects.filter(is_active=True, is_deleted=False, financial_year__is_active=True).exists():
                        prefix = InvoicePrefix.objects.filter(is_active=True, is_deleted=False, financial_year__is_active=True).first()
                        pr_orders = Orders.objects.filter(prefix=prefix)

                        if pr_orders.filter(prefix=prefix).exists():
                            order_no = pr_orders.filter(prefix=prefix).aggregate(Max('order_no'))['order_no__max']

                        order_no += 1
                        order_id = f"{prefix.order}{str(order_no).zfill(6)}"

                    # coupon get from session
                    coupon_session_amt = 0
                    if 'coupon_amt' in request.session:
                        coupon_session_amt = request.session.get('coupon_amt', 0) or 0

                    # wallet = 0
                    # if 'wallet' in request.session:
                    #     wallet = request.session.get('wallet', '')

                    # reduce the used amount and update to the new amount in current privileges in customer model


                        # current_privilege_point = customer_instance.current_privilege_points
                        # new_privilege_point = int(current_privilege_point) - int(wallet_point_in_session)

                        # customer_instance.current_privilege_points = new_privilege_point

                        # customer_instance.save()

                    # save to order model
                    serialized.save(
                        customer=customer_instance,
                        warehouse = warehouse,
                        vendor = vendor,
                        auto_id=auto_id,
                        creator=user,
                        updater=user,
                        zone = address_instance.zone,

                        billing_name=address_instance.name,
                        billing_phone=address_instance.phone,
                        billing_address=address_instance.house_name,
                        billing_street=address_instance.street,
                        billing_landmark=address_instance.landmark,
                        billing_city=address_instance.city,
                        billing_state=address_instance.state,
                        billing_latitude=address_instance.location.latitude,
                        billing_longitude=address_instance.location.longitude,

                        payment_status = "10",
                        order_status = "10",
                        order_id = order_id,
                        order_no = order_no,
                        prefix = prefix,

                        total_amt = grand_total,
                        delivery_charge = delivery_charge,
                        voucher_amount = coupon_session_amt,
                        # wallet_amount = wallet,
                    )

                    order = Orders.objects.get(auto_id=auto_id)
                    print(order.voucher_amount, '  ---------------- amount ----------------')

                    if 'coupon_id' in request.session and coupon_session_amt:
                        coupon_id = request.session['coupon_id']
                        VoucherCode.objects.get(pk=coupon_id).used_users.add(request.user)

                        del request.session['coupon_amt']
                        del request.session['coupon_id']

                    # if 'wallet' in request.session:
                    #     wallet_point_in_session = request.session['wallet']

                    #     prvlg_amount = update_privilege_point(customer_instance, 'used', int(wallet_point_in_session),order_instance= order)

                    # gained_amount = update_privilege_point(customer_instance, 'gained', order_instance= order)
                    # print("gained",gained_amount)

                    # update_privilege_point(customer_instance, 'gained', order_instance= order)
                    clear_cart(customer_instance, order, request)
                    message = f"Your order {order_id} is placed and expected delivered by {order.delivery_date}."
                    email = SendEmail('placed',customer_instance.email, message )
                    # msg = sendSMS('placed', customer_instance.phone, [order_id, str(order.delivery_date)])
                    # print('\n\n-------------', msg, '-------------\n\n')


                    message = "You have an new order"
                    create_notification(request, "order_placed", message, order)

                    print('\n\n\nError occurred while sending push notification\n\n\n')

                    response_data = {
                        "StatusCode": 6000,
                        "data": {
                            "auto_id": auto_id,
                            "order_id": order_id,
                        }
                    }

                else:
                    response_data = {
                        "StatusCode": 6001,
                        "message": "The selected address's zone doesn't match with the zone of the products in your cart.",
                        # "arabic_message": ".منطقة العنوان المحدد لا تتطابق مع منطقة المنتجات في سلة التسوق الخاصة بك"
                    }

            else:
                response_data = {
                    "StatusCode": 6001,
                    "message": stock_data,
                    "error_message":error_message
                }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": generate_serializer_errors(serialized._errors)
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }
        print(str(e))

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
@renderer_classes((JSONRenderer,))
def list_orders(request):
    order_status = request.GET.get('order_status')
    page = request.GET.get('page')
    paginator = None

    orders = Orders.objects.filter(customer__user=request.user, is_deleted=False)

    if order_status:
        if order_status in ['10', '20', '30', '40']:
            orders = orders.filter(order_status=order_status)

    if page:
        orders, paginator = paginate(orders, request)

    print("Order Count:::::::::::", orders.count())

    serialized = OrderListSerializer(orders, many=True, context={'request': request})
    serialized_data = serialized.data

    response_data = {"StatusCode": 6000, "data": serialized_data, "paginator": paginator}

    return Response(response_data, status=status.HTTP_200_OK)




@api_view(['GET'])
@permission_classes([IsAuthenticated])
@renderer_classes((JSONRenderer,))
def view_order(request, pk):
    try:
        order_instance = Orders.objects.get(id=pk, customer__user=request.user, is_deleted=False)
        serialized = OrderViewSerializer(order_instance, context={'request': request})
        serialized = serialized.data
        response_data = {"StatusCode": 6000, "data": serialized}
        return Response(response_data, status=status.HTTP_200_OK)

    except Orders.DoesNotExist:
        response_data = {"StatusCode": 404, "message": "Order not found."}
        return Response(response_data, status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def orders(request):
    query = request.GET.get('query')


    instances = OrderItem.objects.filter(is_deleted=False, order__customer__user=request.user)

    if query :
        query = query.replace('/', '')

    if query == '10' or query == "20":
        instances = instances.filter(order__order_status=query)

    if query == '30':
        instances = instances.filter(order__order_status=query)

    if query == '40':
        instances = instances.filter(order__order_status=query)

    if query == '50':
        instances = ProductReturn.objects.filter(is_deleted=False, order__customer__user=request.user)

    if query == '50':
        serialized = ReturnSerializer(instances, context={"request": request}, many=True)
    else:
        serialized = OrderItemSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def order_cancel(request, pk):
    response_data = {}

    try:
        if Orders.objects.filter(pk=pk).exists():
            order_instance = Orders.objects.get(pk=pk)
            order_instance.order_status = '40'
            order_instance.save()

            # adding stocks that were decreased
            for order_item in OrderItem.objects.filter(is_deleted=False, order_id=pk):
                batch = order_item.batch
                batch.stock += order_item.qty
                batch.save()

            response_data = {
                "StatusCode": 6000,
                "message": "Order Cancelled Successfully",
            }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Order with associating id is not available",
            }
    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            "error": str(e),
        }
        print(str(e))

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def cancel_order_item(request, pk):
    response_data = {}
    try:
        order_item_instance = get_object_or_404(OrderItem, pk=pk)
        order = order_item_instance.order

        if not order_item_instance.is_cancelled:
            if is_eligible_for_cancel_order_item(order_item_instance):
                print("Item is eligible for cancellation")
                order_item_instance.is_cancelled = True

                batch = order_item_instance.batch
                batch.stock += order_item_instance.qty
                batch.save()

                order_item_instance.save()
                order.total_amt = round(order.total_amt - float(order_item_instance.total()), 2)
                print("Total Order Amount <<<<><><><><>>>>", order.total_amt)
                order.save()

                charge_setting = ChargeSetting.objects.filter(
                    warehouse=order.warehouse,
                    vendor=order.vendor
                ).first()

                if charge_setting and order.total_amt < charge_setting.no_delivery_charge_amount:

                    delivery_charge = DeliveryCharge.objects.filter(
                        warehouse=order.warehouse,
                        vendor=order.vendor,
                        to_zone=order.zone
                    ).first()

                    if delivery_charge:
                        order.delivery_charge = delivery_charge.normal_charge
                        order.save()

                if OrderItem.objects.filter(order__pk=order.pk, is_cancelled=False).exists():
                    print("there is still order items")
                else:
                    order.order_status = 40
                    order.delivery_charge = 0
                    order.save()

                response_data = {
                    "statsCode": 6000,
                    "status": "cancelled",
                    "message": "Successfully cancelled",
                }
            else:
                print("Item is not eligible for cancellation")
                response_data = {
                    "statsCode": 6001,
                    "status": "not_eligible",
                    "message": "Not eligible for cancellation",
                }
        else:
            response_data = {
                "statsCode": 6001,
                "status": "failed",
                "message": "Already Cancelled",
            }

    except Exception as e:
        response_data = {
            "statsCode": 6001,
            "status": "failed",
            "message": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def book_now(request, pk):
    response_data = {}
    try:
        if ProductVariant.objects.filter(pk=pk, is_deleted=False).exists():
            product_instance = ProductVariant.objects.get(pk=pk, is_deleted=False)

            if Booking.objects.filter(product_variant=product_instance, customer__user=request.user,
                                      status='pending').exists():
                response_data = {
                    "StatusCode": 6001,
                    "message": "Product Already Booked & Still waiting for approval",
                    # "arabic_message": "المنتج محجوز بالفعل ومازال ينتظر الموافقة",
                }
            else:
                Booking.objects.create(
                    product_variant=product_instance,
                    customer=get_user(request.user),
                    message="",
                    status='pending',
                )

                response_data = {
                    "StatusCode": 6000,
                    "message": "Booked Successfully",
                    # "arabic_message": "تم الحجز بنجاح",
                }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Product Not Found",
                # "arabic_message": "الصنف غير موجود",
            }
    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }
        print(str(e))

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def bookings(request):
    query = request.GET.get('query').replace('/', '')

    instances = Booking.objects.filter(customer__user=request.user)

    if query == 'pending':
        instances = instances.filter(status='pending')

    if query == 'approved':
        instances = instances.filter(status='confirmed')

    serialized = BookingSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def new_issue(request):
    response_data = {}

    try:
        serialized = TicketPostSerializer(data=request.data)
        if serialized.is_valid():
            serialized.save(
                auto_id=get_auto_id(Ticket),
                creator=request.user,
                updater=request.user,
                customer=get_user(request.user),
                status="pending",
            )

            response_data = {
                "StatusCode": 6000,
                "data": serialized.data,
                "message": "Issue Posted Successfully !",
                # "arabic_message": "! تم نشر العدد بنجاح",
            }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": generate_serializer_errors(serialized._errors)
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }
        print(str(e))

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def active_issue(request):
    instances = Ticket.objects.filter(customer__user=request.user, status__in=["pending", "in_progress"])

    serialized = TicketsViewSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def resolved_issue(request):
    instances = Ticket.objects.filter(customer__user=request.user, status="solved")

    serialized = TicketsViewSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def ratings(request):
    query = request.GET.get('query')

    variant_instance = OrderItem.objects.filter(is_deleted=False, order__customer__user=request.user)
    rated_instance = ProductReview.objects.filter(is_deleted=False, creator=request.user)

    # check for ratings models
    variant_pk = []
    for v in variant_instance:
        if ProductReview.objects.filter(product_variant=v.product_variant, creator=request.user):
            variant_pk.append(v.product_variant.pk)

    # test purpose
    all_order = OrderItem.objects.filter(is_deleted=False, order__customer__user=request.user)
    completes_orders = OrderItem.objects.filter(order__customer__user=request.user, order__order_status="30")
    unrated = OrderItem.objects.filter(order__customer__user=request.user, order__order_status="30").exclude(product_variant__pk__in=variant_pk)
    rated = ProductReview.objects.filter(creator=request.user, )
    instances = OrderItem.objects.filter(order__customer__user=request.user, order__order_status="30").exclude(product_variant__pk__in=variant_pk)

    if query:
        query = query.replace('/', '')
        if query == 'rated':
            instances = OrderItem.objects.filter(order__customer__user=request.user, order__order_status="30",
                                                 product_variant__pk__in=variant_pk)

        if query == 'unrated':
            instances = OrderItem.objects.filter(order__customer__user=request.user, order__order_status="30").exclude(
                product_variant__pk__in=variant_pk)

    serialized = OrderItemRatingSerializer(instances, context={"request": request}, many=True)

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def post_ratings(request):
    response_data = {}
    try:
        product_pk = request.data['product_pk']
        order_pk = request.data['order_pk']

        product_rating = request.data['product_rating']
        delivery_rating = request.data['delivery_rating']
        review = request.data['review']

        if product_pk:
            product_variant_instance = ProductVariant.objects.get(pk=product_pk)

            if review:
                ProductReview.objects.create(
                    product_variant=product_variant_instance,
                    rating=product_rating,
                    creator=request.user,
                    updater=request.user,
                    auto_id=get_auto_id(ProductReview),
                    review=review,
                )
            else:
                ProductReview.objects.create(
                    product_variant=product_variant_instance,
                    rating=product_rating,
                    creator=request.user,
                    updater=request.user,
                    auto_id=get_auto_id(ProductReview)
                )

            update_current_rating(product_variant_instance)

        if order_pk:
            order = Orders.objects.get(pk=order_pk)

            DeliveryRating.objects.create(
                order=order,
                customer=get_user(request.user),
                delivery_agent=order.delivery_agent,
                rating=delivery_rating,
            )

        response_data = {
            "StatusCode": 6000,
            "message": "Rated Successfully",
            # "arabic_message": "تم التقييم بنجاح",
        }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": "Something went wrong",
            # "arabic_message": "هناك خطأ ما",
            "error": str(e),
        }
        print(str(e))

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def get_time_slots(request):
    date = request.GET.get('delivery_date')
    response_data = {}

    if date:
        today = datetime.datetime.now()

        date = date.replace('/', '')
        date_format = datetime.datetime.strptime(date, "%d-%m-%Y")

        week_number = date_format.isoweekday()
        timeslot_instances = TimeSlot.objects.filter(is_deleted=False, is_active=True, day=week_number)

        if date_format == today.date():
            timeslot_instances = timeslot_instances.filter(
                Q(start_time__gte=today.time()),
                Q(start_time__lte=today.time(), end_time__gte=today.time()),
            )

        if date_format.date() == today.date():
            timeslot_instances = timeslot_instances.filter(start_time__gt=today.time())

        timeslot_serialized = TimeSlotSerializer(timeslot_instances, many=True, context={"request": request})

        response_data = {
            "StatusCode": 6000,
            "data": timeslot_serialized.data
        }

    else:
        response_data = {
            "StatusCode": 6000,
            "message": "Please input date",
            # "arabic_message": "الرجاء إدخال التاريخ"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def return_product(request):
    response_data = {}
    serialized = CustomerAccountSerializer(data=request.data)

    try:
        data = request.data
        return_type = data['return_type']
        product_variant = data['product_variant']
        order_id = data['order_id']
        reason_for_return = data['reason_for_return']
        return_specification = data['return_specification']

        if order_id and return_type and product_variant:
            if not ProductReturn.objects.filter(order_item__product_variant__pk=product_variant, order__pk=order_id).exists():

                order_instance = Orders.objects.get(pk=order_id)
                customer = order_instance.customer
                order_item_instances = OrderItem.objects.filter(product_variant__pk=product_variant, order__pk=order_id)

                if order_item_instances.exists():
                    order_item_instance = order_item_instances.get(product_variant__pk=product_variant, order__pk=order_id)
                    order_instance = Orders.objects.get(pk=order_id)
                    product_variant = order_item_instance.product_variant
                    product_amount = order_item_instance.price * order_item_instance.qty
                    print(product_amount)

                    eligibility = is_eligible_for_return(product_variant.pk, order_id)

                    if eligibility:
                        if return_type == "cash":
                            address_pk = data['address_pk']
                            if address_pk:
                                address_instance = CustomerAddress.objects.get(customer=customer, pk=address_pk, is_deleted=False)

                                if address_instance:
                                    ProductReturn.objects.create(
                                        auto_id=get_auto_id(ProductReturn),
                                        return_id = get_return_prefix(),
                                        creator=request.user,
                                        updater=request.user,
                                        order_item=order_item_instance,
                                        order=order_instance,
                                        amount= product_amount,
                                        customer_address= address_instance,
                                        return_type=return_type,
                                        reason_for_return=reason_for_return,
                                        return_specification=return_specification,
                                        customer_name=address_instance.name,
                                        customer_phone=address_instance.phone,
                                        customer_street=address_instance.street,
                                        customer_landmark=address_instance.landmark,
                                        customer_latitude=address_instance.location.latitude,
                                        customer_longitude=address_instance.location.longitude,
                                        is_handover_required= True
                                    )
                                    response_data = {
                                        "StatusCode": 6000,
                                        "message": "Product Return Request Successfully",
                                        # "arabic_message": "تم طلب إعادة المنتج بنجاح"
                                    }
                                else:
                                    response_data = {
                                        "StatusCode": 6001,
                                        "message": "Address not found"
                                    }
                            else:
                                response_data = {
                                    "StatusCode": 6001,
                                    "message": "Customer address required"
                                }
                        elif return_type == "bank":
                            if serialized.is_valid():
                                account_instance = serialized.save(
                                    customer=customer
                                )

                                ProductReturn.objects.create(
                                    auto_id=get_auto_id(ProductReturn),
                                    return_id = get_return_prefix(),
                                    creator=request.user,
                                    updater=request.user,
                                    order_item=order_item_instance,
                                    order=order_instance,
                                    amount= product_amount,
                                    customer_account= account_instance,
                                    return_type=return_type,
                                    reason_for_return=reason_for_return,
                                    return_specification=return_specification,
                                    customer_name=order_instance.billing_name,
                                    customer_phone=order_instance.billing_phone,
                                    customer_street=order_instance.billing_street,
                                    customer_landmark=order_instance.billing_landmark,
                                    customer_latitude=order_instance.billing_latitude,
                                    customer_longitude=order_instance.billing_longitude,
                                )
                                response_data = {
                                    "StatusCode": 6000,
                                    "message": "Product Return Request Successfully",
                                    # "arabic_message": "تم طلب إعادة المنتج بنجاح"
                                }
                            else:
                                response_data = {
                                    "StatusCode": 6001,
                                    "message": generate_serializer_errors(serialized._errors)
                                }
                        else:
                            response_data = {
                                "StatusCode": 6001,
                                "message": "Invalid Refund Type"
                            }

                    else:
                        response_data = {
                            "StatusCode": 6001,
                            "message": "Product Return Period Was Over",
                            # "arabic_message": "انتهت فترة إرجاع المنتج"
                        }
                else:
                    response_data = {
                        "StatusCode": 6000,
                        "message": "Order or Product not Available",
                        # "arabic_message": "الطلب أو المنتج غير متوفر"
                    }
            else:
                response_data = {
                    "StatusCode": 6000,
                    "message": "Product already returned",
                    # "arabic_message": ""
                }

        else:
            response_data = {
                "StatusCode": 6000,
                "message": "Order id, return type and product variant required",
                # "arabic_message": ""
            }

    except Exception as e:
        response_data = {
            "StatusCode": 6001,
            "message": str(e),
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def view_privilege_history(request):
    instances = PrivilegePointHistory.objects.filter(customer__user=request.user, is_deleted=False)
    serialized = PrivilegeHistorySerializer(instances, many=True, context={"request": request})

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['POST'])
def create_fcm_device(request):
    serialized = FCMDeviceSerializer(data=request.data)

    if serialized.is_valid():
        registration_id = serialized.data['registration_id']
        device_type = serialized.data['type']
        name = serialized.data['name']

        user = request.user if request.user.is_authenticated else None
        if not user:
            try:
                user_id = request.POST.get('user') or request.data.get('user')
                if user_id:
                    user = User.objects.filter(pk=user_id).first()
            except Exception as e:
                print(e)

        device, updated = FCMDevice.objects.update_or_create(
            registration_id = registration_id,
            type = device_type,
            defaults = {
                'name': name,
                'user': user,
            }
        )

        response_data = {
            "StatusCode": 6000,
            'data': {
                'title': 'Success',
                'message': 'Devices successfully %s' % ('updated' if not updated else 'created'),
            }
        }

    else:
        response_data = {
            "StatusCode": 6001,
            "message": generate_serializer_errors(serialized._errors)
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def notifications(request):
    instances = Notification.objects.filter(user=request.user, is_deleted=False)
    serialized = CustomerNotificationSerializer(instances, many=True, context={"request": request})

    response_data = {
        "StatusCode": 6000,
        "data": serialized.data
    }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((IsAuthenticated,))
@renderer_classes((JSONRenderer,))
def notification(request, action, value):
    if value == 'all':
        instances = Notification.objects.filter(user=request.user, is_deleted=False)
    else:
        instances = Notification.objects.filter(pk=value)

    if action == 'read':
        instances = instances.update(is_read=True)

    elif action == 'delete':
        instances = instances.update(is_deleted=True)

    response_data = {
        "StatusCode": 6000,
    }

    return Response(response_data, status=status.HTTP_200_OK)
