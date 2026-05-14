# Standard libraries
import re
import datetime
import json
import requests

from api.v1.general.functions import is_zone_exists, get_zone
from api.v1.users.functions import decrypt_message, update_current_rating
# django libraries
from django.conf import settings as SETTINGS
from django.contrib.auth import login, authenticate
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User, Group
from django.core import serializers
from django.db.models import Count, Q, F, Max
from django.http.response import HttpResponse, JsonResponse, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404, redirect
from django.template.loader import render_to_string
from django.urls import reverse
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

from django.views.decorators.csrf import csrf_exempt
import razorpay

# local libraries
from api.v1.users.functions import *
from api.v1.delivery_agent.functions import send_notification
from customers.functions import update_privilege_point
from finance.models import InvoicePrefix
from general.models import Batch
from main.decorators import role_required
from main.functions import SendEmail, generate_form_errors, get_auto_id, get_otp, send_otp_message, get_or_create_location, sendOTP
from offers.models import Offers, DealOfDay, VoucherCode
from customers.models import UserOtpData, Customer, CustomerAddress
from orders.models import OrderItem, Orders, TimeSlot, Booking
from products.models import Category, SubCategory, ProductVariant, ProductImages
from products.functions import get_variation_type_products, special_variant_stock
from users.forms import *
from users.functions import get_user
from main.functions import sendSMSConfirmation
from users.models import *
from vendors.models import Vendor
from warehouses.models import Location
from warehouses.forms import LocationForm
from web.forms import *
from web.functions import *
from web.models import *
from web.context_processors import web_context



class PincodeAutoComplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        if not self.request.user.is_authenticated:
            return Location.objects.none()

        items = Location.objects.filter(is_deleted=False)

        if self.q:
            query = self.q
            items = items.filter(Q(pincode__icontains=query))

        return items


def about_us(request):
    title = "About us"

    context = {
        "title": title,
        "instance": CompanyProfile.objects.filter(is_deleted=False).order_by("-date_added").first()
    }

    return render(request, 'web/informations/about-us.html', context)


def delivery_info(request):
    title = "Delivery Information"

    context = {
        "title": title,
    }

    return render(request, 'web/informations/delivery-info.html', context)


def privacy_policy(request):
    title = "Privacy policy"

    context = {
        "title": title,
    }

    return render(request, 'web/informations/privacy-policy.html', context)


def terms_and_condition(request):
    title = "Terms And Condition"

    context = {
        "title": title,
    }

    return render(request, 'web/informations/tac.html', context)


def index(request):
    zone_session = request.session.get('zone', '')

    now_time = datetime.datetime.now()

    spotlight_banners = SpotlightBanner.objects.filter(is_deleted=False,).order_by("-date_added")
    primary_banners = spotlight_banners.filter(banner_type='primary')
    secondary_banners = spotlight_banners.filter(banner_type='secondary')
    tertiary_banners = spotlight_banners.filter(banner_type='tertiary')

    shop_instances = Vendor.objects.filter(is_deleted=False)
    category_instances = Category.objects.filter(is_deleted=False)
    offer_instances = Offers.objects.filter(start_time__lte=now_time, end_time__gte=now_time, is_deleted=False)

    featured_cat_instances = category_instances.filter(is_featured=True, product__isnull=False).distinct()

    offer_instance = None
    if offer_instances:
        offer_instance = offer_instances.order_by('-date_added').first()
        offer_instances = offer_instances.exclude(pk=offer_instance.pk)

    if zone_session:
        shop_instances = shop_instances.filter(zone__pk=zone_session)
        offer_instances = Offers.objects.filter(warehouse__deliverable_location__in=[zone_session], start_time__lte=now_time, end_time__gte=now_time, is_deleted=False)

    variants = ProductVariant.objects.filter(is_deleted=False, is_admin_approved=True, product__is_active=True).order_by("-auto_id")

    # get the best sellers item on the basis of order+sale count
    best_sellers = variants.annotate(
        order_count=Count('orderitem'),
        sale_count=Count('saleitem'),
        total_count=F('sale_count') + F('order_count')
    ).order_by('-total_count')[:8]  # to get only 8 variants

    # get the featured products
    featured_products = variants.filter(is_featured=True)
    query = request.GET.get("q")

    if query:
        variants = variants.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query)
        )
    context = {
        "title": "Home",
        "search_title": "products",
        "is_index": True,
        "featured_cat_instances": featured_cat_instances,
        "variants": variants,
        "shops": shop_instances,
        "offer_instances": offer_instances,
        "offer_instance": offer_instance,
        "featured_products": featured_products,
        "best_sellers": best_sellers,
        "lang": request,
        "primary_banners": primary_banners,
        "secondary_banners": secondary_banners,
        "tertiary_banners": tertiary_banners,
    }
    return render(request, "web/index.html", context)


