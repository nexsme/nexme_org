import datetime
import decimal
from django.db.models import Count, Q
from products.models import Category
from web.forms import SignUpForm, PincodeForm, TicketForm, CustomerPincodeForm
from users.models import *
from web.functions import get_cart_total
from warehouses.models import *
from offers.models import VoucherCode
from decimal import Decimal
from customers.models import Customer, Ticket
from api.v1.users.functions import get_privileged_points, get_delivery_charge, get_express_charge, get_grand_total
from web.models import SocialLinks


def web_context(request):
    full_categories = Category.objects.filter(is_deleted=False).annotate(product_count=Count('product__productvariant')).order_by('-product_count')
    categories = full_categories[:6]

    locations = Zone.objects.all()
    tickets = None
    zone_name = None
    tickets_resolved_instances = None
    privilege_points = 0
    privilege_points_amt = 0
    zone_name = "Select a pincode"

    language_code = request.LANGUAGE_CODE

    zone_session = None
    coupon_session_amt = request.session.get('coupon_amt', 0)
    coupon_pk = request.session.get('coupon_id', 0)
    delivery_type = request.GET.get('delivery_type')

    ticket_form = TicketForm()

    # if locations not avail
    if 'zone' in request.session:
        zone_session = request.session.get('zone', '')
        try:
            zone = locations.get(pk=zone_session)
            zone_name = zone.name
            pincode_form = CustomerPincodeForm(initial={'pincode': zone}, auto_id='id_my_%s')
        except Exception as e:
            pincode_form = CustomerPincodeForm(auto_id='id_my_%s')
            print(e)
    else:
        pincode_form = CustomerPincodeForm(auto_id='id_my_%s')
        if locations.exists():
            zone_session = locations.first()
        else:
            zone_session = 0

    customer_instance = None
    auth_status = False
    wishlist = None
    cart = None
    cart_total = 0
    cart_item_total = 0
    delivery_charge = 0
    cart_items = None
    wishlist_items = None
    privilege_history = None
    cart_grand_total = 0
    is_wallet_applied = False
    wallet_applied_amt = 0
    input_value_point = 0
    notification_count = None
    cart_count = None

    today = datetime.datetime.now()

    privilege_instances = PrivilegePoint.objects.filter(is_deleted=False)
    customer_notifications = Notification.objects.none()

    voucher_codes = VoucherCode.objects.none()

    if request.user.is_authenticated and not request.user.is_superuser:
        customer_notifications = Notification.objects.filter(is_deleted=False, is_active=True, is_read=False, user=request.user)
        notification_count = customer_notifications.count()

        customer_notifications = customer_notifications

        wishlist = Wishlistitem.objects.filter(is_deleted=False, customer__user=request.user)
        # wishlist_items = [item.product_variant.pk for item in wishlist]
        wishlist_items = wishlist.values_list('product_variant_id', flat=True)
        privilege_history = PrivilegePointHistory.objects.filter(customer__user=request.user)

        all_tickets = Ticket.objects.filter(is_deleted=False, customer__user=request.user)
        tickets = all_tickets.filter(status__in=["pending","in_progress"])
        tickets_resolved_instances = all_tickets.filter(status__in=["solved", 'rejected'])

        if Customer.objects.filter(user=request.user).exists():
            customer_instance = request.user.customer
            privilege_points = customer_instance.current_privilege_points
            auth_status = True

        if privilege_instances.exists():
            value_points = privilege_instances.first().value_of_point
            privilege_points_amt = value_points * privilege_points

        cart = CartItem.objects.filter(customer__user=request.user, is_deleted=False)

        product_ids = cart.values_list('product_variant__product_id', flat=True)
        variant_ids = cart.values_list('product_variant_id', flat=True)
        cart_items = cart.values_list('product_variant_id', flat=True)

        all_voucher_instances = VoucherCode.objects.filter(is_deleted=False, start_time__lte=today, end_time__gte=today)
        voucher_codes = all_voucher_instances.filter(
            Q(voucher_type=10) | # applicable to all
            Q(voucher_type=20, customer__user=request.user) | # for specific customer
            Q(voucher_type=30, product_id__in=product_ids) | # for specific product
            Q(voucher_type=40, product_variant_id__in=variant_ids), # for specific variant
            is_expired = False
        ).exclude(Q(is_limited_once=True, used_users=request.user))

        if cart_items.exists():
            cart_count = cart.count()
            cart_item_total = get_cart_total(request)
            if delivery_type == "express":
                delivery_charge = get_express_charge(request)
            else:
                delivery_charge = get_delivery_charge(request,cart_item_total)

            cart_total = get_grand_total(cart_item_total,delivery_charge, request)

            if coupon_session_amt:
                cart_grand_total = cart_total - float(coupon_session_amt)
            else:
                cart_grand_total = cart_total

            input_value_point = privilege_points
            if 'wallet' in request.session:
                amt = request.session.get('wallet', '') or 0
                amt = Decimal(amt)
                wallet_applied_amt  = amt * value_points

                cart_grand_total = Decimal(cart_grand_total) - Decimal(wallet_applied_amt)
                input_value_point = amt

    social_link = SocialLinks.objects.filter().first()

    og_description = "Discover the ultimate online shopping destination in Kerala. Explore a wide range of products, from fashion and electronics to home essentials and more. Shop with confidence and convenience, with fast delivery and secure payment options. Experience Kerala's premier e-commerce platform for a seamless shopping experience."

    return {
        "og_description": og_description,
        "customer_notifications": customer_notifications,
        "categories": categories,
        "full_categories": full_categories,
        "auth_status": auth_status,
        "wishlist": wishlist,
        "wishlist_items": wishlist_items,
        "cart": cart,
        "pincode_form": pincode_form,
        "is_cart": cart_items,
        "cart_amt": cart_item_total,
        "delivery_charge": delivery_charge,
        "cart_grand_total":cart_grand_total,
        "app_title": "Nexsme",
        "selected_pincode":zone_name,
        "zone": locations,
        "tickets":tickets,
        "tickets_solved": tickets_resolved_instances,
        "zone_session": zone_session,
        "voucher_codes": voucher_codes,
        "coupon_session_amt":coupon_session_amt,
        "privilege_points":privilege_points,
        "privilege_points_amt":privilege_points_amt,
        "coupon_pk":coupon_pk,
        "is_wallet_applied":is_wallet_applied,
        "wallet_applied_amt":wallet_applied_amt,
        "language_code":language_code,
        "input_value_point":input_value_point,
        "customer_instance":customer_instance,
        "social_link":social_link,
        'privilege_history': privilege_history,
        'ticket_form' : ticket_form,
        'notification_count' : notification_count,
        'cart_count' : cart_count,
        "weekday_number": today.weekday() + 1



    }
