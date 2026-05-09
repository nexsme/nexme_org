import math
import uuid
import json
import string
import random
import logging
import datetime
import requests
import urllib.parse
import urllib.request
from decimal import Decimal

from functools import wraps
# from urllib  import requests, parse

from django.db.models import Max
from django.contrib import messages
from django.http import HttpResponse
from django.shortcuts import redirect
from django.core.mail import send_mail
from django.contrib.auth import logout
from django.utils.html import strip_tags
from django.contrib.auth.models import User
from django.core.paginator import Paginator
from django.conf import settings as SETTINGS
from django.template.loader import render_to_string
from django.core.exceptions import ImproperlyConfigured
from django.core.mail import EmailMessage, EmailMultiAlternatives
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

import firebase_admin
from twilio.rest import Client
from cryptography.fernet import Fernet
from fcm_django.models import FCMDevice
from mailqueue.models import MailerMessage
from firebase_admin import messaging, credentials
from firebase_admin.messaging import Message, Notification as FCMNotification

from staffs.models import Staff
from main.models import Settings
from customers.models import Customer
from warehouses.models import Location
from users.models import Notification, NotificationSubject

def get_otp(size=4, chars=string.digits):
    return "".join(random.choice(chars) for _ in range(size))


def get_ip(request):
    x_forwarded_for = request.META.get("HTTP_X_FORWARDED_FOR")

    if x_forwarded_for:
        ipaddress = x_forwarded_for.split(",")[-1].strip()
    else:
        ipaddress = request.META.get("REMOTE_ADDR")

    return ipaddress


def get_auto_id(model):
    auto_id = 1
    latest_auto_id = model.objects.aggregate(Max("auto_id"))
    max_auto_id = latest_auto_id["auto_id__max"]
    if max_auto_id:
        auto_id = int(max_auto_id) + 1

    return auto_id


def get_a_id(model, warehouse):
    print(warehouse)
    a_id = 1
    latest_a_id = model.objects.filter(warehouse_id=warehouse.pk).aggregate(
        Max("a_id")
    )["a_id__max"]
    if latest_a_id:
        a_id = int(latest_a_id) + 1

    return a_id


def generate_form_errors_old(args, formset=False):
    message = ""
    if not formset:
        for field in args:
            if field.errors:
                message += field.errors + "|"
        for err in args.non_field_errors():
            message += str(err) + "|"

    elif formset:
        for form in args:
            for field in form:
                if field.errors:
                    message += field.errors + "|"
            for err in form.non_field_errors():
                message += str(err) + "|"
    return message[:-1]


# def generate_form_errors(args, formset=False):
#     message = ""
#     if not formset:
#         for field in args:
#             if field.errors:
#                 message += "\n"
#                 message += field.label + " : "
#                 message += str(field.errors)

#         for err in args.non_field_errors():
#             message += str(err)
#     elif formset:
#         for form in args:
#             for field in form:
#                 if field.errors:
#                     message += "\n"
#                     message += field.label + " : "
#                     message += str(field.errors)
#             for err in form.non_field_errors():
#                 message += str(err)

#     message = message.replace("<li>", "").replace("</li>", "")
#     message = message.replace('<ul class="errorlist">', "").replace("</ul>", "")
#     return message

def generate_form_errors(args, formset=False):
    message = ""
    if not formset:
        for field in args:
            if field.errors:
                message += f"\n{field.label} : {str(field.errors)}"
        for err in args.non_field_errors():
            message += f"\n{str(err)}"
    else:
        # 1. Check for errors across the whole formset (e.g. ManagementForm issues)
        for err in args.non_form_errors():
            message += f"\nFormset Error: {str(err)}"
            
        # 2. Check each individual form in the formset
        for i, form in enumerate(args):
            for field in form:
                if field.errors:
                    # Added 'Row' number to make it easier to find the error in the UI
                    message += f"\nRow {i+1} - {field.label} : {str(field.errors)}"
            for err in form.non_field_errors():
                message += f"\nRow {i+1} : {str(err)}"

    # Clean up HTML tags from Django's default error rendering
    message = message.replace("<li>", "").replace("</li>", "")
    message = message.replace('<ul class="errorlist">', "").replace("</ul>", "")
    return message

