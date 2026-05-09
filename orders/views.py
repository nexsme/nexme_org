# Local libraries
from orders.forms import *
from orders.models import *
from api.v1.delivery_agent.functions import send_notification
from main.decorators import role_required
from main.functions import generate_form_errors, get_auto_id, get_a_id, get_otp, sendSMS, SendEmail, send_otp_message
from delivery_agent.models import DeliveryAgents
from general.models import InvoiceDesign, DeliveryCharge
from customers.models import CustomerAccount, CustomerAddress
from finance.models import AccountHead, InvoicePrefix
from web.functions import get_order_prefix
from web.models import ProductReturn
from staffs.models import Staff
from warehouses.forms import LocationForm
from sales.forms import CustomerCreateFromForm, SaleVoucherForm
from sales.functions import update_batch_stock
from users.forms import AddressForm
from users.functions import get_warehouse
from users.models import NotificationSubject, Notification
# Django libriries
from django.contrib.auth.decorators import login_required
from django.db.models import Q, Max
from django.urls import reverse
from django.views.decorators.http import require_GET
from django.shortcuts import render, get_object_or_404
from django.http.response import HttpResponse, JsonResponse, HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib.auth import login, authenticate
from django.forms.models import inlineformset_factory
from django.forms.formsets import formset_factory
# Standard libraries
import json
import datetime
# class PinCodeAutoComplete(autocomplete.Select2QuerySetView):
#     def get_queryset(self):
#         pincodes =

class TimeSlotAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        time_slots = TimeSlot.objects.all()
        return time_slots

