from django.shortcuts import redirect, render, get_object_or_404
from django.http.response import HttpResponseRedirect, HttpResponse
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_GET
from django.core import serializers
from django.contrib.auth.models import Group
from django.db.models import Sum, Q, F
from django.http import JsonResponse
from django.utils.translation import activate
from django.utils import translation
from django.db import transaction, IntegrityError
import datetime
import json
import re
from customers.models import Customer
from main.decorators import role_required
from main.forms import CompanyProfileForm
from main.functions import generate_form_errors, get_auto_id, get_current_role
from main.models import CompanyProfile
from orders.models import Orders
from sales.models import Sale, SaleItem
from purchases.models import Purchase
from products.models import ProductVariant


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager', 'normal_staff', 'billing_staff', 'vendor_user'])
def app(request):
    return HttpResponseRedirect(reverse('dashboard'))


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager', 'normal_staff', 'billing_staff','vendor_user'])
def dashboard(request):
    today = datetime.datetime.now()
    no_of_orders = 0
    no_of_sales = 0
    no_of_pending_orders = 0
    no_of_shipped_orders = 0
    no_of_delivered_orders = 0
    no_of_cancelled_orders = 0
    no_of_purchases = 0
    products = None

    sale_total = 0
    order_subtotal = 0

    current_role = get_current_role(request)

    if current_role == 'vendor_user':
        orders = Orders.objects.filter(is_deleted=False, vendor__user=request.user).order_by('-date_added')
        products = ProductVariant.objects.filter(is_deleted=False, product__vendor__user=request.user).order_by('-date_added')[:5]
    else:
        orders = Orders.objects.filter(is_deleted=False).order_by('-date_added')

    invoices = Sale.objects.filter(is_deleted=False).order_by('-date_added')[:5]
    customers = Customer.objects.filter(is_deleted=False).order_by('-date_added')[:5]

    pending_orders = orders.filter(order_status="10")
    shipped_orders = orders.filter(order_status="20")
    delivered_orders = orders.filter(order_status="30")
    cancelled_orders = orders.filter(order_status="40")

    no_of_orders = orders.count()
    no_of_pending_orders = pending_orders.count()
    no_of_shipped_orders = shipped_orders.count()
    no_of_delivered_orders = delivered_orders.count()
    no_of_cancelled_orders = cancelled_orders.count()
    order_subtotal = orders.aggregate(total_amt=Sum('total_amt')).get("total_amt", 0)

    orders = orders[:5]
    pending_orders = pending_orders[:10]
    shipped_orders = shipped_orders[:10]
    delivered_orders = delivered_orders[:10]
    cancelled_orders = cancelled_orders[:10]

    if Sale.objects.filter(is_deleted=False, date_added__date=today.date()).exists():
        sales = Sale.objects.filter(is_deleted=False, date_added__date=today.date())
        no_of_sales = sales.count()

        if sales.filter(paid__lt=F('total')).exists():
            credit_sale_total = sales.filter(paid__lt=F('total')).annotate(balance=F('total')-F('paid')).aggregate(new_balance=Sum('balance')).get('new_balance', 0)
            credit_sale_count = sales.filter(paid__lt=F('total')).count()

        sale_items = SaleItem.objects.filter(sale__in=sales)
        sale_total = sales.aggregate(total=Sum('total')).get("total", 0)

    if Purchase.objects.filter(is_deleted=False, date_added__date=today.date()).exists():
        purchases = Purchase.objects.filter(is_deleted=False, date_added__date=today.date())
        no_of_purchases = purchases.count()

    context = {
        "title": "Dashboard",

        "order_subtotal": order_subtotal, # order_subtotal,
        "sale_subtotal": sale_total,

        "no_of_sales":no_of_sales,
        "no_of_purchases": no_of_purchases,
        "no_of_orders":no_of_orders,
        "no_of_pending_orders":no_of_pending_orders,
        "no_of_shipped_orders":no_of_shipped_orders,
        "no_of_delivered_orders":no_of_delivered_orders,
        "no_of_cancelled_orders":no_of_cancelled_orders,

        "orders":orders,
        "products":products,
        "invoices":invoices,
        "customers":customers,
        "pending_orders":pending_orders,
        "shipped_orders":shipped_orders,
        "delivered_orders":delivered_orders,
        "cancelled_orders":cancelled_orders,

        "today": today.strftime('%Y-%m-%d')

    }
    return render(request, "base.html", context)


@login_required
def check_password_policy(request):
    username = request.GET.get('username')
    password1 = request.GET.get('password1')
    s = password1
    regex = re.compile('[@_!#$%^&*()<>?/\|}{~:]')
    regex1 = re.compile('[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z]')
    regex2 = re.compile('[123456789]')

    l = len(password1)
    if s.find(username) == -1 and l > 8 and (regex.search(password1) != None) and (regex1.search(password1) != None) and (regex2.search(password1) != None):
        response_data = {
            "status": "true",
        }
    else:
        response_data = {
            "status": "false",
        }
    return JsonResponse(response_data)