def outlet_staff_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        # 1. Check if user is logged in
        if not request.user.is_authenticated:
            return redirect('outlet_staff:outlet_login')  # Replace with your login URL name

        # 2. Check if the user is an active staff member
        staff_exists = Staff.objects.filter(
            user=request.user, 
            is_deleted=False
        ).exists()

        if staff_exists:
            return view_func(request, *args, **kwargs)
        
        # 3. If they are logged in but NOT staff (e.g., a Customer)
        messages.error(request, "Access Denied: Only outlet staff can access this page.")
        return redirect('main:dashboard') # Redirect to a safe page

    return _wrapped_view

def customers_login_required(view_func):
    @wraps(view_func)
    def _wrapped_view(request, *args, **kwargs):
        # 1. Check if user is logged in
        if not request.user.is_authenticated:
            return redirect('customer_special_link:customer_login')

        # 2. Check if the user is a valid Customer
        customer_exists = Customer.objects.filter(
                user=request.user, 
                is_deleted=False
            ).exists()

        if customer_exists:
            return view_func(request, *args, **kwargs)
        
        # 3. If logged in but NOT a Customer (e.g., Admin/Staff/Other)
        # We must log them out first so they can log in with a Customer account
        logout(request)
        
        messages.info(request, "Please log in with your Customer account to continue.")
        return redirect('customer_special_link:customer_login')

    return _wrapped_view

def get_current_role(request):
    is_superadmin = False
    is_customer_user = False
    is_vendor_user = False

    is_supplier_user = False
    is_delivery_agent = False
    is_warehouse_manager = False
    is_normal_staff = False
    is_billing_staff = False

    current_role = "user"
    if request.user.is_authenticated:
        groups = request.user.groups.all()

        if request.user.is_superuser:
            is_superadmin = True
        elif groups.filter(name="customer_user").exists():
            is_customer_user = True
        elif groups.filter(name="vendor_user").exists():
            is_vendor_user = True
        elif groups.filter(name="supplier_user").exists():
            is_supplier_user = True
        elif groups.filter(name="delivery_agent").exists():
            is_delivery_agent = True
        elif groups.filter(name="warehouse_manager").exists():
            is_warehouse_manager = True
        elif groups.filter(name="normal_staff").exists():
            is_normal_staff = True
        elif groups.filter(name="billing_staff").exists():
            is_billing_staff = True

        if "current_role" in request.session:
            role = request.session["current_role"]
            if role == "superadmin":
                current_role = "superadmin"
            elif role == "customer_user":
                current_role = "customer_user"
            elif role == "vendor_user":
                current_role = "vendor_user"
            elif role == "supplier_user":
                current_role = "supplier_user"
            elif role == "delivery_agent":
                current_role = "delivery_agent"
            elif role == "warehouse_manager":
                current_role = "warehouse_manager"
            elif role == "normal_staff":
                current_role = "normal_staff"
            elif role == "billing_staff":
                current_role = "billing_staff"
        else:
            if is_superadmin:
                current_role = "superadmin"
            elif is_customer_user:
                current_role = "customer_user"
            elif is_vendor_user:
                current_role = "vendor_user"
            elif is_supplier_user:
                current_role = "supplier_user"
            elif is_delivery_agent:
                current_role = "delivery_agent"
            elif is_warehouse_manager:
                current_role = "warehouse_manager"
            elif is_normal_staff:
                current_role = "normal_staff"
            elif is_billing_staff:
                current_role = "billing_staff"

        return current_role


def get_purchase_no(Model, id):
    purchase_no = 0
    if Model.objects.filter(purchase_prefix_id=id).exists():
        purchase_no = Model.objects.filter(purchase_prefix_id=id).aggregate(
            Max("purchase_no")
        )["purchase_no__max"]
    return purchase_no + 1


def get_purchase_order_no(Model):
    purchase_no = 1
    if Model.objects.all().exists():
        latest_purchase_no = Model.objects.all().latest("date_added")
        if latest_purchase_no.order_no:
            purchase_no = latest_purchase_no.order_no + 1
        else:
            purchase_no = 1
    return purchase_no


def get_settings_sale():
    instance, created = Settings.objects.get_or_create(counter=1)
    return instance


def get_order_id(model):
    order_no = 1
    latest_order_no = model.objects.all().order_by("-date_added")[:1]
    if latest_order_no:
        for auto in latest_order_no:
            order_no = auto.order_no + 1
    return order_no


# def sendSMS(message_type, numbers, variables_values=[]):
#     key = 'HAXYGvLOxmIS2DVf6cFaTW4NndPjlyitJrRqswKBQZ58Mb01g3Zk6r5Bm3PXti9jVSdcY1AxsJgz2Ev0'
#     values = '|'.join(variables_values)
#     is_ok = True