@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_time_slot(request):
    TimeslotTimeFormset = formset_factory(TimeslotTimeForm, extra=1)

    if request.method == 'POST':
        form = TimeslotDayForm(request.POST)
        time_slot_formset = TimeslotTimeFormset(request.POST, prefix='time_slot_formset')

        if form.is_valid() and time_slot_formset.is_valid():
            day = form.cleaned_data["day"]

            for form_item in time_slot_formset:
                start_time = form_item.cleaned_data["start_time"]
                end_time = form_item.cleaned_data["end_time"]

                auto_id = get_auto_id(TimeSlot)

                # create time-slot
                TimeSlot.objects.create(
                    creator = request.user,
                    updater = request.user,
                    auto_id = auto_id,

                    day = day,
                    end_time = end_time,
                    start_time = start_time,
                )

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Time Slot Created Successfully.",
                "redirect": "true",
                "redirect_url": reverse('orders:time_slot', kwargs={'pk': day})
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
        form = TimeslotDayForm()
        time_slot_formset = TimeslotTimeFormset(prefix='time_slot_formset')

        context = {
            "form": form,
            "title": "Create TimeSlot ",
            "time_slot_formset": time_slot_formset,
            "url": reverse('orders:create_time_slot'),
        }

        return render(request, 'orders/timeslot/timeslot_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def time_slots(request):
    instances = TimeSlot.objects.filter(is_deleted=False)
    days = []


    for item in DAY_CHOICES:
        days.append({
            "pk": item[0],
            "name": item[1],
            "count": instances.filter(day=item[0]).count()
        })

    context = {
        "title": "Time Slots",
        "days": days,
    }

    return render(request, 'orders/timeslot/timeslots.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_time_slot(request, pk):
    instance = get_object_or_404(TimeSlot.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = TimeslotForm(request.POST, instance=instance)

        if form.is_valid():
            # update offer
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Time Slot Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('orders:time_slot', kwargs={'pk': data.day})
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
        form = TimeslotForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Time Slot : " + str(instance.day),
            "instance": instance,
            "url": reverse('orders:edit_time_slot', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'orders/timeslot/edit_timeslot.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_time_slot(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(TimeSlot.objects.filter(pk=pk, is_deleted=False))

    TimeSlot.objects.filter(pk=pk).update(is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "TimeSlot Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('orders:time_slots')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def status_time_slot(request, pk):
    instance = get_object_or_404(TimeSlot.objects.filter(pk=pk, is_deleted=False))

    update_type = "Disabled" if instance.is_active else "Enabled"

    instance.is_active = not instance.is_active
    instance.save()

    response_data = {
        "status": "true",
        "title": f"Successfully {update_type}",
        "message": f"Time Slot Successfully {update_type}.",
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def time_slot(request, pk):
    instances = TimeSlot.objects.filter(is_deleted=False)

    days = []
    today_date = datetime.datetime.today()
    today = today_date.strftime('%A')
    for item in DAY_CHOICES:
        days.append({
            "pk": item[0],
            "name": item[1],
            "count": instances.filter(day=item[0]).count()
        })


    instances = instances.filter(day=pk)

    context = {
        "title": "Time Slot : ",
        "pk": pk,
        "days": days,
        "instances": instances,
        "today": today,
    }

    return render(request, 'orders/timeslot/timeslots.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def orders(request, order_type):
    order_status_form = OrderStatusForm()
    query = request.GET.get('query')
    to_date = request.GET.get('to_date')
    from_date = request.GET.get('from_date')
    customer_id = request.GET.get("customer")
    search = request.GET.get("q")
    print("from date", from_date)
    print("to_date",to_date)
    filter_data = {}

    instances = Orders.objects.filter(is_deleted=False)
    if order_type == 'pending':
        instances = instances.filter(order_status="10")
    elif order_type == 'shipped':
        instances = instances.filter(order_status="20")
    elif order_type == 'delivered':
        instances = instances.filter(order_status="30")
    elif order_type == 'cancelled':
        instances = instances.filter(order_status="40")
    else:
        order_type = 'all'

    if customer_id:
        instances = instances.filter(customer_id=customer_id)

    if query:
        if 'unassigned' in query:
            instances = instances.filter(delivery_agent__isnull=True, order_status="10")

        elif 'pending' in query:
            instances = instances.filter(order_status="10")

        elif 'assigned' in query:
            instances = instances.filter(delivery_agent__isnull=False, order_status__in=["10", "20"])

        elif 'shipped' in query:
            instances = instances.filter(is_deleted=False, order_status="20")

        elif 'completed' in query:
            instances = instances.filter(is_deleted=False, order_status="30")

        elif 'cancelled' in query:
            instances = instances.filter(is_deleted=False, order_status="40")
    else:
        query = 'all'

    if from_date and to_date:
        f_date = datetime.datetime.strptime(from_date, '%Y-%m-%d').date()
        t_date = datetime.datetime.strptime(to_date, '%Y-%m-%d').date()
        instances = instances.filter(date_added__date__range=[f_date, t_date])

        filter_data['from_date'] = from_date
        filter_data['to_date'] = to_date

    if search:
        instances = instances.filter(
            Q(order_id__icontains=search)|
            Q(billing_name__icontains=search)|
            Q(billing_phone__icontains=search)|
            Q(customer__name__icontains=search)|
            Q(customer__phone__icontains=search)|
            Q(delivery_agent__name__icontains=search)
        )
        filter_data['q'] = search

    context = {
        "query": query,
        "is_all_order":True,
        "instances": instances,
        "order_type": order_type,
        "filter_data": filter_data,
        "order_status_form":order_status_form,
        "title": f"{order_type.title()} Orders",
    }
    return render(request, 'orders/orders/orders.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def order(request, pk):
    instance = get_object_or_404(Orders.objects.filter(pk=pk))
    print("--------------->", instance)
    items = OrderItem.objects.filter(order_id=pk)
    delivery_agent_instances = DeliveryAgents.objects.filter(is_deleted=False)
    title = "Order : " + str(instance.order_id)
    title =title.upper()
    print(title)
    if instance.warehouse:
        delivery_agent_instances = delivery_agent_instances.filter(warehouse_id=instance.warehouse_id)

    context = {
        "title": title,
        "has_vendor": items.filter(product_variant__product__vendor__isnull=False).exists(),
        "instance": instance,
        "delivery_agents": delivery_agent_instances,
    }
    return render(request, 'orders/orders/order.html', context)


@role_required(['superadmin', 'staff', 'warehouse_manager'])
def assign_agent(request):
    agent_pk = request.GET.get('agent')
    order_pk = request.GET.get('order')

    try:
        agent = DeliveryAgents.objects.get(pk=agent_pk)
    except:
        agent = None
        print(f"\n\n Error: Could not find agent with pk: {agent_pk}\n\n")

    order_instances = get_object_or_404(Orders.objects.filter(pk=order_pk))

    order_instances.assigned_time = datetime.datetime.now()
    order_instances.delivery_agent = agent
    # order_instances.delivery_agent_is_accept=False
    order_instances.save()

    notification_subject,created = NotificationSubject.objects.get_or_create(code='you_have_a_new_order',defaults={'name':'You have a New Order'})
    message = "An order assigned to you, check it out ."
    if not agent:
        response_data = {
            "status": "false",
            "title": "Delivery Agent",
            "message": "Select Delivery Agent",
            "redirect": "true",
        }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')
    delivery_user = agent.user

    subject = notification_subject.name
    order = Orders.objects.get(pk=order_pk)
    Notification.objects.create(
        is_active = True,
        subject = notification_subject,
        user = request.user,
        who = delivery_user,
        message = message,
        time = datetime.datetime.now(),
        customer = order_instances.customer,
        order = order
    )
    send_notification(delivery_user, subject, message, data=None)

    response_data = {
        "status": True,
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def bookings(request):
    instances = Booking.objects.filter(is_deleted=False, status="pending")

    context = {
        "title": "All Bookings",
        "instances": instances,
        "pending_order": True,
    }
    return render(request, 'orders/bookings/bookings.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def booking(request, pk):
    instance = get_object_or_404(Booking.objects.filter(pk=pk))

    context = {
        "title": "Booking : " + str(instance.customer),
        "instance": instance,
    }
    return render(request, 'orders/bookings/booking.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def accept_booking(request, pk, address_pk):
    booking_instance = Booking.objects.get(pk=pk)
    address_instance = CustomerAddress.objects.get(pk=address_pk)

    variant = booking_instance.product_variant
    zone = address_instance.zone
    customer_instance = address_instance.customer

    batch = None
    if variant.product.vendor:
        pass
    elif Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant=variant).exists():
        batch = Batch.objects.filter(is_deleted=False, warehouse__deliverable_location__in=[zone], product_variant=variant).first()

    else:
        response_data = {
            "status": "false",
            "title": "Batch Not Found",
            "message": "Batch Not Found on Customers preferred location",
            "redirect": "true",
            "redirect_url": reverse('orders:bookings')
        }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

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
        customer=customer_instance,
        billing_name=address_instance.name,
        billing_phone=address_instance.phone,
        billing_address=address_instance.house_name,
        billing_street=address_instance.street,
        billing_landmark=address_instance.landmark,
        billing_city=address_instance.city,
        billing_state=address_instance.state,
        order_status=10,
        total_amt=variant.mrp,
        payment_method="cod",
        payment_status=10,
        order_no=order_no,
        order_id=order_id,
        prefix=prefix,
        warehouse=batch.warehouse,
        zone = address_instance.zone,

    )

    OrderItem.objects.create(
        product_variant=variant,
        qty="1",
        price=variant.mrp,
        order=order,
        batch=batch,
    )

    booking_instance.status = "confirmed"
    booking_instance.save()

    response_data = {
        "status": "true",
        "title": "Accept Booking",
        "message": "Successfully Accepted Booking.",
        "redirect": "true",
        "redirect_url": reverse('orders:bookings')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def accepted_bookings(request):
    instances = Booking.objects.filter(is_deleted=False, status="confirmed")

    context = {
        "title": "All Bookings",
        "instances": instances,
        "accepted_order": True
    }

    return render(request, 'orders/bookings/bookings.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def returns(request):
    warehouse = request.GET.get('warehouse')
    return_status = request.GET.get('return_status')
    user_role = request.GET.get('user_role')

    is_admin = None
    if request.user.is_superuser:
        is_admin = True

    if user_role:
        if 'warehouse_manager' in user_role:
            staff_instance = Staff.objects.get(user=request.user)
            is_admin = False

    instances = ProductReturn.objects.filter(is_deleted=False)

    warehouse_instances = Warehouse.objects.filter(is_deleted=False)

    if warehouse:
        instances = instances.filter(is_deleted=False, order_item__batch__warehouse__pk=warehouse)

    if return_status:
        instances = instances.filter(is_deleted=False, status=return_status)

    context = {
        "title": "Pending Return Requests",
        "instances": instances,
        "warehouse_instances":warehouse_instances,
        "warehouse":warehouse,
        "return_status":return_status,
        "is_admin":is_admin,
    }
    return render(request, 'orders/returns/returns.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def product_return(request, pk):
    account_info = None
    warehouse = request.GET.get('warehouse')
    instance = get_object_or_404(ProductReturn.objects.filter(pk=pk))
    if instance.return_type =="bank":
        account_info = CustomerAccount.objects.get(pk=instance.customer_account.pk)

    delivery_agent_instances = DeliveryAgents.objects.filter(is_deleted=False)
    if warehouse:
        delivery_agent_instances = delivery_agent_instances.filter(warehouse=warehouse)

    context = {
        "title": "Returned Product : " + str(instance.order.billing_name),
        "instance": instance,
        "delivery_agents": delivery_agent_instances,
        'account_info':account_info
    }
    return render(request, 'orders/returns/return.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def accept_or_reject_return(request):
    response_data = {}

    pk = request.GET.get('pk')
    status = request.GET.get('status')
    rejected_reason = request.GET.get('rejected_reason')

    product_return_instances = ProductReturn.objects.get(pk=pk)

    if 'reject' in status:
        product_return_instances.status = "rejected"
        product_return_instances.rejected_reason = rejected_reason
        product_return_instances.save()

        response_data = {
            "status": True,
            "return_status": "rejected"
        }

    elif 'accepted' in status:
        product_return_instances.status = "accepted"
        product_return_instances.save()

        response_data = {
            "status": True,
            "return_status": "accepted"
        }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@role_required(['superadmin', 'staff', 'warehouse_manager'])
def assign_agent_for_return(request):
    agent_pk = request.GET.get('agent')
    return_pk = request.GET.get('return_pk')

    agent = DeliveryAgents.objects.get(pk=agent_pk)

    return_instances = get_object_or_404(ProductReturn.objects.filter(pk=return_pk))
    return_instances.delivery_boy = agent
    return_instances.save()

    response_data = {
        "status": True,
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def product_recieved(request):
    return_pk = request.GET.get('return_pk')

    return_instances = get_object_or_404(ProductReturn.objects.filter(pk=return_pk))
    return_instances.status = "nexsme_received"
    return_instances.save()

    response_data = {
        "status": True,
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')



@login_required
@role_required(['superadmin', 'staff', 'staff_user'])
def print_order_invoice(request, view_type, pk):
    instance = get_object_or_404(Orders.objects.filter(pk=pk))
    order_items = OrderItem.objects.filter(order=instance)

    invoice_design = None
    if InvoiceDesign.objects.filter(is_deleted=False,is_active=True):
        invoice_design = InvoiceDesign.objects.filter(is_deleted=False,is_active=True).first()

    if view_type == "staff":
        order_items = order_items.filter(product_variant__product__vendor__isnull=True)

    order_items_arr = []
    for order_item in order_items:
        total_price = order_item.price * order_item.qty
        batch = order_item.batch
        dic = {
            "product_name": str(order_item.product_variant),
            "qty":order_item.qty,
            "price":order_item.price,
            "total_price":total_price,
            "batch":batch,
        }
        order_items_arr.append(dic)

    context = {
        "title": "Orders ",
        "instance": instance,
        "view_type": view_type,
        "order_items": order_items_arr,

        "invoice_design": invoice_design,
    }

    return render(request, 'invoice/print_staff_view_order.html', context)


@login_required
@role_required(['superadmin', 'staff', 'staff_user'])
def print_sale_order_a4(request, pk):
    instance = get_object_or_404(Orders.objects.filter(pk=pk))

    invoice_design = None
    if InvoiceDesign.objects.filter(is_deleted=False,is_active=True):
        invoice_design = InvoiceDesign.objects.filter(is_deleted=False,is_active=True).first()

    order_items = OrderItem.objects.filter(order=instance)
    total_mrp_amount = 0
    total_tax_amount = 0
    total_discount = 0
    total_amount = 0

    order_items_arr = []
    customer_state = instance.customer.state
    for order_item in order_items:
        if customer_state == "Kerala":
            igst_rate = 0
            cgst_rate = order_item.product_variant.product.hsn.cgst_rate
            sgst_rate = order_item.product_variant.product.hsn.sgst_rate

        else:
            igst_rate = order_item.product_variant.product.hsn.igst_rate
            cgst_rate = 0
            sgst_rate = 0
        tax_percentage = Decimal(igst_rate+cgst_rate+sgst_rate)
        print("-----------",tax_percentage)


        total_price = order_item.price * order_item.qty
        total_mrp = order_item.batch.mrp * order_item.qty
        discount = total_mrp - total_price

        taxable_amount = round(total_price / (1 + (tax_percentage/100)), 3)
        tax_amount = round(total_price - taxable_amount, 3)
        igst_amount = tax_amount * (igst_rate / Decimal('100'))
        cgst_amount = tax_amount * (cgst_rate / Decimal('100'))
        sgst_amount = tax_amount * (sgst_rate / Decimal('100'))

        print("===============================", igst_amount)
        print("=============================/==", cgst_amount)
        print("===============================", sgst_amount)

        order_items_arr.append({
            "product_variant": order_item.product_variant,
            "qty": order_item.qty,
            "mrp": order_item.batch.mrp,
            "price": order_item.price,
            # "tax_percentage": tax_percentage,
            "discount": discount,
            # "tax_amount": tax_amount,
            "total_mrp": total_mrp,
            "total_price": total_price,
            "igst_rate": igst_rate,
            "cgst_rate": cgst_rate,
            "sgst_rate": sgst_rate,
            "igst_amount": igst_amount,
            "cgst_amount": cgst_amount,
            "sgst_amount": sgst_amount,

        })

        total_mrp_amount += total_mrp
        total_tax_amount = igst_amount+cgst_amount+sgst_amount
        total_discount += discount
        total_amount += total_price

    rows_count = 0 if order_items.count() > 5 else 5 - order_items.count()
    print("======================", instance.delivery_charge)
    context = {
        "title": "Invoice",
        "instance": instance,
        "order_items": order_items_arr,
        "invoice_design": invoice_design,

        "total_discount": total_discount,
        "total_mrp_amount": total_mrp_amount,
        "total_tax_amount": total_tax_amount,
        "total_amount": total_amount,
        "customer_state": customer_state,

        "rows_count": range(rows_count),
        "is_iphone": "iPhone" in request.META["HTTP_USER_AGENT"],
    }

    return render(request, 'invoice/print_order.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def change_order_status(request, pk):
    if request.method == 'POST':
        form = OrderStatusForm(request.POST)

        if form.is_valid():
            status = form.cleaned_data['order_status']
            Orders.objects.filter(pk=pk).update(order_status=status,date_updated=datetime.datetime.now())
            order = get_object_or_404(Orders, pk=pk)

            message = None
            print(order.order_id, str(order.delivery_date))
            notification_subject = None
            # if status == "20":
            #     notification_subject,created = NotificationSubject.objects.get_or_create(code='order_shipped',defaults={'name':'Order Shipped'})
            #     message = f" Your order {order.order_id} has been shipped and expected delivered by {str(order.delivery_date)}."
            #     email = SendEmail('shipped',order.customer.email, message )
            #     print('\n\n-------------', message, '-------------\n\n')
            #     message_type = "orderstatus"
            #     phone = order.customer.phone

                # msg = sendSMS('shipped', order.customer.phone, [order.order_id, str(order.delivery_date)])

            # elif status == "30":
            #     message = f"Dear NEXSME customer, your order has been delivered on {str(order.delivery_date)}."
            #     print('\n\n-------------', message, '-------------\n\n')
            #     notification_subject,created = NotificationSubject.objects.get_or_create(code='order_delivered',defaults={'name':'Order Delivered'})
            #     email = SendEmail('delivered',order.customer.email, message )
            #     # msg = sendSMS('delivered', order.customer.phone, [str(order.delivery_date)])

            # elif status == "40":
            #     message = f"Dear NEXSME customer, your order {order.order_id} has been cancelled."
            #     email = SendEmail('cancelled',order.customer.email, message )
            #     notification_subject,created = NotificationSubject.objects.get_or_create(code='order_cancelled',defaults={'name':'Order Cancelled'})
                # msg = sendSMS('cancelled', order.customer.phone, [order.order_id])

            if notification_subject:
                Notification.objects.create(
                    is_active = True,
                    subject = notification_subject,
                    user = order.customer.user,
                    message = message,
                    order = order,
                    time = datetime.datetime.now()
                )

            response_data = {
                "status": "true",
                "title": "Successfully Updates",
                "message": "Order Status Successfully Updates.",
                "redirect": "true",
                "redirect_url": reverse('orders:order', kwargs={'pk':pk})
            }
            return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_delivery_charge(request):
    DeliveryChargeFormset = formset_factory(DeliveryChargeForm, extra=1)
    warehouse = None
    vendor = None

    if request.method == 'POST':
        form = DeliveryTypeForm(request.POST)
        if form.is_valid():
            vendor = form.cleaned_data['vendor']
            warehouse = form.cleaned_data['warehouse']

        if vendor or  warehouse :

            delivery_charge_formset = DeliveryChargeFormset(request.POST, prefix='delivery_charge_formset')

            if delivery_charge_formset.is_valid():

                for form_item in delivery_charge_formset:
                    to_zone = form_item.cleaned_data["to_zone"]
                    normal_charge = form_item.cleaned_data["normal_charge"]
                    express_charge = form_item.cleaned_data["express_charge"]

                    if not  DeliveryCharge.objects.filter(warehouse=warehouse, to_zone=to_zone, vendor=vendor).exists():

                        DeliveryCharge.objects.create(
                            warehouse = warehouse,
                            vendor = vendor,
                            to_zone = to_zone,
                            normal_charge = normal_charge,
                            express_charge = express_charge,
                        )

                        response_data = {
                            "status": "true",
                            "title": "Successfully Created",
                            "message": "Delivery Charge Created Successfully.",
                            "redirect": "true",
                            "redirect_url": reverse('orders:delivery_charges')
                        }
                    else:
                        message = f"Delivery charge with zone already exists {to_zone}"

                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Duplication Found",
                            "message": str(message)
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
                message = "Choose Warehouse or Vendor"

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": str(message)
                }
        return HttpResponse(json.dumps(response_data), content_type='application/javascript')
    else:
        form = DeliveryTypeForm()
        delivery_charge_formset = DeliveryChargeFormset(prefix='delivery_charge_formset')

        context = {
            "form": form,
            "title": "Create Delivery Charge ",
            "delivery_charge_formset": delivery_charge_formset,
            "url": reverse('orders:create_delivery_charge'),
        }

        return render(request, 'orders/delivery_charges/delivery_charge_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delivery_charges(request):
    instances = DeliveryCharge.objects.filter(is_deleted=False)

    filter_data = {}
    query = request.GET.get("q")

    if query:

        instances = instances.filter(
            Q(to_zone__name__icontains=query) |
            Q(vendor__name__icontains=query) |
            Q(warehouse__name__icontains=query)  )

        filter_data['q'] = query

    context = {
        "title": "Delivery Charges",
        "instances": instances,
        "filter_data" : filter_data
    }

    return render(request, 'orders/delivery_charges/delivery_charges.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_delivery_charge(request, pk):
    instance = get_object_or_404(DeliveryCharge.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = EditDeliveryChargeForm(request.POST, instance=instance)

        if form.is_valid():
            # update offer
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Delivery Charge Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('orders:delivery_charges', )
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
        form = EditDeliveryChargeForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Delivery Charge : " ,
            "instance": instance,
            "url": reverse('orders:edit_delivery_charge', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'orders/delivery_charges/edit_delivery_charge.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_delivery_charge(request, pk):

    instance = DeliveryCharge.objects.filter(pk=pk)
    instance.delete()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Delivery Charge Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('orders:delivery_charges')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delivery_charge(request, pk):
    instance = DeliveryCharge.objects.filter(is_deleted=False,pk=pk)

    context = {
        "title": "Delivery Charge",
        "pk": pk,
        "instance": instance,
    }

    return render(request, 'orders/delivery_charges/delivery_charge.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_minimum_charge(request):
    if request.method == 'POST':
        form = MinimumChargeForm(request.POST, request.FILES)

        if form.is_valid():
            vendor = form.cleaned_data['vendor']
            warehouse = form.cleaned_data['warehouse']

            if vendor or warehouse :
                data = form.save(commit=False)
                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Amount setting created successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('orders:minimum_charges')
                }
            else:
                message = "Choose Warehouse or Vendor"

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": str(message)
                }
            return HttpResponse(json.dumps(response_data), content_type='application/javascript')

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return JsonResponse(response_data)

    else:
        form = MinimumChargeForm()
        context = {
            "title": "Create Amount for delivery charge reduction",
            "form": form,
            "url": reverse('orders:create_minimum_charge'),
        }

        return render(request, 'orders/minimum_charges/minimum_charge_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def minimum_charges(request):
    instances = ChargeSetting.objects.all()
    instances = instances.order_by('warehouse__auto_id', 'vendor__auto_id')

    filter_data = {}
    query = request.GET.get("q")

    if query:

        instances = instances.filter(
            Q(vendor__name__icontains=query) |
            Q(warehouse__name__icontains=query)  )

        filter_data['q'] = query

    context = {
        "title": "Amount for delivery charge reduction",
        "instances": instances,
        "filter_data" : filter_data
    }

    return render(request, 'orders/minimum_charges/minimum_charges.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_minimum_charge(request, pk):
    instance = get_object_or_404(ChargeSetting.objects.filter(pk=pk))

    if request.method == 'POST':
        response_data = {}
        form = MinimumChargeForm(request.POST, instance=instance)

        if form.is_valid():
            # update offer
            data = form.save(commit=False)
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Amount setting successfully updated.",
                "redirect": "true",
                "redirect_url": reverse('orders:minimum_charges', )
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
        form = MinimumChargeForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Delivery Charge : " ,
            "instance": instance,
            "url": reverse('orders:edit_minimum_charge', kwargs={'pk': instance.pk}),
            "redirect": True,
        }

        return render(request, 'orders/minimum_charges/edit_minimum_charge.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_minimum_charge(request, pk):
    instance = ChargeSetting.objects.filter(pk=pk)
    instance.delete()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Amount setting Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('orders:minimum_charges')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_order(request):
    OrderItemFormset = formset_factory(OrderItemForm, extra=3)

    if request.method == "POST":
        form = OrdersForm(request.POST)
        order_item_formset = OrderItemFormset(request.POST, prefix='order_item_formset')

        if form.is_valid() and order_item_formset.is_valid():
            if len(order_item_formset) <=0 :
                response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": "Please add order items before submitting"
                        }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            customer = form.cleaned_data['customer']
            warehouse = form.cleaned_data['warehouse']

            batch_items = []  # to save all items as seperate sale items
            stock_items = {}  # to check stock availability
            error_message = ''
            stock_ok = batch_ok = True

            all_batches = Batch.objects.filter(warehouse=warehouse, is_deleted=False)

            for item in order_item_formset:
                if item.cleaned_data != {}:
                    batch = item.cleaned_data['batch']
                    product_variant = item.cleaned_data['product_variant']

                    if not batch:
                        if all_batches.filter(product_variant=product_variant, stock__gt=0).exists():
                            error_message = "Please choose a batch before submission."
                        else:
                            error_message = f"{product_variant} is out of stock."

                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": error_message
                        }
                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            for item in order_item_formset:
                if item.cleaned_data != {}:
                    product_variant = item.cleaned_data['product_variant']
                    batch = item.cleaned_data['batch']
                    price = item.cleaned_data['price']
                    qty = item.cleaned_data['qty']

                    obj = {
                        "qty": qty,
                        "price": price,
                        'batch': batch,
                    }
                    batch_items.append(obj)

                    obj2 = {
                        "qty": qty,
                        "price": price,
                        'batch': batch,
                    }

                    # to check stock availability
                    if str(batch.pk) in stock_items:
                        stock_items[str(batch.pk)]['qty'] += qty
                    else:
                        stock_items[str(batch.pk)] = obj2

            # Checking the stock available for this product
            for key, value in stock_items.items():
                batch = all_batches.get(pk=key)
                qty = value['qty']

                stock = batch.stock
                product_variant = batch.product_variant

                if qty > stock:
                    stock_ok = False
                    error_message += f"{product_variant} has only {stock} in stock in batch {batch}, You entered {qty} quantity\n"

            if stock_ok and batch_ok:
                prefix = form.cleaned_data['prefix']
                order_id = form.cleaned_data['order_id']
                total_amt = form.cleaned_data['total_amt']
                address_instance = form.cleaned_data['address']
                is_express_delivery = form.cleaned_data['is_express_delivery']

                order_no = Orders.objects.filter(is_deleted=False, prefix=prefix).aggregate(Max('order_no')).get('order_no__max', 0) or 0
                if Orders.objects.filter(order_id=order_id).exists():
                    pass

                data = form.save(commit=False)
                data.auto_id = get_auto_id(Orders)
                data.creator = request.user
                data.updater = request.user

                data.payment_method = 'cod'
                data.payment_status = "10"
                data.order_status = "10"
                data.is_manual = False
                data.order_no = order_no + 1

                data.zone = address_instance.zone
                data.billing_name = address_instance.name
                data.billing_phone = address_instance.phone
                data.billing_address = address_instance.house_name
                data.billing_street = address_instance.street
                data.billing_landmark = address_instance.landmark
                data.billing_city = address_instance.city
                data.billing_state = address_instance.state
                data.billing_latitude = address_instance.location.latitude
                data.billing_longitude = address_instance.location.longitude

                data.save()

                for item in batch_items:
                    qty = item["qty"]
                    price = item["price"]
                    batch = item['batch']

                    OrderItem.objects.create(
                        order = data,
                        product_variant = batch.product_variant,
                        batch = batch,
                        price = price,
                        qty = qty
                    )

                    if batch:
                        update_batch_stock(batch.pk, qty, "decrease")

                response_data = {
                    "status": "true",
                    "title": "Order placed successfully",
                    "message": f"Order for {customer} has been placed.",
                    "redirect": 'true',
                    "redirect_url": reverse("orders:order", kwargs={"pk": data.pk})
                }
            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }
        else:
            message = generate_form_errors(form)
            message += generate_form_errors(order_item_formset, formset=True)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        today = datetime.datetime.now()
        warehouse = get_warehouse(request)

        form = OrdersForm(initial={'warehouse': warehouse, 'delivery_date': today.date()})
        order_item_formset = OrderItemFormset(prefix='order_item_formset')
        address_form = AddressForm()
        location_form = LocationForm()
        customer_form = CustomerCreateFromForm()

        for form_item in order_item_formset:
            form_item.fields['product_variant'].queryset = ProductVariant.objects.none()
            form_item.fields['batch'].queryset = Batch.objects.none()

        address_form.fields['zone'].widget.attrs['class'] = 'form-control'
        form.fields['time_slot'].queryset = TimeSlot.objects.filter(day=today.isoweekday(), is_active=True, start_time__gt=today.time())

        context = {
            "redirect": True,
            "is_create_page": True,
            "title": "Create Order",
            "form": form,
            "address_form": address_form,
            "location_form": location_form,
            "customer_form": customer_form,
            "order_item_formset": order_item_formset,
            "url": reverse('orders:create_order'),
        }

        return render(request, 'orders/orders/entry.html', context)