def switch_language(request):
    lang = request.GET.get('language') # accepting value choosen by client
    next = request.GET.get('next')
    language = translation.get_language() # this will return current active language

    if lang == "en":
        activate('en')
    elif lang == "ml":
        activate('ml')
    elif lang == "ar":
        activate('ar')

    # return HttpResponseRedirect(next)
    return HttpResponseRedirect(reverse('web:index'))


def search(request):
    sale_instances = Sale.objects.all()
    order_instances = Orders.objects.all()
    customer_instances = Customer.objects.all()
    product_instances = ProductVariant.objects.all()

    query = request.GET.get('q')

    sale_instances = sale_instances.filter(
        Q(sale_id__iexact=query) |
        Q(customer__name__icontains=query) |
        Q(customer__phone__icontains=query) |
        Q(customer__email__icontains=query)
    )

    order_instances = order_instances.filter(
        Q(order_id__iexact=query) |
        Q(customer__name__icontains=query) |
        Q(billing_name__icontains=query) |
        Q(customer__phone__icontains=query) |
        Q(delivery_agent__name__icontains=query)
    )

    customer_instances = customer_instances.filter(
        Q(name__icontains=query) |
        Q(phone__icontains=query) |
        Q(email__icontains=query)
    )

    product_instances = product_instances.filter(
        Q(title__icontains=query) |
        Q(product_code__iexact=query) |
        Q(product__name__icontains=query) |
        Q(product__category__name__icontains=query) |
        Q(product__subcategory__name__icontains=query) |
        Q(product__brand__name__icontains=query)
    )

    context = {
        "title": "Global Search",
        "sales": sale_instances,
        "orders": order_instances,
        "products": product_instances,
        "customers": customer_instances,
        "search_filter_query": query,
    }
    return render(request, "reports/search.html", context)


# ---------------------------------------------
# 🔹 Company Profile Views
# ---------------------------------------------
@login_required
def company_profile_info(request, pk):
    instance = CompanyProfile.objects.get(pk=pk)
    
    context = {
        "instance": instance,
        "title": "Company Profile",
    }
    return render(request, "main/company_profile/info.html", context)

@login_required
def company_profile_list(request):
    instances = CompanyProfile.objects.filter(is_deleted=False)
    
    if instances.exists():
        instance = instances.first()
        return redirect('main:company_profile_info', pk=instance.pk)
    else:
        return redirect('main:company_profile_create')
        
@login_required
@transaction.atomic
def company_profile_create(request):
    if request.method == "POST":
        form = CompanyProfileForm(request.POST)
        
        if form.is_valid():
            
            instance = form.save(commit=False)
            instance.creator = request.user
            instance.auto_id = get_auto_id(CompanyProfile)
            instance.save()

            response_data = {
                "status": "true",
                "title": "Successfully Created",
                "message": "Company Profile created successfully.",
                "redirect": "true",
                "redirect_url": reverse("main:company_profile_list"),
            }
        else:
            response_data = {
                "status": "false",
                "title": "Form validation error",
                "message": generate_form_errors(form),
            }

        return HttpResponse(json.dumps(response_data), content_type="application/javascript")

    form = CompanyProfileForm()
    
    context = {
        "form": form,
        "title": "Create Company Profile",
    }
    
    return render(request, "main/company_profile/create.html", context)


@login_required
# @role_required(["superadmin", "staff", "warehouse_manager"])
def company_profile_edit(request, pk):
    instance = get_object_or_404(CompanyProfile.objects.filter(pk=pk, is_deleted=False))

    if request.method == "POST":
        response_data = {}
        form = CompanyProfileForm(request.POST, request.FILES, instance=instance)

        if form.is_valid():
            # update category
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Company Profile Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse("main:company_profile_info", kwargs={"pk": data.pk}),
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
        form = CompanyProfileForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Company Profile : " + instance.company_name,
            "instance": instance,
            "url": reverse("main:company_profile_edit", kwargs={"pk": instance.pk}),
            "redirect": True,
        }
        
        return render(request, "main/company_profile/create.html", context)


@login_required
def company_profile_delete(request, pk):
    instance = get_object_or_404(CompanyProfile, pk=pk, is_deleted=False)
    instance.is_deleted = True
    instance.deleted_reason = request.GET.get("reason", "Deleted by user")
    instance.save()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Company Profile deleted successfully.",
        "redirect": "true",
        "redirect_url": reverse("main:company_profile_list"),
    }
    return HttpResponse(json.dumps(response_data), content_type="application/javascript")