#     if message_type == 'otp':
#         message_id = 138154
#         # variables = otp

#     elif message_type == 'placed':
#         message_id = 138155
#         # variables = order_id, date

#     elif message_type == 'shipped':
#         message_id = 138156
#         # variables = order_id, date

#     elif message_type == 'on_delivery':
#         message_id = 138158
#         # variables = order_id

#     elif message_type == 'delivered':
#         message_id = 138159
#         # variables = date

#     elif message_type == 'cancelled':
#         message_id = 138160
#         # variables = order_id

#     else:
#         is_ok = False

#     if SETTINGS.SERVER == False:
#         is_ok = False

#     if is_ok:
#         url = f"https://www.fast2sms.com/dev/bulkV2?authorization={key}&route=dlt&sender_id=ONIAZA&message={message_id}&variables_values={values}&flash=0&numbers={numbers}"

#         r = requests.get(url=url)
#         data = r.content


#         return data
#     else:
#         return ''
def sendSMS(request):
    return None


def sendOTP(numbers, otp):
    message = (
        f"Dear customer, your OTP for mobile verifications is {otp}. Thanks, Arafa"
    )
    apikey = "NTQ3MzMxNGY3NjQ3NjQzODZjNGYzNzM1NmY3OTZhNzQ="
    sender = "ARAFAL"

    data = urllib.parse.urlencode(
        {"apikey": apikey, "numbers": numbers, "message": message, "sender": sender}
    )
    data = data.encode("utf-8")
    request = urllib.request.Request("https://api.textlocal.in/send/?")
    f = urllib.request.urlopen(request, data)
    fr = f.read()
    return fr


def sendSMSConfirmation(numbers, order_id):
    try:
        message = f"Dear customer, your order with ID {order_id} is confirmed. Thanks, Arafa Traders."
        apikey = "NTQ3MzMxNGY3NjQ3NjQzODZjNGYzNzM1NmY3OTZhNzQ="
        sender = "ARAFAL"

        data = urllib.parse.urlencode(
            {"apikey": apikey, "numbers": numbers, "message": message, "sender": sender}
        )
        data = data.encode("utf-8")
        request = urllib.request.Request("https://api.textlocal.in/send/?")
        f = urllib.request.urlopen(request, data)
        fr = f.read()
        return fr

    except Exception as e:
        print(e)
        return e


def send_otp_message(message_type, mobile, message):
    if message_type == "otp":
        apiKey = "Njc0ZDU1NDk3MTRiNTY2OTQ5NDEzOTY2NzQzODcyNzk="
        print(apiKey)
    elif message_type == "orderstatus":
        apiKey = "NTQ2ZTYxNzA2ODY4NTA3NjMyNjc1MjZkNzQ0NzM5NzI="
    numbers = []
    if mobile:
        print(mobile)
        count = len(mobile)
        if not count > 10 and not mobile.startswith("91") or not count < 10:
            mobile = "91" + str(mobile)
            numbers.append(mobile)
        print("numbers", numbers)
    message = message
    data = urllib.parse.urlencode(
        {"apikey": apiKey, "numbers": numbers, "message": message, "sender": "ARAFAL"}
    )
    print(data)
    data = data.encode("utf-8")
    request_url = "https://api.textlocal.in/send/?"
    requests.get(request_url, data)
    f = urllib.request.urlopen(request_url, data)
    fr = f.read()
    print("fr", fr)


def sendOTP_old(phone, otp):
    body = f"Dear customer, {otp} is your OTP for  NEXSME. Don't share it with anyone."
    phone = f"+91{phone}"
    customer = phone
    print(customer)

    account_sid = SETTINGS.TWILIO_ACCOUNT_SID
    auth_token = SETTINGS.TWILIO_AUTH_TOKEN
    phone_number = SETTINGS.TWILIO_PHONE_NUMBER
    client = Client(account_sid, auth_token)

    message = client.messages.create(
        messaging_service_sid="MGf249e1f1221f34762c0d00b245d2cd66",
        body=body,
        to=customer,
    )
    print(message)

    return True


def get_placeholder():
    image = "https://i2.wp.com/quidtree.com/wp-content/uploads/2020/01/placeholder.png?fit=1200%2C800&ssl=1"
    return image


def truncate(f, n):
    return math.floor(f * 10**n) / 10**n