def signup(request):
    phone = request.GET.get("phone")
    name = request.GET.get("username")
    email = request.GET.get("email")

    response_data = {}

    if phone and name and email:
        if len(phone) == 10:
            otp = get_otp()

            if not User.objects.filter(username=phone,is_active=True).exists():
                if not UserOtpData.objects.filter(phone=phone).exists():
                    UserOtpData.objects.create(
                        name=name,
                        phone=phone,
                        otp=otp,
                        password=encrypt_message(phone)
                    )

                else:
                    UserOtpData.objects.filter(phone=phone).update(otp=str(otp))

                if User.objects.filter(username=phone).exists():
                    user_data = User.objects.get(username=phone)
                else:
                    user_data = User.objects.create_user(
                        username=phone,
                        password=phone,
                        email = email,
                        is_active=False,
                    )

                print(f'\n\nUSER OTP IS {otp}\n\n')

                if SETTINGS.SERVER == "on":
                    msg= sendOTP(phone, otp)
                elif SETTINGS.SERVER == "off" :
                    message = f"Dear customer, {otp} is your OTP from Nexsme. Don't share your OTP with anyone."
                    print('\n\n-------------', message, '-------------\n\n')

                if Group.objects.filter(name="customer_user").exists():
                    group = Group.objects.get(name="customer_user")
                else:
                    group = Group.objects.create(name="customer_user")

                user_data.groups.add(group)

                if not Customer.objects.filter(user=user_data).exists():
                    Customer.objects.create(
                        user=user_data,
                        name=name,
                        email=email,
                        phone=phone,
                        # customer_type='b2c',
                        auto_id=get_auto_id(Customer),
                        creator=user_data,
                        updater=user_data,
                        is_web_registered = True
                    )
                else:
                    Customer.objects.filter(user=user_data).update(name=name)

                response_data = {
                    "status": 'true'
                }

            elif not Customer.objects.filter(user__username=phone).exists():
                password = phone
                if DeliveryAgents.objects.filter(user__username=phone).exists():
                    agent = DeliveryAgents.objects.get(user__username=phone)
                    password = decrypt_message(agent.password)

                if not UserOtpData.objects.filter(phone=phone).exists():
                    UserOtpData.objects.create(
                        name=name,
                        phone=phone,
                        otp=otp,
                        password=encrypt_message(password)
                    )

                else:
                    UserOtpData.objects.filter(phone=phone).update(otp=str(otp))

                if User.objects.filter(username=phone).exists():
                    user_data = User.objects.get(username=phone)
                else:
                    user_data = User.objects.create_user(
                        username=phone,
                        password=phone,
                        is_active=False,
                    )

                print(f'\n\nUSER OTP IS {otp}\n\n')

                if SETTINGS.SERVER == "on":
                    msg= sendOTP(phone, otp)
                elif SETTINGS.SERVER == "off" :
                    message = f"Dear customer, {otp} is your OTP from Nexsme. Don't share your OTP with anyone."
                    print('\n\n-------------', message, '-------------\n\n')

                if Group.objects.filter(name="customer_user").exists():
                    group = Group.objects.get(name="customer_user")
                else:
                    group = Group.objects.create(name="customer_user")

                user_data.groups.add(group)

                if not Customer.objects.filter(user=user_data).exists():
                    Customer.objects.create(
                        user=user_data,
                        name=name,
                        email=email,
                        phone=phone,
                        # customer_type='b2c',
                        auto_id=get_auto_id(Customer),
                        creator=user_data,
                        updater=user_data
                    )
                else:
                    Customer.objects.filter(user=user_data).update(name=name)

                response_data = {
                    "status": 'true'
                }
            else:
                response_data = {
                    "status": '6001',
                    "message": "User already exists"
                }
        else:
            response_data = {
                "status": '6001',
                "message": "Please enter your 10 digit mobile number"
            }

    else:
        response_data = {
            "status": 'false'
        }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def user_login(request):
    phone = request.GET.get("phone")
    otp = '1234' if phone == '8765432100' else get_otp()


    response_data = {}

    if phone:
        if User.objects.filter(username=phone,is_active=True).exists():
            if Customer.objects.filter(user__username=phone).exists():
                UserOtpData.objects.filter(phone=phone).update(
                    otp=str(otp),
                )
                otp_data, updated = UserOtpData.objects.update_or_create(phone=phone, defaults={'otp': otp})

                # update user password
                # user = User.objects.get(username=phone)
                # user.set_password(str(otp))
                # user.save()

                print(SETTINGS.SERVER,"server")

                message = "Your OTP for mobile verifications is {otp} Thanks, Arafa." .format(otp=str(otp))

                message_type = "otp"
                # send_otp_message(message_type,phone,message)
                print(f'\n\nUSER OTP IS {otp}\n\n')

                if SETTINGS.SERVER == "on":
                    # message = f"Dear customer, {otp} is your OTP from Nexsme. Don't share your OTP with anyone."
                    if phone != '8765432100':
                        msg = sendOTP(phone, otp)

                elif SETTINGS.SERVER == "off" :
                    message = f"Dear customer, {otp} is your OTP from Nexsme. Don't share your OTP with anyone."

                print("\n\n\n", otp, '\n\n\n')

                response_data = {
                    "status": "true"
                }

            else:
                response_data = {
                    "status": "false"
                }
        else:
            response_data = {
                "status": "false"
            }

    else:
        response_data = {
            "status": "6001"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def verify_otp(request):
    otp = request.GET.get("otp")
    phone = request.GET.get("phone")

    response_data = {}

    if otp:
        if UserOtpData.objects.filter(phone=phone).exists():

            if UserOtpData.objects.filter(phone=phone, otp=otp).exists():
                otp_data = UserOtpData.objects.get(phone=phone, otp=otp)
                user_data = User.objects.get(username=phone)

                username = user_data.username
                password = user_data.password

                user_data.is_active = True
                user_data.save()

                password = decrypt_message(otp_data.password)

                user = authenticate(username=username, password=password)

                print(user)

                if user is not None:
                    login(request, user)
                    response_data = {
                        "status": "true"
                    }

                else:
                    # user not found
                    response_data = {
                        "status": "6002"
                    }
                new_otp = get_otp()
                UserOtpData.objects.filter(phone=phone).update(otp=new_otp)
            else:
                # otp error
                response_data = {
                    "status": "false"
                }
    else:
        # user not registered
        print("phone not found")

        response_data = {
            "status": "6001"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def shops(request):
    shop_instance = Vendor.objects.filter(is_deleted=False)
    context = {
        "title": "Shops",
        "search_title": "products",
        'instances': shop_instance,
    }

    return render(request, 'web/shops.html', context)


def add_to_wishlist(request):
    products = request.GET.get('product_variant')
    product_instance = ProductVariant.objects.get(pk=products)

    response_data = {}

    if request.user.is_authenticated:
        customer = get_user(request.user)
        # Wishlistitem check
        if Wishlistitem.objects.filter(product_variant=product_instance, customer=customer, is_deleted=False).exists():
            Wishlistitem.objects.filter(
                product_variant=product_instance,
                customer=customer
            ).delete()

            response_data = {
                "status": "removed",

            }
        else:
            Wishlistitem.objects.create(
                product_variant=product_instance,
                customer=customer
            )
            response_data = {
                "status": "added"
            }
    else:
        response_data = {
            "status": "null"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def view_wishlist(request):
    wishlist = Wishlistitem.objects.filter(is_deleted=False, customer__user=request.user)

    context = {
        "title": "My Wishlist",
        'instances': wishlist
    }

    return render(request, 'web/whishlist.html', context)


def product(request, pk):
    zone_session = request.session.get('zone', '')
    all_products = ProductVariant.objects.filter(is_deleted=False, product__is_active=True, is_admin_approved=True)

    instance = get_object_or_404(all_products, pk=pk)
    if zone_session:
        all_batch = Batch.objects.filter(is_deleted=False, product_variant__product_id=instance.product_id, warehouse__deliverable_location__in=[zone_session])
    else:
        all_batch = Batch.objects.filter(is_deleted=False, product_variant__product_id=instance.product_id)

    batch = all_batch.filter(product_variant__pk=pk, stock__gt=0).first()

    images = ProductImages.objects.filter(product_variant_id=pk, is_deleted=False)
    reviews = ProductReview.objects.filter(product_variant_id=pk, is_deleted=False)
    variants = all_products.filter(product_id=instance.product_id).order_by("-auto_id")

    # if instance.is_special_variant:
    #     # variants = instance.special_variant_added.product_variant.all().order_by("-auto_id")
    #     variants = variants.filter(is_special_variant=False)

    variations = get_variation_type_products(variants, pk, all_batch)

    review_count = reviews.count()

    if instance.product.subcategory_id:
        related_products = all_products.filter(product__subcategory_id=instance.product.subcategory_id).exclude(product_id=instance.product_id)
    else:
        related_products = all_products.filter(product__category_id=instance.product.category_id).exclude(product_id=instance.product_id)

    if related_products.count() < 10:
        if instance.product.vendor_id:
            related_products |= all_products.filter(product__vendor_id=instance.product.vendor_id).exclude(product_id=instance.product_id)
        if instance.product.brand_id:
            related_products |= all_products.filter(product__brand_id=instance.product.brand_id).exclude(product_id=instance.product_id)
    if related_products.count() < 10:
        related_products = all_products.filter(product__category_id=instance.product.category_id).exclude(product_id=instance.product_id)

    related_products = related_products.order_by("-auto_id")

    context = {
        "title": instance.title,
        'batch': batch,
        'images': images,
        'variants': variants,
        "variations": variations,
        'product_variant': instance,
        'is_need_datepicker': False,
        "review_instances": reviews,
        "review_count": review_count,
        "related_products": related_products,
    }

    return render(request, 'web/single-product.html', context)


def add_to_cart(request):
    products = request.GET.get('product_variant')
    product_instance = ProductVariant.objects.get(pk=products)

    response_data = {}

    zone_session = request.session.get('zone', '')

    if request.user.is_authenticated:
        if zone_session:
            location = Zone.objects.filter(pk = zone_session).first()
            warehouse = Warehouse.objects.filter(deliverable_location=location, is_deleted=False)

            customer = get_user(request.user)
            cart_items = CartItem.objects.filter(customer=customer, is_deleted=False)

            # Cart item check
            if cart_items.exists():
                if cart_items.filter(product_variant=product_instance).exists():
                    CartItem.objects.filter(
                        product_variant=product_instance,
                        customer=customer
                    ).delete()

                    response_data = {
                        "status": "removed"
                    }
                elif not cart_items.filter(warehouse__in=warehouse).exists():
                    response_data = {
                        "status": "different-location",
                        "message": f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or \
                            you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
                    }
                elif not cart_items.filter(product_variant__product__vendor=product_instance.product.vendor).exists():
                    response_data = {
                        "status": "different-location",
                        "message": f"You are adding different products from different shops. Either you can remove current items in your cart and add the current product or \
                            you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
                    }
                else:
                    # check if the product is avail in that zone
                    if product_instance.product.vendor:
                        if product_instance.product.vendor.deliverable_location.filter(pk=zone_session).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                customer=customer,
                            )
                            response_data = {"status": "added"}
                        else:
                            response_data = {"status": "delivery not available"}

                    else:
                        if product_instance.is_special_variant:
                            stock = special_variant_stock(product_instance, zone_session)
                            if stock > 1:
                                CartItem.objects.create(
                                    product_variant = product_instance,
                                    warehouse = warehouse.first(),
                                    customer = customer,
                                )
                                response_data = {"status": "added"}
                            else:
                                response_data = {"status": "not_in_batch"}

                        elif Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=0).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                customer=customer,
                                warehouse = warehouse.first()
                            )
                            response_data = {"status": "added"}

                        else:
                            response_data = {"status": "not_in_batch"}

            else:
            # check if the product is avail in that zone
                if product_instance.product.vendor:
                    if product_instance.product.vendor.deliverable_location.filter(pk=zone_session).exists():
                        CartItem.objects.create(
                            product_variant=product_instance,
                            customer=customer,
                        )
                        response_data = {"status": "added"}
                    else:
                        response_data = {"status": "delivery not available"}

                else:
                    if product_instance.is_special_variant:
                        stock = special_variant_stock(product_instance, zone_session)
                        if stock > 1:
                            CartItem.objects.create(
                                product_variant = product_instance,
                                warehouse = warehouse.first(),
                                customer = customer,
                            )
                            response_data = {"status": "added"}
                        else:
                            response_data = {"status": "not_in_batch"}

                    elif Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=0).exists():
                        CartItem.objects.create(
                            product_variant=product_instance,
                            warehouse = warehouse.first(),
                            customer=customer
                        )
                        response_data = {
                            "status": "added",
                            "cart_count": CartItem.objects.filter(customer=customer).count()
                        }
                    else:
                        response_data = {"status": "not_in_batch"}
        else:
            pass

        if response_data['status'] == 'added':
            response_data['qty'] = 1
    else:
        response_data = {
            "status": "null"
        }

    response_data["cart_count"] = CartItem.objects.filter(customer=customer, is_deleted=False).count()

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def wholesale_add_to_cart(request):
    products = request.GET.get('product_variant')
    product_instance = ProductVariant.objects.get(pk=products)

    response_data = {}

    zone_session = request.session.get('zone', '')

    if request.user.is_authenticated:
        if zone_session:
            location = Zone.objects.filter(pk = zone_session).first()
            warehouse = Warehouse.objects.filter(deliverable_location=location)

            customer = get_user(request.user)
            cart_items = CartItem.objects.filter(customer=customer, is_deleted=False)

            # for wholesale cart additions
            qty = request.GET.get('qty', None) or None
            if qty:
                qty = Decimal(qty)
                if cart_items.exists():
                    if cart_items.filter(product_variant=product_instance).exists():
                        cart_items.filter(product_variant=product_instance).update(qty=F('qty') + qty)
                        qty = cart_items.filter(product_variant=product_instance).first().qty

                        response_data = {"status": "added"}

                    elif not cart_items.filter(warehouse__in=warehouse).exists():
                        response_data = {
                            "status": "different-location",
                            "message": f"Since you are adding {product_instance} from different location either you can remove current items in your cart and add the current product or \
                                you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
                        }
                    elif not cart_items.filter(product_variant__product__vendor=product_instance.product.vendor).exists():
                        response_data = {
                            "status": "different-location",
                            "message": f"You are adding different products from different shops. Either you can remove current items in your cart and add the current product or \
                                you can check out your current cart items with {cart_items.count()} item(s) and proceed to add {product_instance} to your cart"
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
                                response_data = {"status": "added"}
                            else:
                                response_data = {"status": "delivery not available"}
                        else:
                            if product_instance.is_special_variant:
                                stock = special_variant_stock(product_instance, zone_session)
                                if stock > qty:
                                    CartItem.objects.create(
                                        product_variant=product_instance,
                                        customer=customer,
                                        warehouse = warehouse.first(),
                                        qty = qty
                                    )
                                    response_data = {"status": "added"}
                                else:
                                    response_data = {"status": "not_in_batch"}
                            elif Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=0).exists():
                                CartItem.objects.create(
                                    product_variant=product_instance,
                                    customer=customer,
                                    warehouse = warehouse.first(),
                                    qty = qty
                                )
                                response_data = {"status": "added"}
                            else:
                                response_data = {"status": "not_in_batch"}
                else:
                    if product_instance.product.vendor:
                        if product_instance.product.vendor.deliverable_location.filter(pk=zone_session).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                customer=customer,
                                qty = qty
                            )
                            response_data = {"status": "added"}
                        else:
                            response_data = {"status": "delivery not available"}
                    else:
                        if product_instance.is_special_variant:
                            stock = special_variant_stock(product_instance, zone_session)
                            if stock > qty:
                                CartItem.objects.create(
                                    product_variant=product_instance,
                                    customer=customer,
                                    warehouse = warehouse.first(),
                                    qty = qty
                                )
                                response_data = {"status": "added"}
                            else:
                                response_data = {"status": "not_in_batch"}

                        elif Batch.objects.filter(product_variant=product_instance, warehouse__deliverable_location__pk=zone_session, stock__gt=qty).exists():
                            CartItem.objects.create(
                                product_variant=product_instance,
                                warehouse = warehouse.first(),
                                customer=customer,
                                qty = qty
                            )
                            response_data = {"status": "added"}
                        else:
                            response_data = {"status": "not_in_batch"}

                if response_data['status'] == 'added':
                    response_data['qty'] = str(qty)

            # end of whosale order section
    else:
        response_data = {
            "status": "null"
        }
    response_data["cart_count"] = CartItem.objects.filter(customer=customer, is_deleted=False).count()

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def increment_cart(request):
    customer = get_user(request.user)
    products = request.GET.get('product_variant')

    product_instance = ProductVariant.objects.get(pk=products)

    response_data = {}

    # cart item check
    if CartItem.objects.filter(product_variant=product_instance, customer=customer, is_deleted=False).exists():
        cart_item_instance = CartItem.objects.get(product_variant=product_instance, customer=customer, is_deleted=False)
        cart_item_instance.qty = cart_item_instance.qty + 1
        cart_item_instance.price = cart_item_instance.qty * product_instance.mrp

        cart_item_instance.save()

        # new_price = cart_item_instance.price * cart_item_instance.qty
        cart_total = get_cart_total(request)

        response_data = {
            "status": "updated",
            "qty": cart_item_instance.qty,
            "total": str(cart_total)
        }
    else:

        response_data = {
            "status": "error"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def decrement_cart(request):
    products = request.GET.get('product_variant')
    customer = get_user(request.user)
    product_instance = ProductVariant.objects.get(pk=products)

    response_data = {}

    # cart item check
    if CartItem.objects.filter(product_variant=product_instance, customer=customer, is_deleted=False).exists():
        cart_item_instance = CartItem.objects.get(product_variant=product_instance, customer=customer, is_deleted=False)
        cart_item_instance.qty = cart_item_instance.qty - 1
        cart_item_instance.price = cart_item_instance.qty * product_instance.mrp

        if cart_item_instance.qty == 0:
            CartItem.objects.filter(pk=cart_item_instance.pk).delete()
            cart_total = get_cart_total(request)

            if 'coupon_id' in request.session:
                coupon_id = request.session.get('coupon_id', 0) or 0
                if not is_voucher_available(coupon_id, request):
                    del request.session['coupon_id']
                    del request.session['coupon_amt']

            response_data = {
                "status": "true",
                "qty": 0,
                "total": str(cart_total)
            }

            # response_data = {
            #     "status": "stopped",
            #     "message": "cannot deduct from zero"
            # }
        else:
            cart_item_instance.save()

            cart_total = get_cart_total(request)

        response_data = {
            "status": "updated",
            "qty": cart_item_instance.qty,
            "total": str(cart_total)
        }
    else:

        response_data = {
            "status": "eroor"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def product_by_category(request, pk):
    now_time = datetime.datetime.now()
    zone_session = request.session.get('zone', '')
    instance = Category.objects.get(pk=pk)

    if zone_session:
        shop_instances = Vendor.objects.filter(is_deleted=False, zone__pk=zone_session)
    else:
        shop_instances = Vendor.objects.filter(is_deleted=False)

    variants = ProductVariant.objects.filter(is_deleted=False, is_admin_approved=True, is_default=True, product__category_id=pk, product__is_active=True).order_by("-auto_id")
    offer_instance = Offers.objects.filter(start_time__lte=now_time, end_time__gte=now_time, is_deleted=False).order_by('-date_added').first()

    if zone_session:
        offer_instance = Offers.objects.filter(start_time__lte=now_time, end_time__gte=now_time,is_deleted=False, warehouse__deliverable_location__in=[zone_session]).order_by('-date_added').first()

    page = request.GET.get('page', 1)

    paginator = Paginator(variants, 12)
    try:
        variants = paginator.page(page)
    except PageNotAnInteger:
        variants = paginator.page(1)
    except EmptyPage:
        variants = paginator.page(paginator.num_pages)

    context = {
        "title": instance.name,
        'shop_instances': shop_instances,
        "instance": instance,
        "variants": variants,
        "offer_instance": offer_instance,
    }

    return render(request, 'web/category.html', context)


def product_by_subcategory(request, pk):
    zone_session = request.session.get('zone', '')
    subcategory = SubCategory.objects.get(pk=pk)
    variants = ProductVariant.objects.filter(is_deleted=False, is_admin_approved=True, product__is_active=True, is_default=True, product__subcategory=subcategory).order_by("-auto_id")
    if zone_session:
        shop_instances = Vendor.objects.filter(is_deleted=False, zone=zone_session)
    else:
        shop_instances = Vendor.objects.filter(is_deleted=False)

    page = request.GET.get('page', 1)

    paginator = Paginator(variants, 12)
    try:
        variants = paginator.page(page)
    except PageNotAnInteger:
        variants = paginator.page(1)
    except EmptyPage:
        variants = paginator.page(paginator.num_pages)

    context = {
        "title": subcategory.name,
        'subcategory_instances': subcategory,
        'shop_instances': shop_instances,
        "variants": variants
    }

    return render(request, 'web/category.html', context)


def product_by_brand(request, pk):
    zone_session = request.session.get('zone', '')
    brand = Brand.objects.get(pk=pk)

    variants = ProductVariant.objects.filter(is_deleted=False, is_admin_approved=True, product__is_active=True, is_default=True, product__brand=brand).order_by("-auto_id")

    if zone_session:
        shop_instances = Vendor.objects.filter(is_deleted=False, zone=zone_session)
    else:
        shop_instances = Vendor.objects.filter(is_deleted=False)

    page = request.GET.get('page', 1)

    paginator = Paginator(variants, 12)
    try:
        variants = paginator.page(page)
    except PageNotAnInteger:
        variants = paginator.page(1)
    except EmptyPage:
        variants = paginator.page(paginator.num_pages)

    context = {
        "title": f"Products : {brand}",
        'shop_instances': shop_instances,
        "variants": variants
    }

    return render(request, 'web/category.html', context)


@role_required(['customer_user'])
def view_profile(request):
    profile_instance = get_object_or_404(Customer.objects.filter(user__username=request.user))

    addresses = CustomerAddress.objects.filter(is_deleted=False, customer__user=request.user)

    if request.method == "POST":
        form = ProfileForm(request.POST, request.FILES, instance=profile_instance)

        # to check if request is coming through ajax or html
        is_by_html = re.search(r'^text/html', request.META.get('HTTP_ACCEPT'))

        if form.is_valid():
            data = form.save(commit=False)
            data.date_updated = datetime.datetime.now()
            data.save()

            if is_by_html:
                return HttpResponseRedirect(reverse('web:view_profile'))
            else:
                return JsonResponse({
                    'status': 'true',
                    "title": "Successfully Updated",
                    "message": "Profile Successfully Updated.",
                    "redirect": "true",
                    "redirect_url": reverse('web:view_profile')
                })

        else:
            if is_by_html:
                context = {
                    'instance': profile_instance,
                    'form': form,
                    'addresses': addresses,
                    'url': reverse('web:view_profile')
                }
                return render(request, 'web/profile.html', context)

            else:
                return JsonResponse({'error': True, 'errors': form.errors })

    else:
        zone_session = request.session.get('zone', '')
        form = ProfileForm(instance=profile_instance)
        address_form = AddressForm(initial={'zone': zone_session})
        location_form = LocationForm()
        address_instances = CustomerAddress.objects.filter(is_deleted=False, customer__user=request.user)
        address_count = address_instances.count()
        context = {
            'instance': profile_instance,
            'form': form,
            'addresses': addresses,
            'address_form': address_form,
            "address_count":address_count,
            'location_form': location_form,
            'url': reverse('web:view_profile')
        }

        return render(request, 'web/profile.html', context)


@role_required(['customer_user'])
def delete_profile_image(request):
    if request.method == 'POST':
        user = request.user
        profile_instance = get_object_or_404(Customer, user=user)

        # Check if the user has permission to delete the profile image
        if profile_instance.user != user:
            pass

        try:
            # Delete the profile image
            profile_instance.image.delete()
            return JsonResponse({'status': 'success'})
        except Exception as e:
            return JsonResponse({'status': 'error', 'message': str(e)})


def shops(request):
    now = datetime.datetime.now()
    current_date = now.strftime("%Y-%m-%d")

    zone_session = request.session.get('zone', '')
    print("zone--------", zone_session)

    if zone_session:
        shop_instance = Vendor.objects.filter(is_deleted=False, zone__pk=zone_session)
    else:
        shop_instance = Vendor.objects.filter(is_deleted=False)
    variants = ProductVariant.objects.filter(is_deleted=False, product__is_active=True, is_admin_approved=True, is_default=True).order_by("-auto_id")
    deals_of_day = DealOfDay.objects.filter(deal_date__gte=current_date).first()
    offer_instance = Offers.objects.filter(start_time__lte=now, end_time__gte=now, is_deleted=False).order_by(
        '-date_added').first()

    if zone_session:
        offer_instance = Offers.objects.filter(start_time__lte=now, end_time__gte=now, is_deleted=False, warehouse__deliverable_location__in=[zone_session]).order_by('-date_added').first()

    query = request.GET.get("q")

    if query:
        shop_instance = shop_instance.filter(
            Q(name__icontains=query) |
            Q(arabic_name__icontains=query)
        )
        variants = variants.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query)
        )
    context = {
        "title": "Shops",
        "search_title": "shops",

        'is_shop': True,
        'instances': shop_instance,
        'variants': variants,
        'deals_of_day': deals_of_day,
        "offer_instance": offer_instance,
    }

    return render(request, 'web/shops.html', context)


