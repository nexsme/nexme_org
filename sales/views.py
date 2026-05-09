# Standard Libraries
import json
import datetime
from decimal import Decimal
from datetime import timedelta
# Third Party Libraries
from dal import autocomplete
# Django Libraries
from django.shortcuts import render, get_object_or_404
from django.http.response import HttpResponseRedirect, HttpResponse, JsonResponse
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Count, Q, Max, F, ExpressionWrapper, DecimalField
from django.forms.models import inlineformset_factory
from django.forms.formsets import formset_factory
from django.template.loader import render_to_string
# Local Libraries
from main.functions import get_auto_id, generate_form_errors, get_date_updated_request, get_a_id
from main.decorators import role_required, ajax_required
from main.utils.export_to_excel import ExportToExcelUtils
from api.v1.general.serializers import PurchaseExportSerializer
from api.v1.general.serializers import SaleExportSerializer
from finance.models import AccountGroup, AccountHead, ReceiptVoucher, InvoicePrefix, FinancialYear
from customers.models import Customer, PrivilegePoint
from customers.functions import update_privilege_point
from users.functions import get_warehouse
from staffs.models import Staff
from orders.models import Orders
from products.models import Product, ProductVariant
from general.models import Batch, InvoiceDesign
from sales.models import Sale, SaleItem, SaleReturn, SaleReturnItem
from sales.forms import SaleForm, SaleItemForm, CustomerCreateFromForm, SaleReturnForm, SaleReturnItemForm, SaleVoucherForm
from sales.functions import return_commission, create_or_update_commission, get_sale_invoice_id, update_batch_stock
from sales.filters import SaleFilter


class SaleAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self, *args, **kwargs):
        items = Sale.objects.filter(is_deleted=False).order_by('-sale_date')
        customer = self.forwarded.get('customer', None)

        if Staff.objects.filter(user=self.request.user).exists():
            warehouse = Staff.objects.get(user=self.request.user).warehouse
            items = items.filter(warehouse=warehouse)

        if customer:
            items = items.filter(customer=customer)

        if self.q:
            items = items.filter(
                Q(sale_id__icontains=self.q) |
                Q(customer__name__istartswith=self.q) |
                Q(customer__email__istartswith=self.q) |
                Q(customer__phone__istartswith=self.q)
            )

        return items


class SaleReturnAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self, *args, **kwargs):
        items = SaleReturn.objects.filter(is_deleted=False).order_by('-time')
        customer = self.forwarded.get('customer', None)
        if customer:
            items = items.filter(customer=customer)

        if self.q:
            items = items.filter(
                Q(auto_id__istartswith=self.q) |
                Q(customer__name__istartswith=self.q) |
                Q(customer__email__istartswith=self.q) |
                Q(customer__phone__istartswith=self.q)
            )

        return items