# def get_current_financial_year():
# financial_year = FinancialYear.objects.filter(is_active=True, is_deleted=False).last()
# return financial_year


def get_date_updated_request(request_post, field_names):
    for field_name in field_names:
        try:
            date_str = request_post.get(field_name)

            if date_str:
                try:
                    my_date = datetime.datetime.strptime(str(date_str), "%d/%m/%Y")

                except:
                    try:
                        my_date = datetime.datetime.strptime(str(date_str), "%m/%d/%Y")
                    except:
                        my_date = None

                if my_date:
                    str_date = datetime.datetime.strftime(my_date, "%m/%d/%Y")
                    request_post.update({field_name: str_date})
        except:
            pass

    return request_post


def get_or_create_location(request, location_form, location_name, latitude, longitude):
    try:
        if Location.objects.filter(
            location=location_name, latitude=latitude, longitude=longitude
        ).exists():
            location = Location.objects.filter(
                location=location_name, latitude=latitude, longitude=longitude
            )[0]
        else:
            short_location = location_name.split(",")
            short_name = short_location[0]
            location = location_form.save(commit=False)
            location.creator = request.user
            location.updater = request.user
            location.auto_id = get_auto_id(Location)
            location.short_name = short_name
            location.save()
    except:
        location = None

    return location


# for API only
def create_or_get_location(request, location_name, latitude, longitude):
    try:
        short_name = location_name.split(",")[0]
    except:
        short_name = location_name[:17] + "..."

    try:
        if Location.objects.filter(
            location=location_name, latitude=latitude, longitude=longitude
        ).exists():
            location = Location.objects.filter(
                location=location_name, latitude=latitude, longitude=longitude
            )[0]
        else:
            location = Location.objects.create(
                auto_id=get_auto_id(Location),
                creator=request.user,
                updater=request.user,
                location=location_name,
                latitude=latitude,
                longitude=longitude,
                short_name=short_name,
            )
            return location
    except:
        location = None

    return location


def SendEmail(mail_type, email, message):
    try:
        mailto = email
        if mail_type == "placed":
            subject = "Arafa Traders Order Placed "

        elif mail_type == "shipped":
            subject = "Arafa Traders Order Shipped "

        elif mail_type == "delivered":
            subject = "Arafa Traders Order Delivered "

        elif mail_type == "cancelled":
            subject = "Arafa Traders Order cancelled "

        elif mail_type == "on_delivery":
            subject = "Arafa Traders - Order out for delivery "

        msg_html = render_to_string(
            "email/email.html",
            {
                "email_message": message,
            },
        )
        email_from = SETTINGS.EMAIL_HOST_USER
        recipient_list = [
            mailto,
        ]

        send_mail(subject, message, email_from, recipient_list, html_message=msg_html)

    except Exception as e:
        print("An exception occured while sending mail")


def paginate(instances, request):
    try:
        page = int(request.GET.get("page", 1))
        items = int(request.GET.get("items", 10))
    except Exception as e:
        page = 1
        items = 50

    paginator = Paginator(instances, items)
    try:
        instances = paginator.page(page)
    except PageNotAnInteger:
        instances = paginator.page(1)
    except EmptyPage:
        instances = paginator.page(paginator.num_pages)

    data = {
        "count": instances.paginator.count,
        "num_pages": instances.paginator.num_pages,
    }

    data["has_other_pages"] = instances.has_other_pages()
    if instances.has_other_pages():
        data["has_previous"] = instances.has_previous()
        if instances.has_previous():
            data["previous_page_number"] = instances.previous_page_number()

        data["has_next"] = instances.has_next()
        if instances.has_next():
            data["next_page_number"] = instances.next_page_number()
    return instances, data


def create_notification(request, notification_type, message, instance):
    # who = request.user
    subject = NotificationSubject.objects.get(code=notification_type)
    superusers = User.objects.filter(is_active=True, is_superuser=True)

    if notification_type == "order_placed":
        # create notification for superuser
        for superuser in superusers:
            Notification(
                user=superuser,
                subject=subject,
                order=instance,
                customer=instance.customer,
                # who = who,
                is_active=True,
                message=message,
                time=datetime.datetime.now(),
            ).save()

        for device in FCMDevice.objects.filter(user__in=superusers, active=True):
            device.send_message(
                Message(notification=FCMNotification(title=str(subject), body=message))
            )
            