@role_required(['customer_user'])
def payment(request):
    # for creating address
    if request.method == "POST":
        is_home_or_office = request.POST.get('homeoroffice')
        is_default = request.POST.get('default')

        print("Is home or office", is_home_or_office)

        form = AddressForm(request.POST)
        location_form = LocationForm(request.POST, request.FILES)

        if form.is_valid()  and location_form.is_valid():
            location_name = location_form.cleaned_data['location']
            latitude = location_form.cleaned_data['latitude']
            longitude = location_form.cleaned_data['longitude']

            location = get_or_create_location(request, location_form, location_name, latitude, longitude)

            if location:
                address_data = form.save(commit=False)
                address_data.customer = get_user(request.user)
                address_data.location = location

                if is_home_or_office == 'office':
                    print("office")
                    address_data.address_type = 20
                else:
                    # if is_home_or_office == 'home':
                    address_data.address_type = 10
                    print("home")

                if is_default:
                    if CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False, is_default=True).exists():
                        CustomerAddress.objects.filter(customer__user=request.user, is_deleted=False, is_default=True).update(is_default=False)
                        address_data.is_default = True
                    else:
                        address_data.is_default = True
                else:
                    address_data.is_default = False

                address_data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Added",
                    "message": "Delivery Address Successfully Added.",
                    "redirect": "true",
                    "redirect_url": reverse('web:payment')
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            # return HttpResponseRedirect(reverse('web:payment'))

        else:
            print("print form error 1 ")
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        cart_instances = CartItem.objects.filter(is_deleted=False, customer__user=request.user)
        address_instances = CustomerAddress.objects.filter(is_deleted=False, customer__user=request.user)
        pin_code_instances = Location.objects.filter(is_deleted=False)
        time_slots = TimeSlot.objects.filter(is_deleted=False, is_active=True)
        zone_session = request.session.get('zone', '')
        if zone_session:
            zone = Zone.objects.get(pk=zone_session)
        else:
            zone = None

        address_count = address_instances.count()
        is_vendor = False

        if cart_instances.exists():
            if cart_instances.first().product_variant.product.vendor:
                is_vendor = True
        else:
            return HttpResponseRedirect(reverse('web:index'))

        address_form = AddressForm(initial={'zone': zone_session})
        location_form = LocationForm()

        context = {
            'title': "Payment",
            'cart_instances': cart_instances,
            'address_instances': address_instances,
            'pin_code_instances': pin_code_instances,
            "time_slots": time_slots,
            "zone":zone,

            'address_count': address_count,
            'address_form': address_form,
            'location_form': location_form,

            'url': reverse("web:payment"),

            'redirect': True,
            'is_no_need_autocomplete': True,
            'is_need_ui': True,
            'is_vendor' : is_vendor
        }

        return render(request, 'web/payment.html', context)