def customer_from_create(request):
    if request.method == 'POST':
        form = CustomerCreateFromForm(request.POST)
        code = "onaiza"
        if form.is_valid():
            # create customer
            email = form.cleaned_data['email']
            phone = form.cleaned_data['phone']
            customers = Customer.objects.filter(is_deleted=False)

            if email and customers.filter(email=email).exists():
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "A customer with this email already exist."
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if not customers.filter(phone=phone).exists():
                opening_type = form.cleaned_data['opening_type']
                opening_balance = form.cleaned_data['opening_balance']

                current_balance = 0
                if opening_type == 'debit':
                    current_balance += opening_balance
                elif opening_type == 'credit':
                    current_balance -= opening_balance

                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = get_auto_id(Customer)
                data.current_balance = current_balance
                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully created",
                    "message": " successfully created.",
                    "redirect": "false",
                    "customer_id": str(data.id),
                    "name": str(data.name),
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            else:

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "A customer with this phone/email already exist."
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
        else:
            message = generate_form_errors(form, formset=False)
            print(message)
            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

            return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create(request):
    try_error_message = ''
    try:
        SaleItemFormset = formset_factory(SaleItemForm, extra=3)
        sale_id = get_sale_invoice_id(request)

    except Exception as e:
        try_error_message += '%s (%s)' % (e, type(e))

    if request.method == 'POST':
        try:
            ModifiedRequest = get_date_updated_request(request.POST.copy(), ['sale_date', 'credit_date', 'shipment_date', 'cheque_date', 'draft_date', 'transfer_date'])

            form = SaleForm(ModifiedRequest)
            voucher_form = SaleVoucherForm(ModifiedRequest)
            sale_item_formset = SaleItemFormset(request.POST, prefix='sale_item_formset')

        except Exception as e:
            try_error_message += '%s (%s)' % (e, type(e))

        all_forms_valid = False
        try:
            if form.is_valid() and sale_item_formset.is_valid() and voucher_form.is_valid():
                all_forms_valid = True

        except Exception as e:
            try_error_message += '%s (%s)' % (e, type(e))

        if try_error_message:
            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": try_error_message
            }
            return HttpResponse(json.dumps(response_data), content_type='application/javascript')

        if all_forms_valid:
            try:
                sale_date = form.cleaned_data['sale_date']
                customer = form.cleaned_data['customer']
                warehouse = form.cleaned_data['warehouse']
                total_sale_amount = form.cleaned_data['total']
                sale_category = form.cleaned_data['sale_category']
                sale_type = form.cleaned_data['sale_type']
                subtotalamount = form.cleaned_data['subtotal']
                add_gst = form.cleaned_data['add_gst']
                paid = form.cleaned_data['paid']
                main_discount_rate = form.cleaned_data['discount_rate']
                net_discount = form.cleaned_data['discount']
                customer_address = form.cleaned_data['customer_address']
                privilege_point_used = form.cleaned_data['privilege_point_used']
                privilege_point_amnt = form.cleaned_data['privilege_point_amnt']
                use_privilege_point = form.cleaned_data['use_privilege_point']

                if use_privilege_point:
                    if privilege_point_used > customer.current_privilege_points:
                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": "Customer have only" + str(customer.current_privilege_points) + "Points"
                        }

                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')



                count_sale = len(sale_item_formset)
                all_batches = Batch.objects.filter(warehouse=warehouse, is_deleted=False)
                all_variants = ProductVariant.objects.filter(is_deleted=False)

                if not count_sale:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": f"No sale items"
                    }
                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

                if voucher_form.cleaned_data['transfer_type'] == 30 and paid > 0:
                    response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": "Please ensure that the paid amount is zero for credit transfer transactions before submission."
                        }
                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


                if voucher_form.cleaned_data['transfer_type'] in [15, 20, 25]:
                    bank = voucher_form.cleaned_data['bank']
                    if not bank:
                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": "Please choose a bank account before submitting."
                        }
                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

                if voucher_form.cleaned_data['transfer_type'] != 30 and not paid:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": "Please enter paid amount or change payment method to credit."
                    }
                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

                elif voucher_form.cleaned_data['transfer_type'] == 30 and paid:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": "Please choose a payment method if a payment is in progress."
                    }
                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            except Exception as e:
                try_error_message += '%s (%s)' % (e, type(e))

            if FinancialYear.objects.filter(is_deleted=False, is_active=True, start_date__date__lte=sale_date, end_date__date__gte=sale_date).exists():
                financial_year = FinancialYear.objects.get(is_deleted=False, start_date__date__lte=sale_date, end_date__date__gte=sale_date)
                if customer:
                    if customer.name == 'Default Customer' and not total_sale_amount == paid:
                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": "Paid and total must equal to Default Customer."
                        }
                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

                    batch_items = []  # to save all items as seperate sale items
                    stock_items = {}  # to check stock availability

                    stock_ok = True
                    discount_ok = True
                    error_message = ''

                    try:
                        for f in sale_item_formset:
                            if f.cleaned_data != {}:
                                batch = f.cleaned_data['batch']
                                product_variant = f.cleaned_data['product_variant']

                                if not batch and not product_variant.is_special_variant:
                                    # if product is special variant, then there won't be a batch
                                    # other wise batch is a must
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

                    except Exception as e:
                        try_error_message += '%s (%s)' % (e, type(e))

                    try:
                        for f in sale_item_formset:
                            if f.cleaned_data != {}:
                                product_variant = f.cleaned_data['product_variant']
                                qty = f.cleaned_data['quantity']
                                mrp = f.cleaned_data['mrp']
                                amount = f.cleaned_data['amount']
                                discount_rate = f.cleaned_data['discount_rate']
                                discount = f.cleaned_data['discount']
                                batch = f.cleaned_data['batch']
                                comments = f.cleaned_data['comments']

                                selling_price = amount
                                discount_rate = discount_rate * 100 / selling_price

                                obj = {
                                    "mrp": mrp,
                                    'batch': batch,
                                    "quantity": qty,
                                    "amount": amount,
                                    "comments": comments,
                                    "discount": discount,
                                    "discount_rate": discount_rate,
                                    "product_variant": product_variant,
                                    # "tax_percent": product_variant.tax_percent,
                                }
                                batch_items.append(obj)

                                obj2 = {
                                    "mrp": mrp,
                                    'batch': batch,
                                    "quantity": qty,
                                    "amount": amount,
                                    "discount": discount,
                                    "discount_rate": discount_rate,
                                    "product_variant": product_variant,
                                    # "tax_percent": product_variant.tax_percent,
                                }

                                # to check stock availability
                                if batch:
                                    if str(batch.pk) in stock_items:
                                        stock_items[str(batch.pk)]['quantity'] += qty
                                    else:
                                        stock_items[str(batch.pk)] = obj2
                                else:
                                    if str(product_variant.pk) in stock_items:
                                        stock_items[str(product_variant.pk)]['quantity'] += qty
                                    else:
                                        stock_items[str(product_variant.pk)] = obj2

                    except Exception as e:
                        try_error_message += '%s (%s)' % (e, type(e))

                    # Checking the stock available for this product
                    try:
                        for key, value in stock_items.items():
                            batch = value['batch']
                            quantity = value['quantity']
                            product_variant = value['product_variant']

                            if product_variant.is_special_variant:
                                stock = stock = product_variant.total_stock()
                                if quantity > stock:
                                    stock_ok = False
                                    error_message += f"{product_variant} has only {stock} in stock , You entered {quantity} quantity\n"
                            else:
                                stock = batch.stock
                                if quantity > stock:
                                    stock_ok = False
                                    error_message += f"{product_variant} has only {stock} in stock in batch {batch}, You entered {quantity} quantity\n"

                            disc_limit = product_variant.discount_limit
                            discount_rate = value['discount'] / quantity
                            if discount_rate > disc_limit and disc_limit > 0 and False:
                                ''' since no extra discount can be added in sale item
                                only the mrp - price is considered as discount. '''
                                discount_ok = False
                                error_message += f"discount given for {product_variant} exceeded its discount limit\n"

                    except Exception as e:
                        try_error_message += '%s (%s)' % (e, type(e))

                    if try_error_message:
                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": try_error_message
                        }
                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

                    if stock_ok and discount_ok:
                        auto_id = get_auto_id(Sale)
                        a_id = get_a_id(Sale, warehouse)
                        sale_date = datetime.datetime.combine(sale_date, datetime.datetime.now().time())

                        # Sale Id
                        sale_no = 1
                        if Sale.objects.filter(is_deleted=False).exists():
                            latest_sale_no = Sale.objects.filter(is_deleted=False).aggregate(Max('auto_id'))
                            latest_sale = latest_sale_no['auto_id__max']
                            sale_no = latest_sale + 1

                        track = sale_no
                        track = 1
                        if Sale.objects.all().exists():
                            latest_tracking_no = Sale.objects.all().latest("date_added")
                            track = latest_tracking_no.tracking_no + 1

                        ledger_data = None
                        sale_id = form.cleaned_data['sale_id']

                        data1 = form.save(commit=False)

                        data1.a_id = a_id
                        data1.auto_id = auto_id
                        data1.creator = request.user
                        data1.updater = request.user

                        data1.sale_no = sale_no
                        data1.sale_id = sale_id
                        data1.tracking_no = track
                        data1.tracking_id = "TR" + str(data1.tracking_no)

                        data1.sale_date = sale_date
                        data1.discount = net_discount
                        data1.discount_rate = main_discount_rate
                        data1.customer_address = customer_address
                        data1.save()

                        discount = balance = all_tax_total = 0

                        for value in batch_items:
                            mrp = value["mrp"]
                            batch = value['batch']
                            qty = value["quantity"]
                            amount = value["amount"]
                            comments = value["comments"]
                            # tax_percent = value['tax_percent']
                            discount_amount = value["discount"]
                            product_variant = value["product_variant"]

                            cost = product_variant.cost if product_variant.is_special_variant else batch.cost

                            total_cost = cost * qty
                            total_amount = amount * qty
                            total_mrp_amount = mrp * qty

                            if customer.state == 'Kerala':
                                cgst_rate = product_variant.product.hsn.cgst_rate
                                sgst_rate = product_variant.product.hsn.sgst_rate
                                igst_rate = 0
                                tax_percent = cgst_rate + sgst_rate + igst_rate
                                taxable_amount = round(total_amount / (1 + (tax_percent / 100)), 2)
                                purchase_taxable_amount = round(total_cost / (1+(tax_percent/100)), 2)

                                tax_amount = total_amount - taxable_amount
                                all_tax_total += tax_amount
                                cgst_amount = round((taxable_amount * cgst_rate/100), 2)
                                sgst_amount = round((taxable_amount * sgst_rate/100), 2)
                                igst_amount = 0
                            else:
                                igst_rate = product_variant.product.hsn.igst_rate
                                cgst_rate = 0
                                sgst_rate = 0
                                tax_percent = cgst_rate + sgst_rate + igst_rate
                                taxable_amount = round(total_amount / (1 + (tax_percent / 100)), 2)
                                purchase_taxable_amount = round(total_cost / (1+(tax_percent/100)), 2)

                                tax_amount = total_amount - taxable_amount
                                all_tax_total += tax_amount
                                igst_amount = round((taxable_amount * igst_rate/100), 2)
                                cgst_amount = sgst_amount = 0

                            SaleItem.objects.create(
                                product_variant=product_variant,
                                batch=batch,
                                sale=data1,

                                quantity=qty,
                                amount=amount,
                                mrp=mrp,

                                # tax_percent=tax_percent,
                                # tax_amount=tax_amount,
                                igst_rate=igst_rate,
                                cgst_rate=cgst_rate,
                                sgst_rate=sgst_rate,
                                igst_amount=igst_amount,
                                cgst_amount=cgst_amount,
                                sgst_amount=sgst_amount,
                                discount=discount_amount,
                                comments=comments,
                                commission_amount=0,

                                sub_total=taxable_amount,
                                net_rate=total_mrp_amount,
                                total=total_amount,

                                sale_taxable_amount=taxable_amount,
                                purchase_taxable_amount=purchase_taxable_amount,
                            )

                            if product_variant.is_special_variant:
                                special_variant = product_variant.special_variant_added
                                variants = special_variant.product_variant.all()
                                special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, stock__gt=0, is_deleted=False).order_by('expire_date')
                                total_qty = qty

                                for variant_obj in variants:
                                    variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                                    total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                                    if variant_stocks.filter(stock__gte=total_qty).exists():
                                        variant_stock = variant_stocks.filter(stock__gte=total_qty).first().stock
                                        pk = variant_stocks.filter(stock__gte=total_qty).first().pk

                                        if variant_stock > total_qty:
                                            Batch.objects.filter(pk=pk).update(stock=variant_stock - total_qty)

                                    elif total_stock > total_qty:
                                        for batch_item in variant_stocks:
                                            if batch_item.stock >= total_qty:
                                                batch_item.stock = batch_item.stock - total_qty
                                                batch_item.save()
                                                break
                                            elif batch_item.stock < total_qty:
                                                total_qty -= batch_item.stock
                                                batch_item.stock = 0
                                                batch_item.save()
                                    print(variant_obj.total_stock(), 'total stock of special variant')

                            elif batch:
                                update_batch_stock(batch.pk, qty, "decrease")

                        sale_items_data = SaleItem.objects.filter(sale=data1)

                        # data1.tax_amount = sale_items_data.aggregate(Sum('tax_amount'))['tax_amount__sum']
                        data1.igst_amount = sale_items_data.aggregate(Sum('igst_amount'))['igst_amount__sum']
                        data1.cgst_amount = sale_items_data.aggregate(Sum('cgst_amount'))['cgst_amount__sum']
                        data1.sgst_amount = sale_items_data.aggregate(Sum('sgst_amount'))['sgst_amount__sum']

                        data1.sale_taxable_amount = sale_items_data.aggregate(Sum('sale_taxable_amount'))['sale_taxable_amount__sum']
                        data1.purchase_taxable_amount = sale_items_data.aggregate(Sum('purchase_taxable_amount'))['purchase_taxable_amount__sum']

                        # PrivilegePoint Start
                        if use_privilege_point:
                            status, prvlg_amount = update_privilege_point(customer, 'used', privilege_point_used, data1)

                            if not status:
                                data1.use_privilege_point = False
                                privilege_point_used = 0

                            data1.privilege_point_used = privilege_point_used
                            data1.privilege_point_amnt = prvlg_amount
                            total_sale_amount -= prvlg_amount

                        # Adding Privilege Point to customer
                        if customer.name != 'Default Customer':
                            prvlg_points, prvlg_amount = update_privilege_point(customer, 'gained', sale_instance=data1)
                            if prvlg_points and prvlg_points > 0:
                                data1.privilege_points = prvlg_points
                        # PrivilegePoint end here

                        data1.subtotal = subtotalamount
                        data1.total = total_sale_amount

                        if ledger_data:
                            customer_balance = ledger_data['closing_balance']
                            customer_balance_type = 'Debit'

                            if customer_balance < 0:
                                customer_balance_type = 'Credit'
                                customer_balance = abs(customer_balance)

                            data1.customer_balance = customer_balance
                            data1.customer_balance_type = customer_balance_type

                        balance = total_sale_amount - paid
                        total_amount = total_sale_amount
                        customer = data1.customer
                        payment_method = 'credit'

                        balance = total_amount - paid
                        current_balance = customer.current_balance
                        n_balance = current_balance - balance
                        Customer.objects.filter(pk=customer.pk).update(current_balance=n_balance)

                        # Finance
                        if paid > 0:
                            account_head = AccountHead.objects.get(code="sundry_debtor_customer",is_deleted=False)

                            # Set ReceiptVoucher
                            if ReceiptVoucher.objects.all().exists():
                                number = ReceiptVoucher.objects.aggregate(voucher_number=Max('voucher_number')).get('voucher_number')
                                voucher_no = int(number) + 1
                            else:
                                voucher_no = 1

                            transfer_type = voucher_form.cleaned_data['transfer_type']

                            if transfer_type == 10:
                                receipt_voucher = ReceiptVoucher.objects.create(
                                    auto_id=get_auto_id(ReceiptVoucher),
                                    creator=request.user,
                                    updater=request.user,
                                    account_head = account_head,
                                    voucher_number = voucher_no,
                                    voucher_date = data1.sale_date,
                                    title = "Sale Payment received",
                                    description = "Sale Payment received",
                                    amount = paid,
                                    transfer_type = 10,
                                    sub_ledger = customer.pk,
                                    is_system_generated = True,

                                    financial_year=financial_year,
                                    warehouse=warehouse,
                                )

                                payment_method = 'cash'

                            elif transfer_type in [15, 20, 25]:
                                bank = voucher_form.cleaned_data['bank']
                                cheque_number = None
                                cheque_date = None
                                status = 20
                                draft_number = None
                                draft_date = None
                                transfer_number = None
                                transfer_date = None

                                if transfer_type == 15:
                                    payment_method = 'cheque'
                                    cheque_number = voucher_form.cleaned_data['cheque_number']
                                    cheque_date = voucher_form.cleaned_data['cheque_date']
                                elif transfer_type == 20:
                                    payment_method = 'draft'
                                    draft_number = voucher_form.cleaned_data['draft_number']
                                    draft_date = voucher_form.cleaned_data['draft_date']
                                elif transfer_type == 25:
                                    payment_method = 'bank transfer'
                                    transfer_number = voucher_form.cleaned_data['transfer_number']
                                    transfer_date = voucher_form.cleaned_data['transfer_date']

                                receipt_voucher = ReceiptVoucher.objects.create(
                                    auto_id=get_auto_id(ReceiptVoucher),
                                    creator=request.user,
                                    updater=request.user,
                                    account_head = account_head,
                                    voucher_number = voucher_no,
                                    voucher_date = data1.sale_date,
                                    title = "Sale Payment received",
                                    description = "Sale Payment received",
                                    amount = paid,
                                    sub_ledger = customer.pk,
                                    transfer_type = transfer_type,
                                    is_system_generated = True,

                                    bank = bank,
                                    cheque_number = cheque_number,
                                    cheque_date = cheque_date,
                                    cheque_status = status,
                                    draft_number = draft_number,
                                    draft_date = draft_date,
                                    transfer_number = transfer_number,
                                    transfer_date = transfer_date,

                                    financial_year=financial_year,
                                    warehouse=warehouse,
                                )
                            else:
                                receipt_voucher = None

                            data1.receipt_voucher = receipt_voucher
                        data1.payment_method = payment_method
                        data1.save()

                        response_data = {
                            "status": "true",
                            "title": "Successfully Created",
                            "message": "Sale created successfully.",
                            "redirect": "true",
                            "redirect_url": reverse('sales:sale', kwargs={'pk': data1.pk})
                        }

                    else:
                        message = 'Sorry..! Not Enough Stock '
                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": error_message
                        }

                else:
                    message = 'Please Select Customer'
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": message,
                    }

            else:
                if FinancialYear.objects.filter(is_deleted=False, is_active=True,).exists():
                    error_message = "Sale date must be within active financial year."
                elif FinancialYear.objects.filter(is_deleted=False, is_active=False).exists():
                    error_message = "Don't have an active Financial year."
                else:
                    error_message = "Please Add a Financial year."

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Financial Year error",
                    "message": error_message
                }

        else:
            error_message = generate_form_errors(voucher_form, formset=False)
            error_message += generate_form_errors(form, formset=False)
            error_message += generate_form_errors(sale_item_formset, formset=True)

            print("--------------------------error--message-------------------------------")
            print(form.errors)
            print(sale_item_formset.errors)
            print(voucher_form.errors)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(error_message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        sale_no = 1
        customer_form = CustomerCreateFromForm()

        if Customer.objects.filter(name='Default Customer').exists():
            customer = Customer.objects.filter(name='Default Customer').latest('auto_id')
        else:
            customer = Customer.objects.create(
                name='Default Customer',
                auto_id=get_auto_id(Customer),
                creator=request.user,
                updater=request.user,
            )

        sale_item_formset = SaleItemFormset(prefix='sale_item_formset')

        for form in sale_item_formset:
            form.fields['product_variant'].queryset = ProductVariant.objects.none()
            form.fields['batch'].queryset = Batch.objects.none()

        warehouse = get_warehouse(request)

        sale_form = SaleForm(initial={"customer": customer, "sale_type": "b2c", 'warehouse': warehouse})
        voucher_form = SaleVoucherForm(initial={'transfer_type': 10})

        context = {
            "redirect": True,
            "form": sale_form,
            "sale_id": sale_id,
            "is_create_page": True,
            "title": "Create Sale ",
            "url": reverse('sales:create'),
            "customer_form": customer_form,
            "sale_item_formset": sale_item_formset,
            "voucher_form":voucher_form
        }

        return render(request, 'sales/entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit(request, pk):
    instance = get_object_or_404(Sale.objects.filter(pk=pk, is_deleted=False))
    saleitem = SaleItem.objects.filter(sale=instance)

    customer = instance.customer
    sale_id = instance.sale_id

    old_paid = Sale.objects.get(pk=pk).subtotal
    old_warehouse = instance.warehouse

    voucher_instance = instance.receipt_voucher

    if saleitem.exists():
        extra = 0
    else:
        extra = 1

    SaleItemFormset = inlineformset_factory(
        Sale,
        SaleItem,
        can_delete=True,
        extra=extra,
        form=SaleItemForm,
    )

    old_paid = instance.paid
    old_total_amount = instance.subtotal
    old_customer = Customer.objects.get(pk=instance.customer.pk)

    if request.method == 'POST':
        ModifiedRequest = get_date_updated_request(request.POST.copy(), ['sale_date', 'credit_date', 'shipment_date', 'cheque_date', 'draft_date', 'transfer_date'])

        form = SaleForm(ModifiedRequest, instance=instance)
        voucher_form = SaleVoucherForm(ModifiedRequest, instance=voucher_instance)
        sale_item_formset = SaleItemFormset(request.POST, prefix='sale_item_formset', instance=instance)

        if form.is_valid() and sale_item_formset.is_valid() and voucher_form.is_valid():
            privilege_point_used = form.cleaned_data['privilege_point_used']
            privilege_point_amnt = form.cleaned_data['privilege_point_amnt']
            use_privilege_point = form.cleaned_data['use_privilege_point']
            warehouse = form.cleaned_data['warehouse']
            sale_date = form.cleaned_data['sale_date']
            customer = form.cleaned_data['customer']
            total_sale_amount = form.cleaned_data['total']
            sale_category = form.cleaned_data['sale_category']
            subtotalamount = form.cleaned_data['subtotal']
            add_gst = form.cleaned_data['add_gst']
            paid = form.cleaned_data['paid']
            main_discount_rate = form.cleaned_data['discount_rate']
            net_discount = form.cleaned_data['discount']
            customer_address = form.cleaned_data['customer_address']

            if len(sale_item_formset) == 0:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": f"No sale items"
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if use_privilege_point:
                if privilege_point_used > customer.current_privilege_points:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": "Customer have onlly" + str(customer.privilege_points) + "Points"
                    }

                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if voucher_form.cleaned_data['transfer_type'] in [15, 20, 25]:
                bank = voucher_form.cleaned_data['bank']
                if not bank:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": "Please choose a bank account before submitting."
                    }
                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if voucher_form.cleaned_data['transfer_type'] != 30 and not paid:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please enter paid amount or change payment method to credit."
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if voucher_form.cleaned_data['transfer_type'] == 30 and paid:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please choose a payment method if a payment is in progress."
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if customer.name == 'Default Customer' and not total_sale_amount == paid:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Paid and total must equal to Default Customer."
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            if FinancialYear.objects.filter(is_deleted=False, is_active=True, start_date__date__lte=sale_date, end_date__date__gte=sale_date).exists():
                financial_year = FinancialYear.objects.get(is_deleted=False, start_date__date__lte=sale_date, end_date__date__gte=sale_date)

                previous_sale_items = SaleItem.objects.filter(sale=instance)

                new_total_quantity = 0
                batch_items = []
                stock_items = {}  # to check stock availability
                stock_ok = True
                error_message = ''

                for f in sale_item_formset:
                    if f not in sale_item_formset.deleted_forms:
                        product_variant = f.cleaned_data['product_variant']
                        batch = f.cleaned_data['batch']
                        qty = f.cleaned_data['quantity']
                        amount = f.cleaned_data['amount']
                        mrp = f.cleaned_data['mrp']
                        comments = f.cleaned_data['comments']
                        discount = f.cleaned_data['discount']
                        discount_rate = f.cleaned_data['discount_rate']

                        new_total_quantity += qty

                        obj = {
                            "quantity": qty,
                            "batch": batch,
                            "product_variant": product_variant,
                            "amount": amount,
                            "mrp": mrp,
                            "discount": discount,
                            "discount_rate": discount_rate,
                            "comments": comments,
                            # "tax_percent": product_variant.tax_percent,
                        }
                        batch_items.append(obj)

                        # to check stock availability
                        obj2 = {
                            "quantity": qty,
                            "batch": batch,
                            "product_variant": product_variant,
                            "amount": amount,
                            "mrp": mrp,
                            "discount": discount,
                            "discount_rate": discount_rate,
                        }
                        if not batch:
                            response_data = {
                                "status": "false",
                                "stable": "true",
                                "title": "Form validation error",
                                "message": f"Please select a batch before submitting"
                            }

                            return HttpResponse(json.dumps(response_data), content_type='application/javascript')


                        if batch:
                            if str(batch.pk) in stock_items:
                                stock_items[str(batch.pk)]['quantity'] += qty
                            else:
                                stock_items[str(batch.pk)] = obj2
                        else:
                            if str(product_variant.pk) in stock_items:
                                stock_items[str(product_variant.pk)]['quantity'] += qty
                            else:
                                stock_items[str(product_variant.pk)] = obj2
                if len(batch_items)==0:
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": "Form validation error",
                        "message": f"No sale items"
                    }

                    return HttpResponse(json.dumps(response_data), content_type='application/javascript')
                for key, value in stock_items.items():
                    batch = value['batch']

                    product_variant = value['product_variant']
                    name = str(product_variant)

                    prev_quantity = 0
                    if previous_sale_items.filter(batch=batch, product_variant=product_variant).exists():
                        prev_quantity = previous_sale_items.filter(batch=batch, product_variant=product_variant).aggregate(Sum('quantity'))['quantity__sum']

                    quantity = value['quantity']
                    if batch:
                        stock = batch.stock + prev_quantity
                    elif product_variant.is_special_variant:
                        stock = product_variant.total_stock() + prev_quantity

                    if quantity > stock:
                        stock_ok = False
                        error_message += f"{name} has only {stock} in stock in batch {batch}, You entered {quantity} quantity\n"

                if stock_ok:
                    old_balance = old_total_amount - old_paid
                    current_balance = old_customer.current_balance
                    o_balance = current_balance + old_balance

                    Customer.objects.filter(pk=old_customer.pk).update(current_balance=o_balance)

                    sale_date = datetime.datetime.combine(sale_date, datetime.datetime.now().time())

                    # update sale
                    data = form.save(commit=False)
                    data.updater = request.user
                    data.is_updated = True

                    data.total = 0
                    data.subtotal = 0
                    data.sale_id = sale_id
                    data.discount = net_discount
                    data.date_updated = datetime.datetime.now()
                    data.save()

                    # delete previous items and update stock
                    for p in previous_sale_items:
                        quantity, product_variant = p.quantity, p.product_variant

                        if product_variant.is_special_variant:
                            variants = product_variant.special_variant_added.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=old_warehouse, is_deleted=False).order_by('expire_date')

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                                if len(variant_stocks) > 0:
                                    variant_stock = variant_stocks.first().stock
                                    stock_pk = variant_stocks.first().pk
                                    Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)

                        elif batch:
                            Batch.objects.filter(pk=p.batch.pk).update(stock=F('stock') + quantity)

                        # Returning VendorCommission
                        if p.commission_amount > 0:
                            return_commission(data.sale_date, p.product_variant.product.vendor, p.commission_amount)

                        if p.product_variant:
                            p.product_variant.stock = p.product_variant.total_stock()
                            p.product_variant.save()

                    previous_sale_items.delete()

                    # Privilege Point Returned
                    customer = instance.customer
                    sale_privilege_point = instance.privilege_points
                    cur_point = customer.current_privilege_points - sale_privilege_point
                    customer.current_privilege_points = cur_point
                    sale_prev_point = customer.privilege_points - sale_privilege_point
                    customer.privilege_points = sale_prev_point
                    customer.save()

                    discount = all_tax_total = 0

                    # save items
                    for value in batch_items:
                        mrp = value["mrp"]
                        batch = value['batch']
                        qty = value["quantity"]
                        amount = value["amount"]
                        comments = value["comments"]
                        # tax_percent = value['tax_percent']
                        discount_amount = value["discount"]
                        product_variant = value["product_variant"]

                        cost = product_variant.cost if product_variant.is_special_variant else batch.cost

                        total_cost = cost * qty
                        total_amount = amount * qty
                        total_mrp_amount = mrp * qty

                        if customer.state == 'Kerala':
                            cgst_rate = product_variant.product.hsn.cgst_rate
                            sgst_rate = product_variant.product.hsn.sgst_rate
                            igst_rate = 0
                            tax_percent = cgst_rate + sgst_rate + igst_rate
                            taxable_amount = round(total_amount / (1 + (tax_percent / 100)), 2)
                            purchase_taxable_amount = round(total_cost / (1+(tax_percent/100)), 2)

                            tax_amount = total_amount - taxable_amount
                            all_tax_total += tax_amount
                            cgst_amount = round((taxable_amount * cgst_rate/100), 2)
                            sgst_amount = round((taxable_amount * sgst_rate/100), 2)
                            igst_amount = 0
                        else:
                            igst_rate = product_variant.product.hsn.igst_rate
                            cgst_rate = 0
                            sgst_rate = 0
                            tax_percent = cgst_rate + sgst_rate + igst_rate
                            taxable_amount = round(total_amount / (1 + (tax_percent / 100)), 2)
                            purchase_taxable_amount = round(total_cost / (1+(tax_percent/100)), 2)
                            tax_amount = total_amount - taxable_amount
                            all_tax_total += tax_amount
                            igst_amount = round((taxable_amount * igst_rate/100), 2)
                            cgst_amount = 0
                            sgst_amount = 0

                        SaleItem.objects.create(
                            product_variant=product_variant,
                            batch=batch,
                            sale=data,

                            quantity=qty,
                            amount=amount,
                            mrp=mrp,

                            # tax_percent=tax_percent,
                            # tax_amount=tax_amount,
                            igst_rate=igst_rate,
                            cgst_rate=cgst_rate,
                            sgst_rate=sgst_rate,
                            igst_amount=igst_amount,
                            cgst_amount=cgst_amount,
                            sgst_amount=sgst_amount,
                            discount=discount_amount,
                            comments=comments,
                            commission_amount=0,

                            sub_total=taxable_amount,
                            net_rate=total_mrp_amount,
                            total=total_amount,

                            sale_taxable_amount=taxable_amount,
                            purchase_taxable_amount=purchase_taxable_amount,
                        )

                        if product_variant.is_special_variant:
                            special_variant = product_variant.special_variant_added
                            variants = special_variant.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, stock__gt=0, is_deleted=False).order_by('expire_date')
                            total_qty = qty

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                                total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                                if variant_stocks.filter(stock__gte=total_qty).exists():
                                    variant_stock = variant_stocks.filter(stock__gte=total_qty).first().stock
                                    pk = variant_stocks.filter(stock__gte=total_qty).first().pk

                                    if variant_stock > total_qty:
                                        Batch.objects.filter(pk=pk).update(stock=variant_stock - total_qty)

                                elif total_stock > total_qty:
                                    for batch_item in variant_stocks:
                                        if batch_item.stock >= total_qty:
                                            batch_item.stock = batch_item.stock - total_qty
                                            batch_item.save()
                                            break
                                        elif batch_item.stock < total_qty:
                                            total_qty -= batch_item.stock
                                            batch_item.stock = 0
                                            batch_item.save()
                                print(variant_obj.total_stock(), 'total stock of special variant')

                        elif batch:
                            update_batch_stock(batch.pk, qty, "decrease")

                     # PrivilegePoint Start
                    privi_minimum_amount = 0
                    privilege_point_instance = PrivilegePoint.objects.filter(is_deleted=False).first()

                    if privilege_point_instance:
                        privi_minimum_amount = privilege_point_instance.minimum_amount

                    if use_privilege_point:
                        # privilege_point_used
                        used_amnt =  privilege_point_used * privilege_point_instance.value_of_point
                        total_sale_amount = total_sale_amount - used_amnt
                        curent_point = customer.current_privilege_points - privilege_point_used

                        Customer.objects.filter(pk=customer.pk).update(current_privilege_points=curent_point)

                    # Gaining Privilege Point
                    if privilege_point_instance and customer.name != 'Default Customer':
                        if total_sale_amount >= privi_minimum_amount:
                            gained_point = total_sale_amount/privi_minimum_amount*privilege_point_instance.point_gained_offline
                            cust_current_privilege_points = customer.privilege_points + gained_point
                            cust_privilege_points = customer.privilege_points + gained_point
                            Customer.objects.filter(pk=customer.pk).update(privilege_points=cust_privilege_points, current_privilege_points=cust_current_privilege_points)
                            data.privilege_points = gained_point

                    data.subtotal = subtotalamount
                    data.total = total_sale_amount
                    data.sale_date = sale_date

                    sale_items_data = SaleItem.objects.filter(sale=data).annotate(
                        s_taxable=F('sale_taxable_amount')*F('quantity'),
                        p_taxable=F('purchase_taxable_amount')*F('quantity')
                    )

                    # data.tax_amount = sale_items_data.aggregate(Sum('tax_amount'))['tax_amount__sum']
                    data.igst_amount = sale_items_data.aggregate(Sum('igst_amount'))['igst_amount__sum']
                    data.cgst_amount = sale_items_data.aggregate(Sum('cgst_amount'))['cgst_amount__sum']
                    data.sgst_amount = sale_items_data.aggregate(Sum('sgst_amount'))['sgst_amount__sum']

                    data.sale_taxable_amount = sale_items_data.aggregate(Sum('s_taxable'))['s_taxable__sum']
                    data.purchase_taxable_amount = sale_items_data.aggregate(Sum('p_taxable'))['p_taxable__sum']

                    data.save()
                    total_amount = total_sale_amount
                    balance = total_amount - paid
                    current_balance = customer.current_balance
                    n_balance = current_balance - balance
                    Customer.objects.filter(pk=customer.pk).update(current_balance=n_balance)

                    # Finance
                    transfer_type = voucher_form.cleaned_data['transfer_type']
                    voucher_date = data.sale_date
                    payment_method = 'credit'

                    if voucher_instance:
                        if transfer_type == 10:
                            payment_method = 'cash'
                            ReceiptVoucher.objects.filter(pk=voucher_instance.pk).update(
                                voucher_date = voucher_date,
                                description = "Sale creation Updated",
                                amount = paid,
                                updater=request.user,
                                date_updated = datetime.datetime.now(),
                                transfer_type = transfer_type,

                                bank = None,
                                draft_number = None,
                                draft_date = None,
                                cheque_number = None,
                                cheque_date = None,
                                cheque_status = None,
                                transfer_number = None,
                                transfer_date = None,
                            )

                        elif transfer_type in [15, 20, 25]:
                            bank_account = voucher_form.cleaned_data['bank']

                            cheque_number = None
                            cheque_date = None
                            draft_number = None
                            draft_date = None
                            transfer_number = None
                            transfer_date = None

                            if transfer_type == 15:
                                payment_method = 'cheque'
                                cheque_number = voucher_form.cleaned_data['cheque_number']
                                cheque_date = voucher_form.cleaned_data['cheque_date']
                            elif transfer_type == 20:
                                payment_method = 'draft'
                                draft_number = voucher_form.cleaned_data['draft_number']
                                draft_date = voucher_form.cleaned_data['draft_date']
                            elif transfer_type == 25:
                                payment_method = 'bank transfer'
                                transfer_number = voucher_form.cleaned_data['transfer_number']
                                transfer_date = voucher_form.cleaned_data['transfer_date']

                            ReceiptVoucher.objects.filter(pk=voucher_instance.pk).update(
                                voucher_date = voucher_date,
                                description = "Check Out Payment Received Updated",
                                amount = paid,
                                updater=request.user,
                                date_updated = datetime.datetime.now(),
                                transfer_type = transfer_type,

                                bank = bank_account,
                                draft_number = draft_number,
                                draft_date = draft_date,
                                cheque_number = cheque_number,
                                cheque_date = cheque_date,
                                cheque_status = 20,
                                transfer_number = transfer_number,
                                transfer_date = transfer_date,
                                warehouse=data.warehouse,
                                financial_year=financial_year,
                            )

                        elif transfer_type == 30:
                            voucher_instance.is_deleted = True
                            voucher_instance.description = 'Sale payment changed to credit'
                            voucher_instance.save()

                        receipt_voucher = voucher_instance

                    else:
                        receipt_voucher = None

                        if paid > 0:
                            account_head = AccountHead.objects.get(code="sundry_debtor_customer",is_deleted=False)

                            if ReceiptVoucher.objects.all().exists():
                                number = ReceiptVoucher.objects.aggregate(voucher_number=Max('voucher_number')).get('voucher_number')
                                voucher_no = int(number) + 1
                            else:
                                voucher_no = 1

                            transfer_type = voucher_form.cleaned_data['transfer_type']

                            if transfer_type == 10:
                                payment_method = 'cash'
                                receipt_voucher = ReceiptVoucher.objects.create(
                                    creator=request.user,
                                    updater=request.user,
                                    account_head = account_head,
                                    voucher_number = voucher_no,
                                    voucher_date = data.sale_date,
                                    title = "Sale Payment received",
                                    description = "Sale Payment received",
                                    amount = paid,
                                    transfer_type = 10,
                                    sub_ledger = data.pk,
                                    is_system_generated = True,
                                    warehouse=data.warehouse,
                                    financial_year=financial_year,

                                )

                            elif transfer_type in [15, 20, 25]:
                                bank = voucher_form.cleaned_data['bank']
                                draft_number = draft_date = None
                                cheque_number = cheque_date = None
                                transfer_number = transfer_date = None
                                status = 20

                                if transfer_type == 15:
                                    payment_method = 'cheque'
                                    cheque_number = voucher_form.cleaned_data['cheque_number']
                                    cheque_date = voucher_form.cleaned_data['cheque_date']
                                elif transfer_type == 20:
                                    payment_method = 'draft'
                                    draft_number = voucher_form.cleaned_data['draft_number']
                                    draft_date = voucher_form.cleaned_data['draft_date']
                                elif transfer_type == 25:
                                    payment_method = 'bank transfer'
                                    transfer_number = voucher_form.cleaned_data['transfer_number']
                                    transfer_date = voucher_form.cleaned_data['transfer_date']

                                receipt_voucher = ReceiptVoucher.objects.create(
                                    auto_id=get_auto_id(ReceiptVoucher),
                                    creator=request.user,
                                    updater=request.user,
                                    account_head = account_head,
                                    voucher_number = voucher_no,
                                    voucher_date = data.sale_date,
                                    title = "Sale Payment received",
                                    description = "Sale Payment received",
                                    amount = paid,
                                    sub_ledger = customer.pk,
                                    transfer_type = transfer_type,
                                    is_system_generated = True,

                                    bank = bank,
                                    cheque_number = cheque_number,
                                    cheque_date = cheque_date,
                                    cheque_status = status,
                                    draft_number = draft_number,
                                    draft_date = draft_date,
                                    transfer_number = transfer_number,
                                    transfer_date = transfer_date,

                                    financial_year=financial_year,
                                    warehouse=data.warehouse,
                                )

                    data.receipt_voucher = receipt_voucher
                    data.payment_method = payment_method
                    data.save()

                    referer_url = request.POST.get('referer_url')
                    if not referer_url:
                        referer_url = reverse('sales:sales')

                    response_data = {
                        "status": "true",
                        "title": "Successfully Updated",
                        "message": "Sale Successfully Updated.",
                        "redirect": "true",
                        # "redirect_url": reverse('sales:sale', kwargs={'pk': data.pk})
                        "redirect_url": referer_url
                    }
                else:
                    title = "Out of Stock"
                    if not error_message:
                        error_message = title
                    response_data = {
                        "status": "false",
                        "stable": "true",
                        "title": title,
                        "message": error_message
                    }

            else:
                if FinancialYear.objects.filter(is_deleted=False, is_active=True).exists():
                    error_message = "Sale date must be within active financial year."
                elif FinancialYear.objects.filter(is_deleted=False, is_active=False).exists():
                    error_message = "Don't have an active Financial year."
                else:
                    error_message = "Please Add a Financial year."

                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Financial Year error",
                    "message": error_message
                }
        else:
            print(sale_item_formset.errors)
            message = generate_form_errors(form, formset=False)
            message += generate_form_errors(sale_item_formset, formset=True)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": message
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = SaleForm(instance=instance)
        sale_item_formset = SaleItemFormset(prefix='sale_item_formset', instance=instance)
        previous_sale_items = SaleItem.objects.filter(sale=instance)

        for form_item in sale_item_formset:
            form_item.fields['batch'].queryset = Batch.objects.none()

        if voucher_instance:
            voucher_initial = {}

            if voucher_instance.transfer_date:
                voucher_initial['transfer_date'] = datetime.datetime.strftime(voucher_instance.transfer_date, '%d/%m/%Y')
            elif voucher_instance.draft_date:
                voucher_initial['draft_date'] = datetime.datetime.strftime(voucher_instance.draft_date, '%d/%m/%Y')
            elif voucher_instance.cheque_date:
                voucher_initial['cheque_date'] = datetime.datetime.strftime(voucher_instance.cheque_date, '%d/%m/%Y')

            voucher_form = SaleVoucherForm(instance=voucher_instance, initial=voucher_initial)
        else:
            voucher_form = SaleVoucherForm(initial={'transfer_type': 30})

        try:
            http_referer = request.META['HTTP_REFERER']
        except:
            http_referer = reverse('sales:sale', kwargs={'pk': pk})

        context = {
            "form": form,
            'sale_id': sale_id,
            "instance": instance,
            "voucher_form": voucher_form,
            "sale_item_formset": sale_item_formset,
            'referer_url': http_referer,
            "title": "Edit Sale #: " + str(instance.auto_id),
            "url": reverse('sales:edit', kwargs={'pk': instance.pk}),

            "is_edit": True,
            "redirect": True,
            "carousel_not_required": True,
            "data_table_not_required": True,
        }

        return render(request, 'sales/entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def sale(request, pk):
    instance = get_object_or_404(Sale.objects.filter(pk=pk))
    sale_items = SaleItem.objects.filter(sale=instance)

    sale_items = sale_items.annotate(
        s_taxable=F('sale_taxable_amount'),
        p_taxable=F('purchase_taxable_amount'),
        profit=F('sale_taxable_amount') - F('purchase_taxable_amount'),
        profit_percentage=(F('profit') / F('total')) * 100
    )

    context = {
        "instance": instance,
        "title": "Sale : " + str(instance.sale_id),
        "voucher_instance": None,
        "sale_items": sale_items,
    }

    return render(request, 'sales/sale.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def sales(request):
    title = 'Total Number of Sales'
    filter_data = {}

    instances = Sale.objects.filter().order_by('-a_id')

    query = request.GET.get('q')
    on_date = request.GET.get('on_date')
    to_date = request.GET.get('to_date')
    from_date = request.GET.get('from_date')
    invoice_id = request.GET.get('invoice_id')
    customer_id = request.GET.get('customer')
    view_option = request.GET.get('view')
    payment_method = request.GET.get('payment_method')
    # to_query = request.GET.get('t')
    # print(to_query)

    if customer_id:
        instances = instances.filter(customer_id=customer_id)

    if view_option == 'active':
        filter_data['view'] = 'active'
        instances = instances.filter(is_deleted=False)
    elif view_option == 'cancelled':
        filter_data['view'] = 'cancelled'
        instances = instances.filter(is_deleted=True)
    else:
        filter_data['view'] = 'all'

    if query:
        temp_instances = instances

        instances = instances.filter(
            Q(sale_id__istartswith=query) |
            Q(tracking_id__istartswith=query) |
            Q(customer__name__icontains=query) |
            Q(customer__phone__icontains=query) |
            Q(customer__email__icontains=query)
        )
        try:
            instances |= temp_instances.filter(total=query)
        except:
            pass
        filter_data['query'] = query

    if from_date and to_date:
        print(from_date)
        f_date = datetime.datetime.strptime(from_date, '%Y-%m-%d').date()
        t_date = datetime.datetime.strptime(to_date, '%Y-%m-%d').date()
        instances = instances.filter(sale_date__date__range=[f_date, t_date])
        title = 'Total Number of Sales (from %s to %s)' % (
            str(f_date), str(t_date))

        filter_data['from_date'] = from_date
        filter_data['to_date'] = to_date

    if on_date:
        o_date = datetime.datetime.strptime(on_date, '%Y-%m-%d').date()
        instances = instances.filter(sale_date__date=on_date)
        title = 'Total Number of Sales (On %s)' % (str(o_date))
        filter_data['on_date'] = on_date

    if invoice_id:
        instances = instances.filter(Q(sale_id__istartswith=invoice_id))
        filter_data['invoice_id'] = invoice_id

    count = instances.count()

    context = {
        'count': count,
        'filter_data': filter_data,
        "title": 'Sales',
        'on_date': on_date,
        'to_date': to_date,
        'sub_title': title,
        'from_date': from_date,
        "instances": instances,
        "confirm_reject_message": "Are you sure to reject this Sale.",
        "confirm_approve_message": "Are you sure to approve this Sale.",
    }

    return render(request, 'sales/sales.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(Sale.objects.filter(pk=pk))
    # update stock
    sale_items = SaleItem.objects.filter(sale=instance)

    for p in sale_items:
        quantity = p.quantity
        product_variant = p.product_variant

        if p.batch:
            Batch.objects.filter(pk=p.batch.pk).update(
                stock=F('stock') + quantity
            )

            if product_variant:
                product_variant.stock = product_variant.total_stock()
                product_variant.save()

        elif product_variant.is_special_variant:
            variants = product_variant.special_variant_added.product_variant.all()
            special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=instance.warehouse, is_deleted=False).order_by('expire_date')

            for variant_obj in variants:
                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                if len(variant_stocks) > 0:
                    variant_stock = variant_stocks.first().stock
                    stock_pk = variant_stocks.first().pk
                    Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)

    # privilege_point
    customer = instance.customer
    sale_privilege_point = instance.privilege_points
    customer.current_privilege_points -=sale_privilege_point
    customer.privilege_points -=sale_privilege_point
    customer.save()

    instance.deleted_reason = reason
    instance.is_deleted = True
    instance.date_updated = datetime.datetime.now()
    instance.save()

    receipt = instance.receipt_voucher
    if receipt:
        receipt.is_deleted = True
        receipt.deleted_reason = reason
        receipt.save()

    balance = instance.total - instance.paid

    paid = instance.paid
    total_amount = instance.subtotal

    response_data = {
        "status": "true",
        "title": "Successfully Cancelled",
        "message": "Sale Successfully Cancelled.",
        "redirect": "true",
        "redirect_url": reverse('sales:sales')
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_selected_sales(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                Sale.objects.filter(pk=pk, is_deleted=False))
            instance.is_deleted = True
            instance.date_updated = datetime.datetime.now()
            instance.save()

        response_data = {
            "status": "true",
            "title": "Successfully Cancelled",
            "message": "Selected Sale(s) Successfully Cancelled.",
            "redirect": "true",
            "redirect_url": reverse('sales:sales')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_product_variant_data(request):
    pk = request.GET.get('id')
    barcode = request.GET.get('barcode')
    batch_id = request.GET.get('batch_id')
    warehouse = request.GET.get('warehouse')
    is_purchase = request.GET.get('is_purchase')

    product_variant_exists = False

    if warehouse:
        igst = ''
        cgst = ''
        sgst = ''
        if barcode == "yes":
            if ProductVariant.objects.filter(is_deleted=False, product_code__iexact=pk).exists():
                item = ProductVariant.objects.get(is_deleted=False, product_code__iexact=pk)
                igst = item.product.hsn.igst_rate
                cgst = item.product.hsn.cgst_rate
                sgst = item.product.hsn.sgst_rate
                all_batches = Batch.objects.filter(warehouse=warehouse, product_variant=item, is_deleted=False)
                product_variant_exists = True
        else:
            if ProductVariant.objects.filter(is_deleted=False, pk=pk).exists():
                item = ProductVariant.objects.get(is_deleted=False, pk=pk)
                igst = item.product.hsn.igst_rate
                cgst = item.product.hsn.cgst_rate
                sgst = item.product.hsn.sgst_rate
                all_batches = Batch.objects.filter(warehouse=warehouse, product_variant=item, is_deleted=False)
                product_variant_exists = True

        if product_variant_exists:
            if is_purchase == 'yes':
                batches = all_batches
            else:
                batches = all_batches.filter(stock__gt=0)

                if batch_id and batch_id not in ['', 'None']:
                    if not batches.filter(pk=batch_id).exists():
                        batches |= all_batches.filter(pk=batch_id)

            last_purchase_cost = 0
            batch_list = []
            default_batch = {}

            if batches.exists():
                batch_list = list(batches.annotate(text=F('batch_number')).values(
                    'pk', 'stock', 'retail_price', 'whole_sale_price', 'cost', 'mrp', 'text'
                ))

                if batches.filter(batch_number='0DEFLT').exists():
                    bat = batches.filter(batch_number='0DEFLT').first()
                    default_batch = {
                        'pk': str(bat.pk),
                        'stock': str(bat.stock),
                        'retail_price': str(bat.retail_price),
                        'whole_sale_price': str(bat.whole_sale_price),
                        'cost': str(bat.cost),
                        'mrp': str(bat.mrp),
                        'text': str(bat),
                    }
                elif batches.count() == 1:
                    default_batch = batch_list[0]

            response_data = {
                'status': 'true',

                'pk': str(item.pk),
                'name': str(item),
                'product_code': item.product_code,
                'unit': str(item.unit),

                'mrp': str(item.mrp),
                'retail_price': str(item.retail_price),
                'whole_sale_price': str(item.whole_sale_price),
                'cost': str(item.cost),
                'last_cost': str(last_purchase_cost),
                'igst': str(igst),
                'sgst': str(sgst),
                'cgst': str(cgst),
                # 'tax_percent': str(item.tax_percent),
                'discount_limit': str(item.discount_limit),
                'stock': str(0),
                'batch_list': batch_list,
                'default_batch': default_batch,
                'is_special': item.is_special_variant,
            }

        else:
            response_data = {
                'status': 'false',
                'message': "Not exist",
            }

    else:
        response_data = {
            'status': 'false',
            'message': "Please Select Warehouse",
        }

    return JsonResponse(response_data)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_sale_items(request):
    pk = request.GET.get('id')
    template_name = 'sales/includes/sale_items.html'
    sale = Sale.objects.get(pk=pk)
    instances = SaleItem.objects.filter(sale__pk=pk)

    if instances:
        context = {
            'sale_items': instances,
        }
        html_content = render_to_string(template_name, context)

        response_data = {
            "status": "true",

            'total_amount': str(sale.total),
            'sub_total_amount': str(sale.subtotal),
            'special_discount': str(sale.discount),

            'template': html_content,
            'customer': str(sale.customer.pk),
            'customer_name': str(sale.customer.name)
        }
    else:
        response_data = {
            "status": "false",
            "message": "Product not found"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_customer(request):
    pk = request.GET.get('id')
    instance = Sale.objects.get(pk=pk, is_deleted=False)

    debit = 0
    credit = 0
    if instance.customer.opening_type == "debit":
        debit = instance.customer.opening_balance
        credit = 0
    if instance.customer.opening_type == "credit":
        credit = instance.customer.opening_balance
        debit = 0

    if instance.customer:
        response_data = {
            "status": "true",
            'credit': float(credit),
            'debit': float(debit),
        }
    else:
        response_data = {
            "status": "false",
            "message": "Credit Error"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_sale_return(request):
    if request.method == "POST":
        ModifiedRequest = get_date_updated_request(
            request.POST.copy(), ['time'])
        response_data = {}
        form = SaleReturnForm(ModifiedRequest)

        if form.is_valid():
            message = ""
            is_ok = True
            print("products", products)
            qtys = request.POST.getlist('returned_qty')
            status = request.POST.getlist('status')
            sale = form.cleaned_data['sale']
            date = form.cleaned_data['time']

            returnable_amount = form.cleaned_data['returnable_amount']

            items = zip(products, qtys, status)
            returned_items = []

            for item in items:
                product_pk = item[0]
                try:
                    product_instance = Product.objects.get(pk=product_pk)

                except:
                    product_instance = None
                    message += "Invalid product selection"
                    is_ok = False
                unit_pk = item[0]

                qty = item[1]
                status = item[2]

                if SaleItem.objects.filter(sale=sale, product=product_instance).exists():
                    sale_item = SaleItem.objects.get(
                        sale=sale, product=product_instance)
                    qty2 = Decimal(qty) + sale_item.return_qty
                    sale_qty = sale_item.quantity - Decimal(qty2)

                    if sale_item.quantity >= Decimal(qty2):
                        pr_ins = {
                            "product": product_instance,
                            "qty": qty,
                            "price": sale_item.amount,
                            "sale_item_quantity": sale_item.quantity,
                            "status": status,
                            "sale_item_return_quantity": sale_qty
                        }
                        returned_items.append(pr_ins)

                    else:
                        print("else")
                        message += "Quantity is greater than sold quantity."
                        is_ok = False
                else:
                    message += "Product with this unit is not in this sale. Please don't edit hidden values."
                    is_ok = False

            error_messages = ""
            title = ""

            if is_ok:
                amount_returned = form.cleaned_data['amount_returned']
                customer = sale.customer
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                # data.time = datetime.now()
                data.a_id = get_a_id(SaleReturn, request)
                data.auto_id = get_auto_id(SaleReturn)
                data.sale = sale
                data.amount_returned = amount_returned
                data.customer = customer
                data.save()

                total_tax = 0
                total_taxable_amount = 0
                # Save Sale Return Item
                for f in returned_items:
                    product = f['product']
                    print("product",product)
                    qty = f['qty']
                    status = f['status']
                    # exact_qty = Decimal(get_exact_qty(qty))
                    exact_qty = qty

                    price = f['price']
                    cost = product.cost
                    # discount = f['sale_item_discount']
                    sale_item_quantity = f['sale_item_quantity']
                    # item_discount = ((Decimal(discount)/Decimal(sale_item_quantity))*Decimal(qty))
                    price = Decimal(price)
                    tax_amount1 = (Decimal(price) * Decimal(product.gst)/100)
                    total_tax += tax_amount1*Decimal(qty)
                    total_taxable_amount += price*Decimal(qty)
                    tax_added_price = Decimal(
                        price) + (Decimal(price) * Decimal(product.gst)/100)
                    SaleReturnItem(
                        sale_return=data,
                        product=product,
                        qty=qty,
                        price=tax_added_price,
                        cost=cost,
                        status=status
                    ).save()

                    sale_item = SaleItem.objects.get(
                        sale=sale, product=product)
                    # returnable_amount += (tax_added_price*Decimal(qty))
                    returned_sale_items = SaleItem.objects.filter(sale=sale)

                    for item in returned_sale_items:
                        if item.product == product:
                            quantity = Decimal(qty)
                            saleitem_return_qty = SaleItem.objects.get(
                                sale=sale, product=product)

                            retuned_item_quantity = saleitem_return_qty.return_qty
                            if not retuned_item_quantity:
                                retuned_item_quantity = 0

                            retuned_item_quantity += quantity
                            sale_return_amount = saleitem_return_qty.sub_total

                            SaleItem.objects.filter(sale=sale, product=product).update(
                                return_qty=retuned_item_quantity)

                    if status == 'returnable':
                        exact_qty = Decimal(exact_qty)
                        if sale_item.batch:
                            update_batch_stock(
                                sale_item.batch.pk, qty, "increase")

                data.returnable_amount = returnable_amount
                data.save()
                transaction_mode = ''

                response_data['status'] = 'true'
                response_data['title'] = "Successfully Created"
                response_data['redirect'] = 'true'
                response_data['redirect_url'] = reverse(
                    'sales:sale_return', kwargs={'pk': data.pk})
                response_data['message'] = "Sale Return Successfully Created."
            else:
                response_data['status'] = 'false'
                response_data['title'] = "Error in input values"
                response_data['stable'] = "true"
                response_data['message'] = message
        else:
            response_data['status'] = 'false'
            response_data['stable'] = 'true'
            response_data['title'] = "Form validation error"

            message = ''
            print(form.errors)
            print('form')
            message += str(generate_form_errors(form, formset=False))
            response_data['message'] = str(message)

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = SaleReturnForm()

        context = {
            "form": form,
            "title": "Create Sale Return",
            "redirect": True,

            "is_create_page": True
        }

        return render(request, 'sales/returns/create_sale_return.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_sale_return_new(request):
    if request.method == "POST":
        ModifiedRequest = get_date_updated_request(
            request.POST.copy(), ['time'])
        form = SaleReturnForm(ModifiedRequest)

        if form.is_valid():
            message = ""
            is_ok = True
            response_data = {}
            amount_returned = 0

            # Get the return items
            sale_item_pk = request.POST.getlist('sale_item_pk')
            qtys = request.POST.getlist('returned_qty')
            status = request.POST.getlist('status')
            sale = form.cleaned_data['sale']
            print(qtys, status, sale_item_pk)

            # Set using values
            items = zip(sale_item_pk, qtys, status)
            returned_items = []

            for item in items:
                product_pk = item[0]

                try:
                    sale_item_instance = SaleItem.objects.get(pk=product_pk)
                    print("sale_item", sale_item_instance)
                    qty = Decimal(item[1])
                    print('qty',qty)
                    status = item[2]
                    if sale_item_instance.quantity >= qty and sale_item_instance.return_qty < sale_item_instance.quantity:

                        if sale_item_instance.product_variant:
                            product_variant = sale_item_instance.product_variant
                            pr_ins = {
                                "product": product_variant.product.pk,
                                "product_variant": product_variant.pk,
                                "qty": qty,
                                "price": sale_item_instance.amount,
                                "sale_item_quantity": sale_item_instance.quantity,
                                "status": status,
                                "sale_item_return_quantity": qty,
                                "is_varient": True,
                                "batch": sale_item_instance.batch.pk,
                                "sale_item_instance": sale_item_instance,
                            }
                        # else:
                        #     product = sale_item_instance.product
                        #     pr_ins = {
                        #         "product": product.pk,
                        #         "qty": qty,
                        #         "price": sale_item_instance.amount,
                        #         "sale_item_quantity": sale_item_instance.quantity,
                        #         "status": status,
                        #         "sale_item_return_quantity": qty,
                        #         "is_varient": False,
                        #         "batch": sale_item_instance.batch.pk,
                        #         "sale_item_instance": sale_item_instance,
                        #     }

                        returned_items.append(pr_ins)

                    else:
                        message += "Quantity is greater than sold quantity."
                        is_ok = False

                except:
                    sale_item_instance = None
                    message += "Invalid sale selection"
                    is_ok = False

                # Save Sale Return Item

            if is_ok:
                customer = sale.customer
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.warehouse = sale.warehouse
                data.a_id = get_a_id(SaleReturn, sale.warehouse)
                data.auto_id = get_auto_id(SaleReturn)
                data.sale = sale
                data.customer = customer
                data.amount_returned = amount_returned
                data.save()

                for f in returned_items:
                    qty = f['qty']
                    status = f['status']
                    price = f['price']
                    sale_item_quantity = f['sale_item_quantity']
                    sale_item_return_quantity = f['sale_item_return_quantity']
                    is_varient = f['is_varient']

                    if is_varient:
                        SaleReturnItem(
                            product_id=f["product"],
                            product_variant_id=f["product_variant"],
                            batch_id=f["batch"],
                            sale_return=data,
                            qty=qty,
                            price=price,
                            cost=0,
                            status=status,
                            sale_item=f['sale_item_instance']
                        ).save()

                    # else:
                    #     SaleReturnItem(
                    #         product_id=f["product"],
                    #         batch_id=f["batch"],
                    #         sale_return=data,
                    #         qty=qty,
                    #         price=price,
                    #         cost=0,
                    #         status=status,
                    #         sale_item=f['sale_item_instance']
                    #     ).save()

                    if status == 'returnable':
                        update_batch_stock(
                            f['batch'], sale_item_return_quantity, "increase")

                    f['sale_item_instance'].return_qty += qty
                    f['sale_item_instance'].save()
                    amount_returned += price * sale_item_return_quantity

                data.amount_returned = amount_returned
                data.save()

                response_data['status'] = 'true'
                response_data['title'] = "Successfully Created"
                response_data['redirect'] = 'true'
                response_data['redirect_url'] = reverse(
                    'sales:sale_return', kwargs={'pk': data.pk})
                response_data['message'] = "Sale Return Successfully Created."
            else:
                response_data = {
                    'status': 'false',
                    'title': "Error in input values",
                    'stable': "true",
                    'message': message,
                }
        else:
            response_data = {
                'status': 'false',
                'stable': 'true',
                'title': "Form validation error",
            }

            message = ''
            print(form.errors)
            message += str(generate_form_errors(form, formset=False))
            response_data['message'] = str(message)

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = SaleReturnForm()

        context = {
            "form": form,
            "title": "Create Sale Return",
            "redirect": True,

            "is_create_page": True
        }

        return render(request, 'sales/returns/create_sale_return.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_sale_return(request, pk):
    instance = get_object_or_404(
        SaleReturn.objects.filter(pk=pk, is_deleted=False))
    sale_return_items = SaleReturnItem.objects.filter(sale_return_id=pk)

    if request.method == "POST":
        response_data = {}
        amount_returned = 0
        ModifiedRequest = get_date_updated_request(
            request.POST.copy(), ['time'])
        form = SaleReturnForm(ModifiedRequest, instance=instance)

        if form.is_valid():
            message = ""
            is_ok = True

            # Get the return items
            sale_item_pk = request.POST.getlist('sale_item_pk')
            qtys = request.POST.getlist('returned_qty')
            status = request.POST.getlist('status')
            sale = form.cleaned_data['sale']

            # Set using values
            items = zip(sale_item_pk, qtys, status)
            returned_items = []

            for item in items:
                product_pk = item[0]

                try:
                    sale_item_instance = SaleItem.objects.get(pk=product_pk)
                    qty = Decimal(item[1])
                    status = item[2]

                    if sale_item_instance.quantity >= qty and sale_item_instance.return_qty < sale_item_instance.quantity:

                        if sale_item_instance.product_variant:
                            product_variant = sale_item_instance.product_variant
                            pr_ins = {
                                "product": sale_item_instance.product.pk,
                                "product_variant": product_variant.pk,
                                "qty": qty,
                                "price": sale_item_instance.amount,
                                "sale_item_quantity": sale_item_instance.quantity,
                                "status": status,
                                "sale_item_return_quantity": qty,
                                "is_varient": True,
                                "batch": sale_item_instance.batch.pk,
                                "sale_item_instance": sale_item_instance,
                            }

                        else:
                            product = sale_item_instance.product
                            pr_ins = {
                                "product": product.pk,
                                "qty": qty,
                                "price": sale_item_instance.amount,
                                "sale_item_quantity": sale_item_instance.quantity,
                                "status": status,
                                "sale_item_return_quantity": qty,
                                "is_varient": False,
                                "batch": sale_item_instance.batch.pk,
                                "sale_item_instance": sale_item_instance,
                            }

                        returned_items.append(pr_ins)

                    else:
                        message += "Quantity is greater than sold quantity."
                        is_ok = False

                except:
                    sale_item_instance = None
                    message += "Invalid sale selection"
                    is_ok = False

                # Save Sale Return Item

            if is_ok:
                customer = sale.customer
                data = form.save(commit=False)
                data.sale = sale
                data.updater = request.user
                data.customer = customer
                data.is_updated = True
                data.amount_returned = 0
                data.save()

                sale_objs = SaleReturnItem.objects.filter(sale_return=instance)
                for sale_obj in sale_objs:
                    update_batch_stock(
                        sale_obj.sale_item.batch.pk, sale_obj.qty, "decrease")
                    sale_obj.sale_item.return_qty -= qty
                    sale_obj.sale_item.save()
                    sale_obj.delete()

                for f in returned_items:
                    qty = f['qty']
                    status = f['status']
                    price = f['price']
                    sale_item_quantity = f['sale_item_quantity']
                    sale_item_return_quantity = f['sale_item_return_quantity']
                    is_varient = f['is_varient']

                    amount_returned += price * sale_item_return_quantity

                    if is_varient:
                        SaleReturnItem.objects.create(
                            product_id=f["product"],
                            batch_id=f["batch"],
                            product_variant_id=f["product_variant"],
                            sale_return=data,
                            qty=qty,
                            price=price,
                            cost=0,
                            status=status,
                            sale_item=f['sale_item_instance']
                        )

                        if status == 'returnable':
                            update_batch_stock(
                                f['batch'], sale_item_return_quantity, "increase")
                    else:
                        SaleReturnItem.objects.create(
                            product_id=f["product"],
                            batch_id=f["batch"],
                            sale_return=data,
                            qty=qty,
                            price=price,
                            cost=0,
                            status=status,
                            sale_item=f['sale_item_instance']
                        )

                        if status == 'returnable':
                            update_batch_stock(
                                f['batch'], sale_item_return_quantity, "increase")

                data.amount_returned = amount_returned
                data.save()

                response_data['status'] = 'true'
                response_data['title'] = "Successfully Updated"
                response_data['redirect'] = 'true'
                # response_data['redirect_url'] = reverse('sales:sale_return', kwargs={'pk': data.pk})
                response_data['redirect_url'] = reverse('sales:sale_returns'),
                response_data['message'] = "Sale Return Successfully Updated."
            else:
                response_data['status'] = 'false'
                response_data['title'] = "Error in input values"
                response_data['stable'] = "true"
                response_data['message'] = message
        else:
            response_data['status'] = 'false'
            response_data['stable'] = 'true'
            response_data['title'] = "Form validation error"

            message = ''
            print(form.errors)
            print('form')
            message += str(generate_form_errors(form, formset=False))
            response_data['message'] = str(message)

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = SaleReturnForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Sale Return",
            'return_items': sale_return_items,
            "redirect": True,

            "is_edit": True
        }

        return render(request, 'sales/returns/edit_sale_return.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def sale_returns(request):
    filter_data = {}
    query = request.GET.get('q')
    on_date = request.GET.get('on_date')
    to_date = request.GET.get('to_date')
    from_date = request.GET.get('from_date')

    instances = SaleReturn.objects.all().order_by('-auto_id')

    if query:
        filter_data['query'] = query
        instances = instances.filter(
            Q(auto_id__iexact=query) |
            Q(sale__auto_id__iexact=query) |
            Q(customer__name__icontains=query) |
            Q(customer__phone__icontains=query) |
            Q(customer__email__icontains=query)
        )

    if from_date and to_date:
        f_date = datetime.datetime.strptime(from_date, '%Y-%m-%d').date()
        t_date = datetime.datetime.strptime(to_date, '%Y-%m-%d').date()
        instances = instances.filter(time__date__range=[f_date, t_date])

        filter_data['from_date'] = from_date
        filter_data['to_date'] = to_date

    if on_date:
        o_date = datetime.datetime.strptime(on_date, '%Y-%m-%d').date()
        instances = instances.filter(time__date=o_date)
        filter_data['on_date'] = on_date

    context = {
        "title": "Sale Returns",
        "filter_data": filter_data,
        "instances": instances
    }

    return render(request, 'sales/returns/sale_returns.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def sale_return(request, pk):
    instance = get_object_or_404(SaleReturn.objects.filter(pk=pk))
    sale_items = SaleReturnItem.objects.filter(sale_return=instance)

    context = {
        "title": "Sale Return: " + str(instance.auto_id),
        "instance": instance,
        "sale_items": sale_items
    }

    return render(request, 'sales/returns/sale_return.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_sale_return(request, pk):
    reason = request.GET.get('reason')
    instance = SaleReturn.objects.get(pk=pk)
    instance.deleted_reason = reason
    instance.is_deleted = True
    instance.save()

    return_items = SaleReturnItem.objects.filter(sale_return=instance)

    for p in return_items:
        quantity = p.qty
        p.sale_item.return_qty -= quantity
        p.sale_item.save()
        update_batch_stock(p.sale_item.batch.pk, quantity, "decrease")

    response_data = {
        'status': 'true',
        'title': "Successfully Cancelled",
        'redirect': 'true',
        'redirect_url': reverse('sales:sale_returns'),
        'message': "Sale Return Successfully Cancelled.",
        'id':pk,

    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def print_sale_return(request, pk):
    instance = get_object_or_404(SaleReturn.objects.filter(pk=pk))
    # sale_category = instance.sale_category

    sale_return_items = SaleReturnItem.objects.filter(sale_return=instance)
    total_subtotal = 0
    grant_total = 0
    total_discount = 0

    for return_item in sale_return_items:
        # gst_amount = return_item.gst_amount
        subtotal = return_item.t()
        # gst_added_total = return_item.total
        # discount = return_item.discount
        grant_total += subtotal
        total_subtotal += subtotal

    grant_total_value = grant_total

    context = {
        "title": "Sale Return ",
        "instance": instance,
        "sale_items": sale_return_items,
        "total_subtotal": total_subtotal,
        "grant_total_value": grant_total_value,
    }

    return render(request, 'invoice/print_return.html', context)


@login_required
@ajax_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_sale_returns(request):
    pk = request.GET.get('customer_id')
    if pk:
        customer = get_object_or_404(Customer, pk=pk)
        instances = SaleReturn.objects.filter(customer_id=pk, is_deleted=False)

        if instances:
            data = []
            for item in instances:
                obj = {
                    'return': str(item),
                    'pk': str(item.pk)
                }
                data.append(obj)

            response_data = {
                "status": "true",
                "data": data
            }

        else:
            response_data = {
                "status": "false",
                "message": "Sale returns Not found"
            }

    else:
        response_data = {
            "status": "false",
            "message": "customer data unavailable"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@ajax_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_sale_return_amount(request):
    pk = request.GET.get('id')

    if pk:
        if SaleReturn.objects.filter(pk=pk, is_deleted=False):
            instance = SaleReturn.objects.get(pk=pk, is_deleted=False)

            response_data = {
                "status": "true",

                'total_amount': str(instance.sale.total),
                'sub_total_amount': str(instance.sale.subtotal),
                'special_discount': str(instance.sale.discount),

                "amount": str(instance.amount_returned)
            }

        else:
            response_data = {
                "status": "false",
                "message": "Sale return Not found"
            }

    else:
        response_data = {
            "status": "false",
            "message": "Key unavailable"
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_return_customer(request):
    pk = request.GET.get('id')
    instance = SaleReturn.objects.get(pk=pk)

    response_data = {
        "status": "true",
        'customer': str(instance.customer.pk),
        'customer_name': str(instance.customer.name)
    }
    # else:
    #     response_data = {
    #         "status": "false",
    #         "message": "Product not found"
    #     }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_prefix_sale_id(request):
    pk = request.GET.get('id')
    sale_type = request.GET.get('sale_type')
    prefix = InvoicePrefix.objects.get(pk=pk,is_deleted=False)

    # for generating order id
    if sale_type == 'order':
        sale_no = Orders.objects.filter(is_deleted=False, prefix=prefix).aggregate(Max('order_no')).get('order_no__max', 0) or 0
        sale_no += 1
    else:
        if Sale.objects.filter(sale_prefix=prefix,is_deleted=False).exists():
            sale_no = Sale.objects.filter(sale_prefix=prefix,is_deleted=False).aggregate(Max('sale_no'))['sale_no__max']
            sale_no += 1
        else:
            sale_no = 1

    if sale_type == "sale":
        sale_id = f"{prefix.retail_sale}{str(sale_no).zfill(6)}"
    elif sale_type == "order":
        sale_id = f"{prefix.order}{str(sale_no).zfill(6)}"

    response_data = {
        "status": "true",
        'sale_id': str(sale_id),
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def get_prefix_sale_type(request):
    sale_type = request.GET.get('sale_type')
    # for generating order id
    instance_prefix = InvoicePrefix.objects.filter(is_deleted=False, financial_year__is_active=True)
    data = []

    if sale_type == "b2b" or sale_type == "b2c":
        for prif in instance_prefix:
            dic = {
                'id': str(prif.pk),
                'title': prif.retail_sale,
            }
            data.append(dic)

    elif sale_type == 'order':
        for prif in instance_prefix:
            dic = {
                'id': str(prif.pk),
                'title': prif.order,
            }
            data.append(dic)

    response_data = {
        "status": "true",
        'data': data,
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff_user'])
def print_sale(request, pk):
    instance = get_object_or_404(Sale.objects.filter(pk=pk))
    sale_category = instance.sale_category
    invoice_design = None
    if InvoiceDesign.objects.filter(is_deleted=False,is_active=True):
        invoice_design = InvoiceDesign.objects.filter(is_deleted=False,is_active=True).first()

    sale_items = SaleItem.objects.filter(sale=instance)
    total_tax = 0
    grant_total = 0
    total_subtotal = 0
    total_discount = 0

    for sale_item in sale_items:
        # total_tax += sale_item.tax_amount
        total_tax += sale_item.igst_amount + sale_item.cgst_amount + sale_item.sgst_amount
        grant_total += sale_item.total
        total_discount += sale_item.discount
        total_subtotal += sale_item.sub_total

    # get custoemr's current balance
    head = AccountHead.objects.filter(name='Sundry Debtor', is_deleted=False).last()
    date = datetime.datetime.now().date()

    # data = get_ledger_data(head, date, date, str(instance.customer.pk), 'current balance')
    # balance = data['closing_balance']
    balance = 0
    # if balance > 0:
    #     balance_type = 'Debit'
    # else:
    #     balance_type = 'Credit'
    #     balance = abs(balance)

    context = {
        "title": "Quotation ",
        "instance": instance,
        "sale_items": sale_items,
        "sale_category": sale_category,
        "grant_total_value": grant_total,
        "total_subtotal": total_subtotal,
        "total_discount": total_discount,
        "total_tax": total_tax,
        # "balance_type": balance_type,
        "balance": balance,
        "invoice_design": invoice_design,
    }

    return render(request, 'invoice/print_sale.html', context)


@login_required
@role_required(['superadmin', 'staff_user'])
def print_invoice(request, pk):
    instance = get_object_or_404(Sale.objects.filter(pk=pk))
    state = instance.customer.state
    print("state", state)
    sale_category = instance.sale_category
    invoice_design = None
    if InvoiceDesign.objects.filter(is_deleted=False,is_active=True):
        invoice_design = InvoiceDesign.objects.filter(is_deleted=False,is_active=True).first()

    sale_items = SaleItem.objects.filter(sale=instance)
    total_net_amount = 0
    total_discount = 0
    total_subtotal = 0
    grant_total = 0
    total_cgst_amount = 0
    total_igst_amount = 0
    total_sgst_amount = 0
    total_tax = 0
    total_qty = 0



    for sale_item in sale_items:
        # total_tax += sale_item.tax_amount
        total_tax += sale_item.igst_amount + sale_item.cgst_amount + sale_item.sgst_amount
        grant_total += sale_item.total
        total_discount += sale_item.discount
        total_subtotal += sale_item.sub_total
        total_net_amount += sale_item.net_rate
        total_cgst_amount += sale_item.cgst_amount
        total_igst_amount +=sale_item.igst_amount
        total_sgst_amount += sale_item.sgst_amount
        total_qty += sale_item.quantity
        print("Quantity", sale_item.quantity)
    # get custoemr's current balance
    head = AccountHead.objects.filter(name='Sundry Debtor', is_deleted=False).last()
    date = datetime.datetime.now().date()

    # data = get_ledger_data(head, date, date, str(instance.customer.pk), 'current balance')
    # balance = data['closing_balance']
    balance = 0
    # if balance > 0:
    #     balance_type = 'Debit'
    # else:
    #     balance_type = 'Credit'
    #     balance = abs(balance)

    rows_count = 0 if sale_items.count() > 5 else 5 - sale_items.count()
    is_need_warranty = sale_items.filter(product_variant__warranty__isnull=False).exists()

    context = {
        "title": "Quotation ",
        "instance": instance,
        "sale_items": sale_items,
        "sale_category": sale_category,
        "grant_total_value": grant_total,
        "total_net_amount": total_net_amount,
        "total_subtotal": total_subtotal,
        "total_discount": total_discount,
        "rows_count": range(rows_count),
        "balance": balance,
        "invoice_design": invoice_design,
        "is_need_warranty": is_need_warranty,
        "is_iphone": "iPhone" in request.META["HTTP_USER_AGENT"],
        "total_cgst_amount": total_cgst_amount,
        "total_sgst_amount": total_sgst_amount,
        "total_igst_amount": total_igst_amount,
        "total_qty": total_qty,
    }

    return render(request, 'invoice/print_invoice.html', context)


@login_required
@role_required(['superadmin', 'staff_user'])
def print_credit_invoice(request, pk):
    instance = get_object_or_404(Sale.objects.filter(pk=pk))

    invoice_design = None
    if InvoiceDesign.objects.filter(is_deleted=False,is_active=True):
        invoice_design = InvoiceDesign.objects.filter(is_deleted=False,is_active=True).first()

    sale_items = SaleItem.objects.filter(sale=instance)
    total_net_amount = 0
    total_discount = 0
    total_subtotal = 0
    grant_total = 0
    total_tax = 0
    total_cgst_amount = 0
    total_igst_amount = 0
    total_sgst_amount = 0
    total_qty = 0

    for sale_item in sale_items:
        # total_tax += sale_item.tax_amount
        total_tax += sale_item.igst_amount + sale_item.cgst_amount + sale_item.sgst_amount
        grant_total += sale_item.total
        total_discount += sale_item.discount
        total_subtotal += sale_item.sub_total
        total_net_amount += sale_item.net_rate
        total_cgst_amount += sale_item.cgst_amount
        total_igst_amount +=sale_item.igst_amount
        total_sgst_amount += sale_item.sgst_amount
        total_qty += sale_item.quantity

    rows_count = 0 if sale_items.count() > 5 else 5 - sale_items.count()
    is_need_warranty = sale_items.filter(product_variant__warranty__isnull=False).exists()

    context = {
        "title": "Quotation ",
        "is_credit": True,
        "instance": instance,
        "sale_items": sale_items,
        "grant_total_value": grant_total,
        "total_net_amount": total_net_amount,
        "total_subtotal": total_subtotal,
        "total_discount": total_discount,
        "total_tax": total_tax,
        "rows_count": range(rows_count),
        "invoice_design": invoice_design,
        "is_need_warranty": is_need_warranty,
        "is_iphone": "iPhone" in request.META["HTTP_USER_AGENT"],
        "total_cgst_amount": total_cgst_amount,
        "total_sgst_amount": total_sgst_amount,
        "total_igst_amount": total_igst_amount,
        "total_qty": total_qty,
    }

    return render(request, 'invoice/print_invoice.html', context)


@login_required
def sale_export(request):
    purchase_filter = SaleFilter(request)
    instances = purchase_filter.get_filtered_results()
    print("Instances===>>>",instances)

    export_to_excel_utils = ExportToExcelUtils(instances, SaleExportSerializer, request, "sales_export")
    returned_file_url = export_to_excel_utils.export_to_excel()
    return HttpResponseRedirect(returned_file_url)