def send_notification(sender, receiver, title, body, instance, group_type):

    project_name = "Arafa Chicken - Customer"

    # Load Firebase app
    try:
        app = firebase_admin.get_app(name=project_name)
    except ValueError:
        # If not loaded, initialize here
        app = firebase_admin.initialize_app(name=project_name)

    # Fetch all FCM tokens for the user
    tokens = FCMDevice.objects.filter(user=receiver).order_by('-date_created')

    if not tokens.exists():
        return False

    for token_instance in tokens:
        if token_instance.device_id :
            token = token_instance.device_id

            message = messaging.Message(
                notification=messaging.Notification(
                    title=title,
                    body=body
                ),
                token=token,
            )

            try:
                response = messaging.send(message, app=app)
            except Exception as e:
                continue
            
            group_type_instance = NotificationSubject.objects.get(code=group_type)

            notification = Notification.objects.create(
                user=sender,
                who=receiver,
                time=datetime.datetime.now(),
                message=body,
                subject=group_type_instance
            )
            
            if group_type == "chicken_order_placed" :
                notification.chicken_sales_order = instance
                
            notification.save()

    return True


def send_fast2sms(template_id, phone_numbers, variables):

    url = "https://www.fast2sms.com/dev/bulkV2"

    payload = {
        "route": "dlt",
        "sender_id": "ARAFAL",
        "message": template_id,
        "variables_values": "|".join(variables.values()),
        "numbers": ",".join(phone_numbers)
    }

    headers = {
        "authorization": "vn6DOCyoxQwPbKWFV4GLXeH3Y2Z1SgBkTpm7iIUh5r0Asj8uaMegIWO9P3J65lfMw2AEahrxLdp0VHoZ",
        "Content-Type": "application/json"
    }

    response = requests.post(url, data=json.dumps(payload), headers=headers)

    try:
        return response.json()
    except Exception:
        return {"error": True, "response": response.text}

def load_key():
    key = getattr(SETTINGS, "PASSWORD_ENCRYPTION_KEY", None)
    if key:
        return key
    else:
        raise ImproperlyConfigured("No configuration  found in your PASSWORD_ENCRYPTION_KEY setting.")


def encrypt_message(message):
    key = load_key()
    encoded_message = message.encode()
    f = Fernet(key)
    encrypted_message = f.encrypt(encoded_message)
    return(encrypted_message.decode("utf-8"))


def decrypt_message(encrypted_message):
    key = load_key()
    f = Fernet(key)
    try:
        decrypted_message = f.decrypt(encrypted_message.encode())
        return decrypted_message.decode()
    except:
        return encrypted_message

def send_email(subject, to_address, content, mail_html, bcc_address=SETTINGS.DEFAULT_BCC_EMAIL, app="mrm", reply_to_address=SETTINGS.DEFAULT_REPLY_TO_EMAIL, attachment=True):
    # print("send fun")

    if attachment:
        email = EmailMultiAlternatives(subject, content, SETTINGS.DEFAULT_FROM_EMAIL, [to_address], bcc=[bcc_address], reply_to=[reply_to_address])
        email.attach_alternative(mail_html, "text/html")
        email.send()
    else:
        new_message = MailerMessage()
        new_message.subject = subject
        new_message.to_address = to_address
        if bcc_address:
            new_message.bcc_address = bcc_address
        new_message.from_address = SETTINGS.DEFAULT_FROM_EMAIL
        new_message.content = content
        new_message.app = app
        new_message.reply_to = reply_to_address
        new_message.save()


# Setup logging to track API failures
logger = logging.getLogger(__name__)

def send_whatsapp_message(phone_number, template_name, variables_list):
    url = "https://www.fast2sms.com/dev/bulkV2"
    
    clean_number = str(phone_number)[-10:]
    vars_string = "|".join(map(str, variables_list))
    
    payload = {
        # If 'whatsapp' gives a 'Route Blocked' error, 
        # ensure your Fast2SMS account has WhatsApp API enabled.
        "route": "whatsapp", 
        "message": template_name,
        "variables_values": vars_string,
        "numbers": clean_number,
    }
    
    headers = {
        "authorization": SETTINGS.FAST2SMS_API_KEY,
        "Content-Type": "application/json"
    }

    try:
        response = requests.post(url, json=payload, headers=headers, timeout=10)
        result = response.json()
        
        if result.get("return"):
            print("Message sent successfully")
        else:
            # This is where your 'Route Blocked' error is being caught
            print(f"Fast2SMS Failure: {result.get('message')}")
            
        return result
    except Exception as e:
        return {"return": False, "message": str(e)}