def validate_order(request):
    # payment_method = request.GET.get('method')
    time_slot = request.GET.get('time_slot')
    delivery_type = request.GET.get('delivery_type')
    delivery_date = request.GET.get('delivery_date')

    formatted_date = datetime.datetime.now().date()

    if delivery_date:
        formatted_date = datetime.datetime.strptime(delivery_date, "%d-%m-%Y")

    # zone_session = request.session.get('zone', '')

    # if time slot exists take the instance to the variable
    # time_slot_instance = None
    # if time_slot:
    #     time_slot_instance = TimeSlot.objects.get(pk=time_slot)

    customer = Customer.objects.get(user=request.user)
    address_instance = CustomerAddress.objects.get(customer__user=request.user,is_deleted=False, is_default=True)

    stock_ok, data, error_message = check_stock_availability(request)
    if stock_ok:
        distributer_id = data
        deliverable_zones = []

        if Warehouse.objects.filter(id=distributer_id).exists():
            warehouse = Warehouse.objects.get(id=distributer_id)
            deliverable_zones = warehouse.deliverable_location.all()
            non_deliverable_zones = warehouse.no_express_delivery.all()
            vendor = None

        elif Vendor.objects.filter(id=distributer_id).exists():
            vendor = Vendor.objects.get(id=distributer_id)
            deliverable_zones = vendor.deliverable_location.all()
            non_deliverable_zones = Zone.objects.none()
            warehouse = None

        print(delivery_type,'-------------------------')

        if address_instance.zone in deliverable_zones:
            if delivery_type == "express" and non_deliverable_zones.filter(id=address_instance.zone_id).exists():
                data = {
                    "status": "false",
                    "title": "Express delivery not available",
                    "message": "The selected address area is not on the Express Delivery Zone list.",
                }
            else:
                data = {
                    "status": "true",
                }
        else:
            data = {
                "status": "false",
                "title": "Delivery Zone Error",
                "message": "The selected address zone doesn't match the product's zone in your cart.",
            }
    else:
        data = {
            "status": "false",
            "title": "Stock unavailable",
            "message": error_message,
        }
    return JsonResponse(data)


def create_razorpay_order_id(request):
    client = razorpay.Client(auth=(SETTINGS.RAZORPAY_API_KEY, SETTINGS.RZP_SECRET_KEY))
    cart_grand_total = web_context(request)['cart_grand_total']
    customer = Customer.objects.get(user=request.user)
    order = client.order.create({
        'amount': int(cart_grand_total * 100),  # Convert to integer
        'currency': 'INR',
        'receipt': 'receipt#1',
        'payment_capture': 1
    })
    print("RAZORPAY ORDER ID : ", order['id'])
    data = {
        'order_id': order['id'],
        'razorpay_api_key': settings.RAZORPAY_API_KEY,
        'cart_grand_total': cart_grand_total,
        'customer_name': customer.name,
        'customer_email': customer.email,
        'customer_phone': customer.phone,
    }
    return JsonResponse(data)

@csrf_exempt
def verify_payment_signature(request):
    if request.method == 'POST':
        razorpay_payment_id = request.POST.get('razorpay_payment_id')
        razorpay_order_id = request.POST.get('razorpay_order_id')
        razorpay_signature = request.POST.get('razorpay_signature')

        client = razorpay.Client(auth=(settings.RAZORPAY_API_KEY, settings.RZP_SECRET_KEY))

        try:
            client.utility.verify_payment_signature({
                'razorpay_order_id': razorpay_order_id,
                'razorpay_payment_id': razorpay_payment_id,
                'razorpay_signature': razorpay_signature
            })
            response_data = {
                'status': "success"
            }

        except Exception as e:
            response_data = {
                'status': "failed",
                'error': str(e)
            }
    else:
        response_data = {
            'status': "failed",
            'error': 'Invalid HTTP method'
        }

    return JsonResponse(response_data)


@role_required(['customer_user'])
def delete_address(request, pk):
    CustomerAddress.objects.filter(pk=pk).update(is_deleted=True)

    source = request.GET.get('source', '')

    if source == 'profile':
        redirect_url = reverse('web:view_profile')
    elif source == 'payment':
        redirect_url = reverse('web:payment')
    else:
        redirect_url = reverse('web:view_profile')

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Address Successfully Deleted.",
        "redirect": "true",
        "redirect_url": redirect_url
    }

    # return HttpResponse(json.dumps(response_data), content_type='application/javascript')
    return HttpResponseRedirect(redirect_url)


@role_required(['customer_user'])
def get_address_edit_form(request, pk):
    instance = CustomerAddress.objects.get(pk=pk)
    location = instance.location

    form = AddressForm(instance=instance)
    location_form = LocationForm(instance=location)

    context = {
        "pk": pk,
        "address_form": form,
        "location_form": location_form,
        "address_type": instance.address_type,
    }
    html_content = render_to_string('web/includes/address-form.html', context, request=request)

    response_data = {
        "status": "true",
        "html_content": html_content,
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def edit_address(request, pk):
    instance = CustomerAddress.objects.get(pk=pk)
    location= instance.location

    form = AddressForm(request.POST, instance=instance)
    location_form = LocationForm(request.POST, request.FILES,instance=location)

    if form.is_valid() and location_form.is_valid():
        location_name = location_form.cleaned_data['location']
        latitude = location_form.cleaned_data['latitude']
        longitude = location_form.cleaned_data['longitude']

        location = get_or_create_location(request, location_form, location_name, latitude, longitude)
        is_home_or_office = request.POST.get('homeoroffice')

        data = form.save(commit=False)
        data.location = location

        if is_home_or_office == 'home':
            data.address_type = 10
            print("home")

        elif is_home_or_office == 'office':
            print("office")
            data.address_type = 20

        data.save()

        CustomerAddress.objects.filter(customer__user=request.user).exclude(id=pk).update(is_default=False)

        response_data = {
            "status": "true",
            "title": "Successfully Updated",
            "message": "Delivery Address Successfully Updated.",
            "redirect": "true",
            "redirect_url": reverse('web:payment')
        }

    else:
        response_data = {
            "status": "false",
            "title": "Validation error!",
            "message": generate_form_errors(form, False)
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    # return HttpResponseRedirect(reverse('web:payment'))


@role_required(['customer_user'])
def proceed_to_payment(request, pk):

    context = {
        'url': reverse("web:payment"),

        'redirect': True,
        'is_no_need_autocomplete': True
    }

    return render(request, 'web/payment.html', context)


@role_required(['customer_user'])
def set_default_address(request):
    address_pk = request.GET.get('address')

    if CustomerAddress.objects.filter(pk=address_pk).exists():
        if CustomerAddress.objects.filter(customer__user=request.user, is_default=True).exists():
            CustomerAddress.objects.filter(customer__user=request.user, is_default=True).update(is_default=False)
        # check adress pk
        CustomerAddress.objects.filter(pk=address_pk).update(is_default=True)

        response_data = {
            "status": "true"
        }
    else:
        response_data = {
            "status": "false"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def remove_cart(request):
    cart_pk = request.GET.get('pk')

    CartItem.objects.filter(pk=cart_pk).delete()

    if 'coupon_id' in request.session:
        coupon_id = request.session.get('coupon_id', 0) or 0
        if not is_voucher_available(coupon_id, request):
            del request.session['coupon_id']
            del request.session['coupon_amt']

    cart_total = get_cart_total(request)

    response_data = {
        "status": "true",
        "total": str(cart_total),
        "cart_count": CartItem.objects.filter(customer__user=request.user).count()
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def place_order(request):
    payment_method = request.GET.get('method')
    time_slot = request.GET.get('time_slot')
    delivery_type = request.GET.get('delivery_type')
    delivery_date = request.GET.get('delivery_date')

    formatted_date = datetime.datetime.now().date()

    if delivery_date:
        formatted_date = datetime.datetime.strptime(delivery_date, "%d-%m-%Y")

    # eg: credit card number, upi id, debit card number
    source_number = request.GET.get('number')

    # coupon get from session
    coupon_session_amt = 0
    if 'coupon_amt' in request.session:
        coupon_session_amt = request.session.get('coupon_amt', 0) or 0

    wallet = 0
    if 'wallet' in request.session:
        wallet = request.session.get('wallet', '')

    zone_session = request.session.get('zone', '')

    # if time slot exists take the instance to the variable
    time_slot_instance = None
    if time_slot:
        time_slot_instance = TimeSlot.objects.get(pk=time_slot)

    customer = Customer.objects.get(user=request.user)
    address_instance = CustomerAddress.objects.get(customer__user=request.user,is_deleted=False, is_default=True)

    stock_ok, data, error_message = check_stock_availability(request)
    if stock_ok:
        distributer_id = data
        deliverable_zones = []

        if Warehouse.objects.filter(id=distributer_id).exists():
            warehouse = Warehouse.objects.get(id=distributer_id)
            deliverable_zones = warehouse.deliverable_location.all()
            non_deliverable_zones = warehouse.no_express_delivery.all()
            vendor = None

        elif Vendor.objects.filter(id=distributer_id).exists():
            vendor = Vendor.objects.get(id=distributer_id)
            deliverable_zones = vendor.deliverable_location.all()
            non_deliverable_zones = Zone.objects.none()
            warehouse = None

        print(delivery_type,'-------------------------')

        if address_instance.zone in deliverable_zones:
            cart_total = get_cart_total(request)
            if delivery_type == "normal":
                delivery_charge = get_delivery_charge(request,cart_total)
            else:
                print('--------------------\n\n\n\n')
                print(non_deliverable_zones)
                print(address_instance.zone)
                if non_deliverable_zones.filter(id=address_instance.zone_id).exists():
                    print('--------------------\n\n\n\n')
                    return JsonResponse({
                        "status": "different-location",
                        "message": "The selected address area is not on the Express Delivery Zone list."
                    })
                delivery_charge = get_express_charge(request)

            # if coupon and wallet exists will be deducted
            total_amt = get_grand_total(cart_total, delivery_charge, request)

            order_id = get_order_prefix()
            order_no = 0
            prefix = None

            if InvoicePrefix.objects.filter(is_active=True, is_deleted=False).exists():
                prefix = InvoicePrefix.objects.filter(is_active=True, is_deleted=False).first()
                pr_orders = Orders.objects.filter(prefix=prefix)

                if pr_orders.filter(prefix=prefix).exists():
                    order_no = pr_orders.filter(prefix=prefix).aggregate(Max('order_no'))['order_no__max']

                order_no += 1
                order_id = f"{prefix.order}{str(order_no).zfill(6)}"

            order = Orders.objects.create(
                auto_id=get_auto_id(Orders),
                creator=request.user,
                updater=request.user,
                customer=customer,
                warehouse = warehouse,
                vendor = vendor,
                zone = address_instance.zone,

                total_amt = total_amt,
                wallet_amount = wallet,
                voucher_amount = coupon_session_amt,
                delivery_charge = delivery_charge,

                billing_name=address_instance.name,
                billing_phone=address_instance.phone,
                billing_address=address_instance.house_name,
                billing_street=address_instance.street,
                billing_landmark=address_instance.landmark,
                billing_city=address_instance.city,
                billing_state=address_instance.state,
                billing_latitude=address_instance.location.latitude,
                billing_longitude=address_instance.location.longitude,

                order_id=order_id,
                order_no=order_no,
                prefix=prefix,

                payment_method=payment_method,
                payment_status="10",
                card_number=source_number,

                order_status="10",
                time_slot=time_slot_instance,
                delivery_date=formatted_date,
            )

            message = f"Your order {order_id} is placed and expected delivered by {formatted_date}."
            """try:
                email = SendEmail('placed', customer.email, message)
                print(f"Mail =========> {email}")
            except Exception as e:
                print(f"Error sending email: {e}")
            # msg = sendSMS('placed', customer.phone, [order_id, str(formatted_date)])
            print('\n\n-------------', message, '-------------\n\n')"""
            message_type = "orderstatus"
            phone = customer.phone
            sendSMSConfirmation(phone,order_id)

            # print(message)
            clear_cart(customer, order, zone_session, request)

            users = User.objects.filter(is_active=True)
            user_pks = list(users.filter(is_superuser=True).values_list('pk', flat=True))

            if vendor:
                user_pks += [vendor.user.pk]
            elif warehouse:
                user_pks += [warehouse.manager.pk]
                user_pks += warehouse.staff_set.filter(is_deleted=False, staff_role__in=["warehouse_manager", "billing_staff"]).values_list('pk', flat=True)

            sent_to_users = users.filter(pk__in=user_pks)
            for user in sent_to_users:
                send_notification(user, "New Order", "You have a new Order", data=None)

            if 'wallet' in request.session:
                point = request.session.get('wallet', '')
                wallet_amount = update_privilege_point(customer, 'used', int(point),order_instance= order)
                # customer.current_privilege_points = customer.current_privilege_points - Decimal(point)
                # customer.save()
                del request.session['wallet']

            if 'coupon_id' in request.session and coupon_session_amt:
                coupon_id = request.session['coupon_id']
                VoucherCode.objects.get(pk=coupon_id).used_users.add(request.user)

                del request.session['coupon_id']
                del request.session['coupon_amt']

            response_data = {
                "status": "true",
                "pk": str(order.pk)
            }
        else:
            response_data = {
                "status": "different-location",
                "message": "The selected address zone doesn't match the product's zone in your cart."
            }
    else:
        response_data = {
            "status": "stock-unavailable",
            "data": data,
            "error_message": error_message
        }
    return JsonResponse(response_data)


@role_required(['customer_user'])
def view_orders(request):
    instances = Orders.objects.filter(customer__user=request.user, is_deleted=False)
    print(instances, "instances===++")
    can_rate = True

    # for i in instances:
    #     if ProductReview.objects.filter(product_variant=i.product_variant, creator=request.user).exists():
    #         can_rate == False

    context = {
        "title": "Order Confirmed",
        'instances': instances,
        'can_rate': can_rate,
        'user': request.user
    }
    return render(request, 'web/my-orders.html', context)


@role_required(['customer_user'])
def order_confirmed(request):
    order_pk = request.GET.get('order')

    order_instance = Orders.objects.get(pk=order_pk)
    order_item_instances = OrderItem.objects.filter(order=order_instance)

    context = {
        "title": "Order Confirmed",
        'order_instance': order_instance,
        'order_item_instances': order_item_instances,
    }
    return render(request, 'web/order-confirmed.html', context)


def set_pincode(request):
    zone = request.GET.get('zone')
    print("set_zone----------------------------", zone)

    request.session['zone'] = zone

    if request.user.is_authenticated:
        if CartItem.objects.filter(customer__user=request.user, is_deleted=False).exists():
            stock_ok, data, error_message = check_stock_availability(request)
            print("Stock True or False ============= ", stock_ok)

            if stock_ok:
                response_data = {"status": "true"}
            else:
                all_cart_items = CartItem.objects.filter(customer__user=request.user, is_deleted=False)
                for item in all_cart_items:
                    batches = Batch.objects.filter(product_variant=item.product_variant, warehouse__deliverable_location__in=zone, is_deleted=False, stock__gt=0)
                    if batches.exists():
                        pass
                    else:
                        item.delete()
                        print("Deleted Cart Items ------------------------------------------------------------ ", item)
                response_data = {"status": "true"}
        else:
            response_data = {"status": "true"}
    else:
        response_data = {"status": "true"}

    print("---------------------------", response_data)

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_pincode(request):
    pincode = request.GET.get('pincode')
    if pincode:
        if Zone.objects.filter(pincode=pincode).exists():
            pincode = Zone.objects.filter(pincode=pincode).first()
            response_data = {
                "status": "true",
                "pk": str(pincode.pk),
                "name": str(pincode)
            }
            return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    response_data = {
        "status": "false",
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def book_product(request):
    product_variant_pk = request.GET.get('product')

    product_variant = ProductVariant.objects.get(pk=product_variant_pk)

    booked_product = Booking.objects.create(
        customer=get_user(request.user),
        product_variant=product_variant,
        message="",
        status="pending",
    )

    response_data = {
        "status": "true"
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def view_booked_product(request):
    instances = Booking.objects.filter(customer__user=request.user)

    context = {
        "title": "Booked Products",
        'instances': instances,
    }
    return render(request, 'web/my-booking.html', context)


def shop(request, pk):
    shop = Vendor.objects.get(pk=pk,is_deleted=False)
    product_variants = ProductVariant.objects.filter(product__vendor__pk=pk, is_admin_approved=True, product__is_active=True, product__is_deleted=False).order_by("-auto_id")

    context = {
        "title": shop.name,
        "shop": shop,
        "product_variants": product_variants,
    }

    return render(request, 'web/shop-single.html', context)


@role_required(['customer_user'])
def apply_coupon(request):
    response_data = {}
    pk = request.GET.get('pk')
    total_amt = get_cart_total(request)

    # clear the seession cookies
    if 'coupon_amt' and 'coupon_id' in request.session:
        request.session['coupon_id'] = None
        request.session['coupon_amt'] = None

    # checking if the voucher exists or not
    if VoucherCode.objects.filter(is_deleted=False, pk=pk).exists():
        if is_voucher_available(pk, request):
            voucher_instance = VoucherCode.objects.get(pk=pk)
            percent_amt = total_amt * voucher_instance.percentage / 100

            if percent_amt > voucher_instance.upto_limit:
                diff_amt = total_amt - voucher_instance.upto_limit
                stored_amt = voucher_instance.upto_limit
            else:
                diff_amt = total_amt - percent_amt
                stored_amt = percent_amt

            new_amt = total_amt - stored_amt

            if 'wallet' in request.session:
                new_amt = new_amt - Decimal(request.session.get('wallet', ''))

            # store coupon percent amt to session
            request.session['coupon_amt'] = str(stored_amt)
            request.session['coupon_id'] = str(voucher_instance.pk)

            response_data = {
                "status": "true",
                "total_amt": str(new_amt),
                "percent_amt": str(stored_amt),
                "coupon_code": str(voucher_instance.voucher_code),
                "coupon_pk": str(voucher_instance.pk)
            }

        else:
            response_data = {
                "status": "false",
            }
    else:
        response_data = {
            "status": "0",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def remove_coupon(request):
    try:
        request.session['coupon_id'] = None
        request.session['coupon_amt'] = None

        response_data = {
            "status": "true",
        }

    except Exception as e:
        print(f"\n\n\n\n\n\n{e}\n\n\n\n\n\n")
        response_data = {
            "status": "0",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def order_cancel(request):
    response_data = {}

    pk = request.GET.get('pk')
    reason = request.GET.get('reason')

    # check if order exists
    if Orders.objects.filter(pk=pk).exists():
        Orders.objects.filter(pk=pk).update(order_status='40')
        response_data = {
            "status": "true",
        }
    else:
        response_data = {
            "status": "false",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def product_variant_switch(request):
    response_data = {}

    try:
        pk = request.GET.get('pk')
        language_code = request.LANGUAGE_CODE

        variant = ProductVariant.objects.get(pk=pk)

        stock = 0
        cart = False
        cart_qty = 0
        zone = None
        is_wishlist = False

        mrp = variant.mrp
        retail_price = variant.retail_price
        image = variant.image.url if variant.image else variant.product.image.url

        if request.user.is_authenticated:
            cart_instance = CartItem.objects.filter(product_variant__pk=pk, customer__user=request.user, is_deleted=False)
            if cart_instance.exists():
                cart = True
                cart_qty = cart_instance.first().qty

            if is_zone_exists(request):
                zone = get_zone(request)

            batchs = Batch.objects.filter(warehouse__deliverable_location__in=[zone], stock__gt=0, is_deleted=False, product_variant=variant)
            if batchs.exists():
                batch = batchs.order_by('-date_added').first()
                mrp = batch.mrp
                stock = batch.stock
                retail_price = batch.retail_price

            if Wishlistitem.objects.filter(customer__user=request.user, product_variant=variant, is_deleted=False).exists():
                is_wishlist = True

        name = None
        if 'ar' in language_code:
            name = variant.get_arabic_name()

        elif 'en' in language_code:
            name = variant.get_fullname()

        unit = variant.unit.unit

        response_data = {
            "status": "true",
            "name": name,
            "unit": unit,
            "pk": str(pk),
            "mrp": str(mrp),
            "cart": str(cart),
            "image": str(image),
            "stock": str(stock),
            "cart_qty": str(cart_qty),
            "is_wishlist": str(is_wishlist),
            "retail_price": str(retail_price),
        }
    except Exception as e:
        response_data = {
            "status": "false",
        }
        print("Errorr===:", e)

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_pincode_by_name(request):
    places = []

    name = request.GET.get('name')

    baseurl_1 = f"https://api.postalpincode.in/pincode/691559"
    baseurl_place = f"https://api.postalpincode.in/postoffice/{name}"
    baseurl_2 = f"https://maps.googleapis.com/maps/api/geocode/json?address=691559&key={SETTINGS.PLACES_MAPS_API_KEY}"

    postofficeapi_response = requests.get(baseurl_1).json()
    googleapi_response = requests.get(baseurl_2).json()

    place_name_response = requests.get(baseurl_place).json()

    print(googleapi_response)

    if postofficeapi_response[0]["Status"] == 'Success' and googleapi_response['status'] == 'OK':

        if 'PostOffice' in postofficeapi_response[0] and 'postal_code' in googleapi_response['results'][0]['types']:
            for post_offices in postofficeapi_response[0]['PostOffice']:
                response = post_offices
                print(googleapi_response['results'][0]['geometry']['location']['lng'])

        places = []
        post_office_response = place_name_response[0]["PostOffice"]

        if post_office_response:
            for name in place_name_response[0]["PostOffice"]:
                print(name['Name'])
                data = {
                    "name": name['Name'],
                    "pincode": name['Pincode']
                }
                places.append(data)
        else:
            data = {
                "name": "Not Exists!",
                "pincode": "Place not exists"
            }
            places.append(data)

    response_data = {
        "status": "true",
        "values": json.dumps(places),
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


# @role_required(['customer_user'])

#     response_data = {}

#     try:
#         description = request.GET.get('description')
#         subject = request.GET.get('issue_title')
#         print("subject ", subject)
#         attachment = request.GET.get('attachment')
#         customer = get_user(request.user)

#         Ticket.objects.create(
#             customer=customer,
#             subject = subject,
#             attachment = attachment,
#             description=description,
#             auto_id=get_auto_id(Ticket),
#             creator=request.user,
#             updater=request.user,
#             status="pending",
#         )

#         response_data = {
#             "status": True
#         }

#     except Exception as e:
#         print("ERROR ===>>", e)
#         response_data = {
#             "status": False,
#             "message": str(e)
#         }

#     return HttpResponse(json.dumps(response_data), content_type='application/javascript')
@role_required(['customer_user'])
def new_issue(request):
    response_data = {
        "status": 'false',
        "title" : " Oops! Try Again ",
        "message" : "Failed to submit, try again after refreshing the page"
    }

    if request.method == "POST":
        form = TicketForm(request.POST, request.FILES)

        if form.is_valid():
            data = form.save(commit=False)
            data.customer = request.user.customer
            data.creator = request.user
            data.status = 'pending'
            data.updater = request.user
            data.auto_id = get_auto_id(Ticket)
            data.save()

            print(data)
            print(request.user.customer)

            response_data = {
                "status": 'true',
                "title" : "Successfully Submitted",
                "message" : "New Ticket Has Been Successfully Submitted.",
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": 'false',
                "title" : "Oops! Try Again ",
                "message" : str(message) ,
            }

    return HttpResponse(json.dumps(response_data),content_type='application/javascript')


@role_required(['customer_user'])
def apply_wallet_amount(request):
    point = Decimal(request.GET.get('point'))
    response_data = {}
    points_amt = 0
    try:
        if 'wallet' in request.session:
            request.session['wallet'] = None

        cart_item_price = get_cart_total(request)

        customer_instance = Customer.objects.get(user=request.user)
        wallet = customer_instance.current_privilege_points

        if point <= wallet:
            if PrivilegePoint.objects.filter(is_deleted=False):
                value_points = PrivilegePoint.objects.filter(is_deleted=False).first().value_of_point
                points_amt = value_points * point

            if points_amt > cart_item_price:
                response_data = {
                    "status": False,
                    "state": "exceed",
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            else:
                request.session['wallet'] = str(point)
                new_total = cart_item_price - points_amt
                customer_instance.save()

                if 'coupon_amt' in request.session:
                    new_total = new_total - Decimal(request.session.get('coupon_amt', ''))

                response_data = {
                    "status": True,
                    "value": str(points_amt),
                    "total": str(new_total),
                    "message": "Wallet Balance Applied Successfully"
                }

    except Exception as e:
        response_data = {
            "status": False,
            "message": "Something went wrong",
            "error": str(e),
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_time_slots(request):
    response_data = {}
    date = request.GET.get('date')
    today = datetime.datetime.now()

    try:
        date_format = datetime.datetime.strptime(date, "%d-%m-%Y")
    except:
        try:
            date_format = datetime.datetime.strptime(date, "%Y-%m-%d")
        except:
            date_format = None
    print(date_format, '-------------------------')

    week_number = date_format.isoweekday()

    time_slot_instances = TimeSlot.objects.filter(is_deleted=False, is_active=True, day=week_number)

    if date_format.date() == today.date():
        time_slot_instances = time_slot_instances.filter(start_time__gt=today.time())

    # response_data = {
    #     "slots": serializers.serialize('json', time_slot_instances),
    # }

    slots = []
    for slot in time_slot_instances:
        slots.append({
            'pk': str(slot.pk),
            'name': str(slot),
        })

    response_data = {
        "slots": slots,
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def post_rating(request):
    rating = request.GET.get('rating')
    review = request.GET.get('review', None)
    product_id = request.GET.get('product_id')

    print(rating,"rating +++++++++++++++++++++++++")
    print(review,"review +++++++++++++++++++")
    print(product_id,"product_id ++++++++++++++++++")

    product_variant = ProductVariant.objects.filter(pk=product_id).first()

    print(product_variant,"product_variant")
    title = "Rated Successfully"
    message = "Ratings Submitted Successfully"

    # for i in order_item_instances:
    if not ProductReview.objects.filter(product_variant=product_variant, creator=request.user).exists():
        # if review:
        ProductReview.objects.create(
            product_variant=product_variant,
            rating=rating,
            creator=request.user,
            updater=request.user,
            auto_id=get_auto_id(ProductReview),
            review=review,
        )
        # else:
        #     ProductReview.objects.create(
        #         product_variant=product_variant,
        #         rating=rating,
        #         creator=request.user,
        #         updater=request.user,
        #         auto_id=get_auto_id(ProductReview),
        #     )

        update_current_rating(product_variant)
    else:
        if review:
            ProductReview.objects.filter(product_variant=product_variant, creator=request.user).update(
                rating=rating,
                updater=request.user,
                review=review,
            )
        else:
            ProductReview.objects.filter(product_variant=product_variant, creator=request.user).update(
                rating=rating,
                updater=request.user
            )
        update_current_rating(product_variant)
        title = "Rating Updated Successfully"
        message = "Ratings Updating Successfully"


    response_data = {
        "status": True,
        "title": title,
        "message": message
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def search(request):
    variants = ProductVariant.objects.filter(is_deleted=False, is_default=True, is_admin_approved=True, product__is_active=True).order_by("-auto_id")

    query = request.GET.get('query')

    if query:
        variants = variants.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query) |
            Q(product__brand__name__icontains=query) |
            Q(product__category__name__icontains=query) |
            Q(product__meta_description__iregex=r'[[:<:]]' + re.escape(query)) |
            Q(product__subcategory__name__icontains=query)
        )

    page = request.GET.get('page', 1)

    paginator = Paginator(variants, 12)
    try:
        variants = paginator.page(page)
    except PageNotAnInteger:
        variants = paginator.page(1)
    except EmptyPage:
        variants = paginator.page(paginator.num_pages)

    context = {
        "title": f"",
        "variants": variants,
        "is_search": True,
        "search_query" : query
    }

    return render(request, 'web/category.html', context)


@role_required(['customer_user'])
def clear_sessions(request):
    # clear all the sessions
    if 'coupon_amt' in request.session:
        del request.session['coupon_amt']

    if 'wallet' in request.session:
        del request.session['wallet']

    if 'coupon_id' in request.session:
        del request.session['coupon_id']

    response_data = {
        "status": True,
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def logout_customer(request):
    logout(request)
    return redirect(reverse('web:index'))


@role_required(['customer_user'])
def product_return(request):
    response_data = {}

    try:
        order_item_id = request.GET.get('order_item_pk')
        reason_for_return = request.GET.get('cancel_reason')
        return_specification = request.GET.get('cancel_review')

        order_item_instances = OrderItem.objects.get(pk=order_item_id)

        save_return(order_item_instances.pk, reason_for_return, return_specification, request)

        response_data = {
            "status": 'accepted',
        }

    except Exception as e:
        response_data = {
            "status": str(e),
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def get_product_details_from_order_item(request):
    response_data = {}

    try:
        order_item_pk = request.GET.get('order_item_pk')
        order_item_instances = OrderItem.objects.get(pk=order_item_pk)
        product_variant_instance = ProductVariant.objects.get(pk=order_item_instances.product_variant.pk)

        response_data = {
            "status": True,
            "product_name": product_variant_instance.get_fullname(),
            "product_image": request.build_absolute_uri(product_variant_instance.image.url),
            "product_category": product_variant_instance.product.category.name,
            "product_mrp": str(order_item_instances.price),
            "order_item_pk": str(order_item_instances.pk),
        }

    except Exception as e:
        response_data = {
            "status": False,
            "message": str(e),
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
def cancel_order(request):
    response_data = {}

    try:
        order_pk = request.GET.get('order_pk')

        order_instances = Orders.objects.get(pk=order_pk)

        is_eligible = is_eligible_for_cancel(order_instances)

        if is_eligible:
            response_data = {
                "status": "failed",
            }

            if order_instances.order_status == "10":
                order_instances.order_status = "40"
                order_instances.save()

                for order_item in OrderItem.objects.filter(is_deleted=False, order_id=order_pk):
                    order_item.is_cancelled = True
                    order_item.save()

                    batch = order_item.batch
                    batch.stock += order_item.qty
                    batch.save()

                response_data = {
                    "status": "cancelled",
                }

        else:
            response_data = {
                "status": "failed",
            }

    except Exception as e:
        print(e)
        response_data = {
            "status": False,
            "message": str(e),
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['customer_user'])
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
                    print(order.order_status)
                    response_data = {
                        "status": "cancelled",
                        "message": "Successfully cancelled",
                    }
                else:
                    order.order_status = 40
                    order.delivery_charge = 0
                    order.save()
                    print(order.order_status)
                    response_data = {
                        "status": "order_cancelled",
                        "message": "Successfully cancelled",
                    }

            else:
                print("Item is not eligible for cancellation")
                response_data = {
                    "status": "not_eligible",
                    "message": "Not eligible for cancellation",
                }
        else:
            response_data = {
                "status": "failed",
                "message": "Already Cancelled",
            }

    except Exception as e:
        response_data = {
            "status": "failed",
            "message": str(e),
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff'])
def create_spotlight_banner(request):
    if request.method == 'POST':
        form = SpotlightBannerForm(request.POST, request.FILES)
        if form.is_valid():
            auto_id = get_auto_id(SpotlightBanner)

            # create spotlight banner
            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.auto_id = auto_id

            data.save()

            response_data = {
                "status": "true",
                "stable": "false",
                "title": "Successfully Created",
                "message": "Spotlight Banner Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('web:spotlight_banner', kwargs={'pk': data.pk})
            }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validatruetion error",
                "message": str(message)
            }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        print("HLOooooooooo")
        form = SpotlightBannerForm()
        context = {
            "title": "Create Spotlight Banner ",
            "form": form,
            "stable": "true",
            "url": reverse('web:create_spotlight_banner'),

        }
        return render(request, 'web/spotlight_banner/spotlight_banner_entry.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def spotlight_banners(request):
    instances = SpotlightBanner.objects.filter(is_deleted=False)
    title = "Spotlight Banners"
    query = request.GET.get('query')
    if query:
        instances = get_queried_params(query, instances)

    context = {
        "instances": instances,
        'title': title,
        "query": query,

    }
    return render(request, 'web/spotlight_banner/spotlight_banners.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def spotlight_banner(request, pk):
    instance = get_object_or_404(
        SpotlightBanner.objects.filter(pk=pk, is_deleted=False))

    context = {
        "instance": instance,
        "title": "Spotlight Banner",
        "single_page": True,

    }
    return render(request, 'web/spotlight_banner/spotlight_banner.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def edit_spotlight_banner(request, pk):
    instance = get_object_or_404(
        SpotlightBanner.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = SpotlightBannerForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():

            # update spotlight banner
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Spotlight Banner Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('web:spotlight_banner', kwargs={'pk': data.pk})
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:

        form = SpotlightBannerForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Spotlight Banner",
            "instance": instance,
            "url": reverse('web:edit_spotlight_banner', kwargs={'pk': instance.pk}),
            "redirect": True,

        }
        return render(request, 'web/spotlight_banner/edit.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def delete_spotlight_banner(request, pk):
    reason = request.GET.get('reason')

    SpotlightBanner.objects.filter(pk=pk).update(
        is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Spotlight Banner Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('web:spotlight_banners')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')



@role_required(['customer_user'])
def view_rewards(request):
    profile_instance = get_object_or_404(Customer.objects.filter(user__username=request.user))
    privilege_history = PrivilegePointHistory.objects.filter(customer__user=request.user)

    print("privilege_history",privilege_history)
    context = {
        'instance': profile_instance,
        'url': reverse('web:view_profile'),
        'privilege_history': privilege_history
    }

    return render(request, 'web/rewards.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def social_link_view(request):
    """
    Social links
    :param request:
    :return: Social links view
    """
    instances = SocialLinks.objects.all().order_by("-id")
    instances_count = instances.count()

    context = {
        'instances': instances,
        'instances_count': instances_count,
        'page_name' : 'Social Links',
        'title' : 'Social Links',
    }

    return render(request, 'web/social_link/social_link.html', context)


@login_required
@role_required(['superadmin', 'staff'])
def create_social_link_view(request):
    """
    create operation of Social links
    :param request:
    :param pk:
    :return:
    """
    if request.method == 'POST':
        # if instance go to edit
        form = SocialLinksForm(request.POST)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Social Links created successfully.",
                'redirect': 'true',
                "redirect_url": reverse('web:social_links')
            }

        else:
            message =generate_form_errors(form , formset=False)
            response_data = {
                "status": "false",
                "title": "Failed",
                "message": message,
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:

        form = SocialLinksForm()

        context = {
            'form': form,
            'page_name' : 'Create Social Links',
            'page_title' : 'Create Social Links',
            'url' : reverse('web:create_social_link'),
        }

        return render(request, 'web/social_link/social_link_entry.html',context)


@login_required
@role_required(['superadmin', 'staff'])
def edit_social_link_view(request,pk):
    """
    edit operation of SocialLinks
    :param request:
    :param pk:
    :return:
    """
    instance = get_object_or_404(SocialLinks, pk=pk)

    message = ''
    if request.method == 'POST':
        form = SocialLinksForm(request.POST,instance=instance)

        if form.is_valid():

            #update product
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Social Links Update successfully.",
                'redirect': 'true',
                "redirect_url": reverse('web:social_links')
            }

        else:
            message = generate_form_errors(form ,formset=False)


            response_data = {
                "status": "false",
                "title": "Failed",
                "message": message
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:

        form = SocialLinksForm(instance=instance)

        context = {
            'form': form,
            'page_name' : 'Update Social Links',
            'page_title' : 'Update Social Links',
            'is_need_select2' : True,
            'url' : reverse('web:edit_social_link', kwargs={'pk': instance.pk}),
        }

        return render(request, 'web/social_link/social_link_entry.html',context)


@login_required
@role_required(['superadmin', 'staff'])
def delete_social_link_view(request, pk):
    """
    SocialLinks deletion, it only mark as is deleted field to true
    :param request:
    :param pk:
    :return:
    """
    SocialLinks.objects.filter(pk=pk).delete()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Social Links Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('web:social_links')
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def return_product(request, pk):
    return_type = request.POST.get('return_type')
    instance = get_object_or_404(OrderItem, pk=pk)
    order_instance = Orders.objects.get(pk=instance.order.pk)
    product_variant = instance.product_variant
    product_amount = instance.price * instance.qty
    customer = Customer.objects.get(user=request.user)
    address_list = CustomerAddress.objects.filter(customer=customer, is_deleted=False)

    if request.method == 'POST':
        eligibility = is_eligible_for_return(product_variant.pk, order_instance.pk)

        if eligibility:
            form = ProductReturnForm(request.POST, request.FILES)
            account_form = CustomerAccountForm(request.POST, request.FILES)
            if return_type == 'cash':
                address_pk = request.POST.get('address')
                if address_pk:
                    address_instance = CustomerAddress.objects.get(customer=customer, pk=address_pk, is_deleted=False)

                    if form.is_valid():
                        auto_id = get_auto_id(ProductReturn)
                        data = form.save(commit=False)
                        data.return_id = get_return_prefix()
                        data.auto_id = auto_id
                        data.creator=request.user
                        data.updater=request.user
                        data.order_item=instance
                        data.order=order_instance
                        data.amount= product_amount
                        data.customer_address= address_instance
                        data.return_type=return_type
                        data.customer_name=address_instance.name
                        data.customer_phone=address_instance.phone
                        data.customer_street=address_instance.street
                        data.customer_landmark=address_instance.landmark
                        data.customer_latitude=address_instance.location.latitude
                        data.customer_longitude=address_instance.location.longitude
                        data.is_handover_required= True

                        data.save()

                        response_data = {
                            "status": "true",
                            "stable": "false",
                            "title": "Successfully Created",
                            "message": "Product Return Created Successfully.",
                            "redirect": "true",
                            "redirect_url": reverse('web:view_orders')
                        }

                    else:
                        message = generate_form_errors(form, formset=False)
                        print("msg",message)

                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": ""
                        }
                else:

                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Address Not selected",
                        "message": "Select an address"
                    }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            elif return_type == 'bank':
                    if form.is_valid() and account_form.is_valid():
                        customer_account= account_form.save(commit=False)
                        customer_account.customer = customer
                        customer_account.save()

                        auto_id = get_auto_id(ProductReturn)
                        data = form.save(commit=False)
                        data.return_id = get_return_prefix()
                        data.auto_id = auto_id
                        data.creator=request.user
                        data.updater=request.user
                        data.order_item=instance
                        data.order=order_instance
                        data.amount= product_amount
                        data.customer_account= customer_account
                        data.return_type=return_type
                        data.customer_name=order_instance.billing_name
                        data.customer_phone=order_instance.billing_phone
                        data.customer_street=order_instance.billing_street
                        data.customer_landmark=order_instance.billing_landmark
                        data.customer_latitude=order_instance.billing_latitude
                        data.customer_longitude=order_instance.billing_longitude
                        data.save()

                        response_data = {
                            "status": "true",
                            "stable": "false",
                            "title": "Successfully Created",
                            "message": "Product Return Created Successfully.",
                            "redirect": "true",
                            "redirect_url": reverse('web:view_orders')
                        }

                    else:
                        message = generate_form_errors(form, formset=False)
                        print("msg",message)

                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": ""
                        }

                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')
        else:

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Not eligible for return",
                "message": ""
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')


    else:
        print("HLOooooooooo")
        form = ProductReturnForm()
        account_form = CustomerAccountForm()
        context = {
            "title": "Return Product",
            "form": form,
            "account_form": account_form,
            "address_list":address_list,
            "instance": instance,
            "stable": "true",
            "url": reverse('web:return_product' ,kwargs={'pk': instance.pk}),

        }

        return render(request, 'web/refund.html', context)



def refund_product_list(request):
    refund_products = ProductReturn.objects.filter(order__customer__user=request.user)
    context = {
        "refund_products":refund_products
    }
    return render(request, 'web/refund-list.html', context)


def refund_product(request,pk):
    instance = get_object_or_404(ProductReturn, pk=pk)

    status = []
    if instance.payment_status=='20':
        status = ['Completed','Picked','Initiated']
    elif instance.status not in ['10', '60']:
        status = ['Picked','Initiated']
    elif instance.agent_status=='30':
        status = ['Picked']


    print(status,'------------------')
    context = {
        "instance":instance,
        'status':status,
    }

    return render(request, 'web/refund-progress.html', context)


def read_notification(request, pk):
    redirect_url = reverse("web:notification-all")

    if pk == "all":

        instances = Notification.objects.filter(user=request.user)
        instances.update(is_read=True, is_visited = True, is_active=False)
    else:
        instance = get_object_or_404(Notification, pk=pk)


        instance.is_read = True
        instance.is_visited = True
        instance.is_active = False
        instance.save()

        if instance.order or instance.subject and instance.subject.code in ["order_out_for_delivery", "order_shipped", "order_delivered", "order_cancelled", "order_placed"]:
            redirect_url = reverse('web:order_confirmed') + f"?order={instance.order.pk}"

    return HttpResponseRedirect(redirect_url)

def delete_notification(request, pk):
    redirect_url = reverse("web:notification-all")

    if pk == "all":
        instances = Notification.objects.filter(user=request.user)
        instances.update(is_deleted=True, is_visited=True, is_active=False)
    else:
        instance = get_object_or_404(Notification, pk=pk)

        instance.is_deleted = True
        instance.is_visited = True
        instance.is_active = False
        instance.save()

    return HttpResponseRedirect(redirect_url)


def notification_page(request):
    notifications = Notification.objects.filter(user=request.user, is_deleted=False)
    context = {
        "all_notifications": notifications
    }
    return render(request, 'web/notification.html', context)


# ------------------------------------------------------------------------------------------
# ---------------------------------------Admin panel section--------------------------------
# ------------------------------------------------------------------------------------------
# 🔹 About Us Views
@login_required
def abountus_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:abountus_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def abountus_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = AboutUsForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "About Us Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("main:abountus_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = AboutUsForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit About Us",
            "instance": instance,
            "url": reverse("web:abountus_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/abountus/create.html", context)
    

# 🔹 Privacy Policy Views
@login_required
def privacy_policy_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:privacy_policy_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def privacy_policy_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = PrivacyPolicyForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Privacy Policy Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("web:privacy_policy_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = PrivacyPolicyForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Privacy Policy",
            "instance": instance,
            "url": reverse("web:privacy_policy_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/privacy_policy/create.html", context)
    
# 🔹 Terms and Condition Views
@login_required
def terms_and_conditions_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:terms_and_conditions_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def terms_and_conditions_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = TermsConditionForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Terms and Condition Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("web:terms_and_conditions_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = TermsConditionForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Terms and Condition",
            "instance": instance,
            "url": reverse("web:terms_and_conditions_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/terms_and_conditions/create.html", context)
    
    
# 🔹 Our Mission Views
@login_required
def our_mission_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:our_mission_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def our_mission_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = OurMissionForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Our Mission Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("web:our_mission_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = OurMissionForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Our Mission",
            "instance": instance,
            "url": reverse("web:our_mission_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/our_mission/create.html", context)
    

# 🔹 Our Vision Views
@login_required
def our_vision_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:our_vision_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def our_vision_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = OurVisionForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Our Vision Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("web:our_vision_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = OurVisionForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Our Vision",
            "instance": instance,
            "url": reverse("web:our_vision_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/our_vision/create.html", context)
    
    
# 🔹 Our Inspiration Views
@login_required
def our_inspiration_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.latest("id")
        return redirect('web:our_inspiration_edit', pk=instance.pk)
    else:
        return redirect('main:company_profile_list')
    
@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def our_inspiration_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = OurInspirationForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Our Inspiration Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("web:our_inspiration_list"),
            }
        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message),
            }

        return HttpResponse(
            json.dumps(response_data), content_type="application/javascript"
        )

    else:
        form = OurInspirationForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Our Inspiration",
            "instance": instance,
            "url": reverse("web:our_inspiration_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "web/web_management/our_inspiration/create.html", context)