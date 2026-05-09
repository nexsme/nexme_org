import xlwt
import json
import datetime
from decimal import Decimal
from itertools import product
from operator import attrgetter, itemgetter
# third party libraries
from dal import autocomplete
# django libraries
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import formats
from django.conf import settings
from django.urls import reverse
from django.http.response import HttpResponseRedirect, HttpResponse
from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404
from django.db.models import Q, F, Sum, Count, FloatField, ExpressionWrapper
from django.http import JsonResponse
from django.forms.formsets import formset_factory
from django.forms.models import inlineformset_factory
# local libraries
from main.decorators import check_mode, ajax_required
from main.functions import get_auto_id, generate_form_errors, get_date_updated_request
from sales.functions import update_batch_stock
from main.decorators import role_required
from users.functions import get_warehouse
from customers.models import CustomerAddress
from products.models import ProductVariant
from general.models import DamagedProducts, Batch, StockTransfer, StockTransferItem, StockUpdateItem, StockUpdate, InvoiceDesign, DeliveryCharge, ChargeSetting
from general.forms import DamagedProductsForm, StockTransferItemForm, StockTransferForm, StockUpdateForm, StockUpdateItemForm, StockInwardItemEditForm, StockOutWardItemForm, InvoiceDesignForm


@login_required
def create_damaged_product(request):
    if request.method == 'POST':
        ModifiedRequest = get_date_updated_request(request.POST.copy(), ['date'])
        form = DamagedProductsForm(ModifiedRequest)

        if form.is_valid():
            auto_id = get_auto_id(DamagedProducts)
            amount = form.cleaned_data['amount']
            batch = form.cleaned_data['batch']
            quantity = form.cleaned_data['quantity']
            product_variant = form.cleaned_data['product_variant']
            date = form.cleaned_data['date']
            today = datetime.datetime.now(datetime.timezone.utc)
            print("today", today)
            print("date", date)
            if date > today:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Future dates is not allowded"
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')


            error_message = ''
            is_ok = True
            if batch:
                if quantity > batch.stock:
                    is_ok = False
                    error_message += f'Not Enough Stock in batch - {batch}'
            else:
                is_ok = False
                error_message += 'Please choose a batch\n'

            if is_ok:
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = auto_id

                data.product_variant = product_variant
                data.save()

                try:
                    Batch.objects.filter(pk=batch.pk).update(
                        stock=F('stock') - quantity
                    )
                except:
                    print(
                        '-\n-\n-\n-\n-\n-\n stock updation failed at create damaged product\n-\n-\n-\n-\n-\n-')

                if product_variant:
                    product_variant.stock = product_variant.total_stock()
                    product_variant.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Damaged Product created successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('general:damaged_product', kwargs={'pk': data.pk})
                }
            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": message
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        initial = {
            'date': datetime.datetime.strftime(datetime.datetime.now(), '%d/%m/%Y')
        }
        form = DamagedProductsForm(initial=initial)

        form.fields['product_variant'].queryset = ProductVariant.objects.none()
        form.fields['batch'].queryset = Batch.objects.none()

        context = {
            "title": "Create Damaged Product ",
            "form": form,
            "url": reverse('general:create_damaged_product'),
            "redirect": True,
        }
        return render(request, 'general/damaged-products/entry_damaged_product.html', context)


@login_required
def damaged_products(request):
    instances = DamagedProducts.objects.all().order_by("auto_id")
    title = "Damaged Products"
    filter_data = {}
    date_error=""

    query = request.GET.get("q")
    from_date = request.GET.get("from_date")
    to_date = request.GET.get("to_date")

    if from_date and to_date:
        filter_data = {
            'from_date': from_date,
            'to_date': to_date
        }
        from_date = datetime.datetime.strptime(from_date, '%d/%m/%Y')
        to_date = datetime.datetime.strptime(to_date, '%d/%m/%Y')
        if from_date > to_date:
            date_error = "From Date must be before To Date"
        else:
            instances = instances.filter(date__date__range=[from_date, to_date])

    if query:
        title = "Damaged Products - %s" % query
        instances = instances.filter(
            Q(product__name__icontains=query)
        )

    total_amount = instances.aggregate(Sum('amount')).get('amount__sum' or 0)

    context = {
        'title': title,
        "instances": instances,
        'total_amount': total_amount,
        'filter_data': filter_data,
        'date_error': date_error,
    }

    return render(request, 'general/damaged-products/damaged_products.html', context)


@login_required
def damaged_product(request, pk):
    instance = get_object_or_404(DamagedProducts.objects.filter(pk=pk))

    context = {
        "instance": instance,
        "title": "Damaged Product : #" + str(instance.auto_id),
    }

    return render(request, 'general/damaged-products/damaged_product.html', context)


@login_required
def edit_damaged_product(request, pk):
    instance = get_object_or_404(DamagedProducts.objects.filter(pk=pk, is_deleted=False))
    old_batch = instance.batch
    old_quantity = instance.quantity
    error_message = ''

    if request.method == 'POST':
        form = DamagedProductsForm(request.POST, instance=instance)

        if form.is_valid():
            is_ok = True
            batch = form.cleaned_data['batch']
            quantity = form.cleaned_data['quantity']

            if batch == old_batch:
                batch_stock = batch.stock + old_quantity
                if quantity > batch_stock:
                    is_ok = False
                    error_message += f'Not Enough Stock in batch - {batch}'

            else:
                if quantity > batch.stock:
                    is_ok = False
                    error_message += f'Not Enough Stock in batch - {batch}'

            if is_ok:
                # returning old stock to batch
                Batch.objects.filter(pk=old_batch.pk).update(
                    stock=F('stock') + old_quantity
                )

                if old_batch.product_variant:
                    old_batch.product_variant.stock = old_batch.product_variant.total_stock()
                    old_batch.product_variant.save()

                data = form.save(commit=False)
                data.updater = request.user
                data.is_updated = True
                data.date_updated = datetime.datetime.now()
                data.save()

                try:
                    Batch.objects.filter(pk=batch.pk).update(
                        stock=F('stock') - quantity
                    )
                except:
                    print(
                        '-\n-\n-\n-\n-\n-\n stock updation failed at edit damaged product\n-\n-\n-\n-\n-\n-')

                response_data = {
                    "status": "true",
                    "title": "Successfully Updated",
                    "message": "Damaged Product Successfully Updated.",
                    "redirect": "true",
                    "redirect_url": reverse('general:damaged_product', kwargs={'pk': data.pk})
                }
            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

        else:
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": message
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        initial = {
            'date': datetime.datetime.strftime(instance.date, '%d/%m/%Y')
        }

        form = DamagedProductsForm(
            instance=instance, initial=initial)

        form.fields['product_variant'].queryset = ProductVariant.objects.none()
        form.fields['batch'].queryset = Batch.objects.none()

        context = {
            "form": form,
            "title": "Edit Damaged Product : " + str(instance.auto_id),
            "instance": instance,
            "url": reverse('general:edit_damaged_product', kwargs={'pk': instance.pk}),
            "is_edit": True,
        }

        return render(request, 'general/damaged-products/entry_damaged_product.html', context)


@login_required
def delete_damaged_product(request, pk):
    reason = request.GET.get('reason')
    instance = get_object_or_404(
        DamagedProducts.objects.filter(pk=pk, is_deleted=False))
    instance.is_deleted = True
    instance.deleted_reason = reason
    instance.save()

    quantity = instance.quantity

    if instance.batch:
        Batch.objects.filter(pk=instance.batch_id).update(
            stock=F('stock') + quantity
        )

        if instance.product_variant:
            instance.product_variant.stock = instance.product_variant.total_stock()
            instance.product_variant.save()

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Damaged Product Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('general:damaged_products')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_batch_data(request):
    pk = request.GET.get('id')
    sale_type = request.GET.get('sale_type')

    if 'special' in pk:
        variant = ProductVariant.objects.get(pk=pk.split('__')[1])
        igst = variant.product.hsn.igst_rate
        cgst = variant.product.hsn.cgst_rate
        sgst = variant.product.hsn.sgst_rate
        tax_percent = igst + cgst + sgst
        response_data = {
            "status": 'true',
            "is_special": 'true',
            "stock": str(variant.total_stock()),
            "mrp": str(variant.mrp),
            "cost": str(variant.cost),
            "last_cost": str(round(variant.cost/(1+tax_percent/100), 2)),
            "expire_date": str(variant.expire_date),
            "retail_price": str(variant.retail_price),
            "whole_sale_price": str(variant.whole_sale_price),
            "manufacturing_date": str(variant.manufacturing_date),
        }
    elif Batch.objects.filter(pk=pk).exists():
        batch = Batch.objects.get(pk=pk)
        cost = batch.cost
        # if batch.product_variant.tax_percent:
        #     tax_percent = batch.product_variant.tax_percent
        #     taxable_amount_batch = round(cost/(1+tax_percent/100), 2)

        response_data = {
            "status": 'true',
            "is_special": 'false',
            "stock": str(batch.stock),
            "mrp": str(batch.mrp),
            "cost": str(batch.cost),
            # "last_cost": str(taxable_amount_batch),
            "expire_date": str(batch.expire_date),
            "manufacturing_date": str(batch.manufacturing_date),
            "retail_price": str(batch.retail_price),
            "whole_sale_price": str(batch.whole_sale_price),
        }
    else:
        response_data = {
            "status": "false",
            "message": "Batch does not exists."
        }

    return JsonResponse(response_data)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_stock_transfer(request):
    StockTransferItemFormset = formset_factory(StockTransferItemForm, extra=1)

    if request.method == 'POST':
        form = StockTransferForm(request.POST)
        stock_transfer_formset = StockTransferItemFormset(
            request.POST, prefix='stock_transfer_formset', form_kwargs={'empty_permitted': False})

        if form.is_valid() and stock_transfer_formset.is_valid():
            to_warehouse = form.cleaned_data['to_warehouse']
            warehouse = form.cleaned_data['warehouse']

            stock_items = {}  # to check stock availability
            stock_ok = True
            error_message = ''

            for f in stock_transfer_formset:
                if f.cleaned_data != {}:
                    batch = f.cleaned_data['batch']
                    product_variant = f.cleaned_data['product_variant']

                    if batch:
                        product_variant = f.cleaned_data['product_variant']
                        batch = f.cleaned_data['batch']
                        qty = f.cleaned_data['quantity']

                        obj = {
                            'batch': batch,
                            "quantity": qty,
                        }

                        # to check stock availability
                        if str(batch.pk) in stock_items:
                            stock_items[str(batch.pk)]['quantity'] += qty
                        else:
                            stock_items[str(batch.pk)] = obj

                    else:
                        if Batch.objects.filter(is_deleted=False, product_variant=product_variant, warehouse=warehouse, stock__gt=0).exists():
                            error_message = "Please choose a batch before submission."

                        else:
                            name = product_variant.product.name + product_variant.title
                            error_message = f"{name} is out of stock."

                        response_data = {
                            "status": "false",
                            "stable": "true",
                            "title": "Form validation error",
                            "message": error_message
                        }
                        return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            if len(stock_items)==0:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": "Please add a product before submitting "
                }
                return HttpResponse(json.dumps(response_data), content_type='application/javascript')
            for key, value in stock_items.items():
                batch = Batch.objects.get(pk=key)
                product = batch.product
                product_variant = batch.product
                stock = batch.stock
                name = product.name

                quantity = value['quantity']

                if quantity > stock:
                    stock_ok = False
                    error_message += f"{name} has only {stock} quantity in batch {batch}, You entered {quantity} quantity\n"

            if stock_ok:
                auto_id = get_auto_id(StockTransfer)

                # create stock_transfer
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = auto_id

                data.save()

                for i in stock_transfer_formset:
                    stock_transfer_auto_id = get_auto_id(StockTransferItem)

                    if i.cleaned_data != {}:
                        product_variant = i.cleaned_data['product_variant']
                        batch = i.cleaned_data['batch']
                        quantity = i.cleaned_data['quantity']
                        manufacturing_date = i.cleaned_data['manufacturing_date']
                        expire_date = i.cleaned_data['expire_date']
                        mrp = i.cleaned_data['mrp']
                        retail_price = i.cleaned_data['retail_price']
                        whole_sale_price = i.cleaned_data['whole_sale_price']
                        cost = i.cleaned_data['cost']

                        StockTransferItem.objects.create(
                            stock_transfer=data,
                            quantity=quantity,

                            product_variant=product_variant,
                            batch=batch,
                            manufacturing_date=manufacturing_date,
                            expire_date=expire_date,
                            mrp=mrp,
                            cost=cost,
                            retail_price=retail_price,
                            whole_sale_price=whole_sale_price,

                            auto_id=stock_transfer_auto_id,
                            creator=request.user,
                            updater=request.user,
                        )

                        # subtracting stock from from_warehouse
                        update_batch_stock(batch.pk, quantity, "decrease")

                        # adding stock to to_warehouse
                        if Batch.objects.filter(is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse).exists():
                            Batch.objects.filter(is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse).update(
                                stock=F('stock') + quantity,
                                mrp=mrp,
                                cost=cost,
                                retail_price=retail_price,
                                whole_sale_price=whole_sale_price,
                                expire_date=expire_date,
                                manufacturing_date=manufacturing_date,
                            )

                            batch = Batch.objects.get(
                                is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse)

                        else:
                            batch = Batch.objects.create(
                                auto_id=get_auto_id(Batch),
                                creator=request.user,
                                updater=request.user,
                                warehouse=to_warehouse,
                                product_variant=product_variant,
                                product=product_variant.product,

                                stock=quantity,
                                batch_number=batch.batch_number,
                                mrp=mrp,
                                retail_price=retail_price,
                                whole_sale_price=whole_sale_price,
                                cost=cost,
                                expire_date=expire_date,
                                manufacturing_date=manufacturing_date,
                            )

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Stock Transfer Created Successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('general:stock_transfer', kwargs={'pk': data.pk})
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
            message = generate_form_errors(form, formset=False)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = StockTransferForm()
        stock_transfer_formset = StockTransferItemFormset(
            prefix='stock_transfer_formset')

        context = {
            "title": "Create Stock Transfer ",
            "form": form,
            "stock_transfer_formset": stock_transfer_formset,
            "url": reverse('general:create_stock_transfer'),
        }

        return render(request, 'general/stock_transfer/stock_transfer_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def stock_transfers(request):
    instances = StockTransfer.objects.filter(is_deleted=False)
    title = "Stock Transfer"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(name__icontains=query))
        title = "Stock Transfer - %s" % query

    context = {
        "instances": instances,
        'title': title,

    }
    return render(request, 'general/stock_transfer/stock_transfers.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def stock_transfer(request, pk):
    instance = get_object_or_404(StockTransfer, pk=pk)
    stock_transfers = StockTransferItem.objects.filter(stock_transfer=instance, is_deleted=False)

    context = {
        "instance": instance,
        "stock_transfers": stock_transfers,
        "title": "Stock Transfer : " + str(instance.auto_id),
        "single_page": True,

    }
    return render(request, 'general/stock_transfer/stock_transfer.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_stock_transfer(request, pk):
    instance = get_object_or_404(StockTransfer, pk=pk)
    old_stockupdate_items = StockTransferItem.objects.filter(
        stock_transfer_id=pk)

    if StockTransferItem.objects.filter(stock_transfer_id=instance).exists():
        extra = 0
    else:
        extra = 1

    StockTransferItemFormset = inlineformset_factory(
        StockTransfer,
        StockTransferItem,
        can_delete=True,
        extra=extra,
        form=StockTransferItemForm
    )

    old_warehouse = instance.warehouse
    old_to_warehouse = instance.to_warehouse

    if request.method == 'POST':
        response_data = {}
        form = StockTransferForm(request.POST, instance=instance)
        stock_transfer_formset = StockTransferItemFormset(
            request.POST, prefix='stock_transfer_formset', form_kwargs={'empty_permitted': False})

        if form.is_valid() and stock_transfer_formset.is_valid():
            warehouse = form.cleaned_data['warehouse']
            to_warehouse = form.cleaned_data['to_warehouse']

            stock_ok = True
            stock_items = {}
            error_message = ''

            for f in stock_transfer_formset:
                if f.cleaned_data != {}:
                    batch = f.cleaned_data['batch']
                    qty = f.cleaned_data['quantity']

                    obj = {
                        'batch': batch,
                        "quantity": qty,
                    }

                    # to check stock availability
                    if str(batch.pk) in stock_items:
                        stock_items[str(batch.pk)]['quantity'] += qty

                    else:
                        stock_items[str(batch.pk)] = obj

            for key, value in stock_items.items():
                batch = Batch.objects.get(pk=key)

                stock = batch.stock
                product_variant = batch.product_variant

                old_qty = 0
                if old_stockupdate_items.filter(batch=batch).exists():
                    old_qty = old_stockupdate_items.filter(
                        batch=batch).aggregate(Sum('quantity'))['quantity__sum']

                stock = stock + old_qty
                quantity = value['quantity']

                if quantity > stock:
                    stock_ok = False
                    error_message += f"{product_variant} has only {stock} in stock in batch {batch}, You entered {quantity} quantity\n"

            if stock_ok:
                for stock_transfer in old_stockupdate_items:
                    # increasing transfered stock in from_warehouse
                    quantity = stock_transfer.quantity
                    batch = stock_transfer.batch
                    update_batch_stock(batch.pk, quantity, "increase")

                    # decreasing received stock in to_warehouse
                    to_batch = Batch.objects.get(
                        batch_number=batch.batch_number, product_variant=stock_transfer.product_variant, warehouse=old_to_warehouse)
                    update_batch_stock(to_batch.pk, quantity, "decrease")

                old_stockupdate_items.delete()

                # update stock_transfer
                data = form.save(commit=False)
                data.updater = request.user
                data.date_updated = datetime.datetime.now()
                data.save()

                for i in stock_transfer_formset:
                    stock_transfer_auto_id = get_auto_id(StockTransferItem)

                    if i.cleaned_data != {}:
                        quantity = i.cleaned_data['quantity']
                        cost = i.cleaned_data['cost']
                        mrp = i.cleaned_data['mrp']
                        batch = i.cleaned_data['batch']
                        manufacturing_date = i.cleaned_data['manufacturing_date']
                        expire_date = i.cleaned_data['expire_date']
                        retail_price = i.cleaned_data['retail_price']
                        whole_sale_price = i.cleaned_data['whole_sale_price']
                        product_variant = i.cleaned_data['product_variant']

                        stock_transfer_data = StockTransferItem.objects.create(
                            stock_transfer=data,
                            quantity=quantity,

                            product_variant=product_variant,
                            batch=batch,
                            manufacturing_date=manufacturing_date,
                            expire_date=expire_date,
                            mrp=mrp,
                            cost=cost,
                            retail_price=retail_price,
                            whole_sale_price=whole_sale_price,

                            auto_id=stock_transfer_auto_id,
                            creator=request.user,
                            updater=request.user,
                        )
                        update_batch_stock(batch.pk, quantity, "decrease")

                        if Batch.objects.filter(is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse).exists():
                            Batch.objects.filter(is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse).update(
                                stock=F('stock') + quantity,
                                mrp=mrp,

                                cost=cost,
                                retail_price=retail_price,
                                whole_sale_price=whole_sale_price,
                                expire_date=expire_date,
                                manufacturing_date=manufacturing_date,
                            )

                            batch = Batch.objects.get(
                                is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse)

                        else:
                            batch = Batch.objects.create(
                                auto_id=get_auto_id(Batch),
                                creator=request.user,
                                updater=request.user,

                                warehouse=to_warehouse,
                                product_variant=product_variant,
                                product=product_variant.product,

                                batch_number=batch.batch_number,
                                stock=quantity,
                                mrp=mrp,
                                retail_price=retail_price,
                                whole_sale_price=whole_sale_price,
                                cost=cost,
                                expire_date=expire_date,
                                manufacturing_date=manufacturing_date,
                            )

                response_data = {
                    "status": "true",
                    "title": "Successfully Updated",
                    "message": "StockTransfer Successfully Updated.",
                    "redirect": "true",
                    "redirect_url": reverse('general:stock_transfer', kwargs={'pk': data.pk})
                }
            else:
                message = 'Sorry..! Not Enough Stock '
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Stock Transfer Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('general:stock_transfer', kwargs={'pk': data.pk})
            }
        else:
            message = generate_form_errors(form, formset=False)
            print(stock_transfer_formset.errors)

            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = StockTransferForm(instance=instance)
        stock_transfer_formset = StockTransferItemFormset(
            prefix='stock_transfer_formset', instance=instance)

        context = {
            "form": form,
            "instance": instance,
            "title": "Edit Stock Transfer : " + str(instance.auto_id),
            'stock_transfer_formset': stock_transfer_formset,
            "url": reverse('general:edit_stock_transfer', kwargs={'pk': instance.pk}),
            "redirect": True,
            "is_edit": True,
        }

        return render(request, 'general/stock_transfer/stock_transfer_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_stock_transfer(request, pk):
    reason = request.GET.get('reason')

    instance = get_object_or_404(StockTransfer, pk=pk)
    transfer_items = StockTransferItem.objects.filter(stock_transfer=instance)

    warehouse = instance.warehouse
    to_warehouse = instance.to_warehouse

    # to check stock availability in received warehouse
    stock_items = {}
    stock_ok = True
    error_message = ''

    for item in transfer_items:
        product_variant = item.product_variant
        qty = item.quantity
        batch = item.batch

        obj = {
            'batch': batch,
            "quantity": qty,
        }

        # to check stock availability
        if str(batch.pk) in stock_items:
            stock_items[str(batch.pk)]['quantity'] += qty

        else:
            stock_items[str(batch.pk)] = obj

    # Checking the stock available for this product
    for key, value in stock_items.items():
        batch = Batch.objects.get(pk=key)
        product_variant = batch.product_variant

        to_batch = Batch.objects.get(is_deleted=False, batch_number=batch.batch_number, product_variant=product_variant, warehouse=to_warehouse)

        stock = to_batch.stock
        quantity = value['quantity']

        if quantity > stock:
            stock_ok = False

            error_message += f"{product_variant} has only {stock} in stock in batch {to_batch}, You entered {quantity} quantity\n"

    if stock_ok:
        StockTransfer.objects.filter(pk=pk).update(is_deleted=True,deleted_reason=reason)

        for item in transfer_items:
            batch = item.batch

            to_batch = Batch.objects.get(is_deleted=False, batch_number=batch.batch_number, product_variant=batch.product_variant, warehouse=to_warehouse)
            update_batch_stock(to_batch.pk, quantity, "decrease")
            update_batch_stock(batch.pk, quantity, "increase")

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Stock Transfer Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('general:stock_transfers')
        }

    else:
        response_data = {
            "status": "false",
            "stable": "true",
            "title": "Cancellation Failed..!",
            "message": error_message
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_inward_stock(request):
    StockUpdateItemFormset = formset_factory(StockUpdateItemForm,extra=1)
    warehouse = get_warehouse(request)

    if request.method == 'POST':
        batch_ok = False
        form = StockUpdateForm(request.POST)
        stock_update_item_formset = StockUpdateItemFormset(request.POST,prefix="stock_update_item_formset")

        if form.is_valid() and stock_update_item_formset.is_valid():
            warehouse = form.cleaned_data['warehouse']
            error_message = ''
            batch_ok = True
            item_ok = False

            for form_item in stock_update_item_formset:
                item_ok = True
                mrp = form_item.cleaned_data['mrp']
                cost = form_item.cleaned_data['cost']
                retail_price = form_item.cleaned_data['retail_price']
                whole_sale_price = form_item.cleaned_data['whole_sale_price']
                product_variant = form_item.cleaned_data['product_variant']
                batch = form_item.cleaned_data['batch']


                if product_variant:
                    product_name = str(product_variant)

                if (Decimal(mrp) - Decimal(retail_price)) < 0 :
                    error_message += f'Selling Retail Price is greater than MRP of {product_name}.\n'
                    batch_ok = False
                if (Decimal(retail_price) - Decimal(cost)) < 0:
                    error_message += f'Cost is greater than selling retail Price of {product_name}.\n'
                    batch_ok = False
                if (Decimal(mrp) - Decimal(whole_sale_price)) < 0 :
                    error_message += f'Selling Whole Sale Price is greater than MRP of {product_name}.\n'
                    batch_ok = False

                if (Decimal(whole_sale_price) - Decimal(cost)) < 0 and False:
                    # wholesale price is not necessarily required for all products
                    error_message += f'Cost is greater than selling Whole Sale Price of {product_name}.\n'
                    batch_ok = False
            print("batch", batch_ok)
            print("item_ok", item_ok)
            if not batch_ok or not item_ok:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message if not batch_ok else "Please enter products to add stock."
                }

                return HttpResponse(json.dumps(response_data), content_type='application/javascript')

            data = form.save(commit=False)
            data.creator = request.user
            data.updater = request.user
            data.auto_id = get_auto_id(StockUpdate)
            data.save()

            for form_item in stock_update_item_formset:
                batch = form_item.cleaned_data['batch']
                batch_number = form_item.cleaned_data['batch_number']
                add_new_batch = form_item.cleaned_data['add_new_batch']
                product_variant = form_item.cleaned_data['product_variant']

                mrp = form_item.cleaned_data['mrp']
                cost = form_item.cleaned_data['cost']
                retail_price = form_item.cleaned_data['retail_price']
                whole_sale_price = form_item.cleaned_data['whole_sale_price']
                quantity = form_item.cleaned_data['stock']
                expire_date = form_item.cleaned_data['expire_date']
                manufacturing_date = form_item.cleaned_data['manufacturing_date']

                total_tax_rate = product_variant.product.hsn.cgst_rate+product_variant.product.hsn.sgst_rate
                taxable_amount = (cost / (1 + (total_tax_rate / 100)))

                if product_variant.is_special_variant:
                    current_batch = None
                    if add_new_batch:
                        batch_number = batch_number if batch_number else '0DEFLT'
                else:
                    current_batch = None
                    if add_new_batch:
                        if not batch_number:
                            batch_number = '0DEFLT'
                    else:
                        if current_batch:
                            batch_number = current_batch.batch_number
                        else:
                            batch_number = '0DEFLT'

                if not product_variant.is_special_variant:
                    if current_batch and Batch.objects.filter(pk=current_batch.pk).exists():
                        Batch.objects.filter(pk=current_batch.pk).update(
                            stock=F('stock') + quantity,
                            mrp=mrp,
                            cost=cost,
                            retail_price=retail_price,
                            whole_sale_price=whole_sale_price,
                            expire_date=expire_date,
                            manufacturing_date=manufacturing_date,
                        )

                        batch = Batch.objects.get(pk=current_batch.pk)

                    else:
                        batch = Batch.objects.create(
                            auto_id=get_auto_id(Batch),
                            mrp=mrp,
                            cost=cost,
                            stock=quantity,
                            creator=request.user,
                            updater=request.user,
                            warehouse=warehouse,
                            batch_number=batch_number,
                            product_variant=product_variant,
                            product=product_variant.product,
                            retail_price=retail_price,
                            whole_sale_price=whole_sale_price,
                            expire_date=expire_date,
                            manufacturing_date=manufacturing_date,
                        )

                else:
                    variants = product_variant.special_variant_added.product_variant.all()
                    special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, is_deleted=False).order_by('expire_date')

                    for variant_obj in variants:
                        variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                        if variant_stocks.exists():
                            variant_stock = variant_stocks.first().stock
                            stock_pk = variant_stocks.first().pk
                            Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)

                        elif add_new_batch or not variant_stocks.exists():
                            Batch.objects.create(
                                auto_id = get_auto_id(Batch),
                                mrp = mrp,
                                cost = cost,
                                stock = quantity,
                                creator = request.user,
                                updater = request.user,
                                warehouse = warehouse,
                                batch_number = batch_number or "0DEFLT",
                                product_variant = variant_obj,
                                product = variant_obj.product,
                                retail_price = retail_price,
                                whole_sale_price = whole_sale_price,
                                expire_date = expire_date,
                                manufacturing_date = manufacturing_date,
                            )
                        variant_obj.total_stock()

                product_variant.stock = product_variant.total_stock()
                product_variant.save()

                stock_item = form_item.save(commit=False)
                stock_item.stockupdate = data
                stock_item.batch = batch
                stock_item.taxable_amount = taxable_amount
                stock_item.save()

            response_data = {
                "status" : "true",
                "title" : "Successfully Created",
                "message" : "Inward stock added successfully.",
                "redirect" : "true",
                "redirect_url" : reverse('general:stock_updates')
            }

        else:
            message = generate_form_errors(form,formset=False)
            message += generate_form_errors(stock_update_item_formset,formset=True)
            response_data = {
                "status" : "false",
                "stable" : "true",
                "title" : "Form validation error",
                "message" : str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = StockUpdateForm(initial={'date': datetime.datetime.now().date(), 'warehouse': warehouse})
        stock_update_item_formset = StockUpdateItemFormset(prefix="stock_update_item_formset")

        for form_item in stock_update_item_formset:
            # form_item.fields['product'].queryset = Product.objects.filter(is_deleted=False)
            form_item.fields['product_variant'].queryset = ProductVariant.objects.none()
            form_item.fields['batch'].queryset = Batch.objects.none()

        context = {
            "title" : "Create Inward Stock",
            "form" : form,
            "stock_update_item_formset" : stock_update_item_formset,
            "url" : reverse('general:create_inward_stock'),
            "redirect" : True,

        }
        return render(request,'general/entry_batch.html',context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_outward_stock(request):
    StockOutwardItemFormset = formset_factory(StockOutWardItemForm, extra=3)
    warehouse = get_warehouse(request)

    if request.method == 'POST':
        form = StockUpdateForm(request.POST)
        stock_update_item_formset = StockOutwardItemFormset(request.POST,prefix="stock_update_item_formset")

        if form.is_valid() and stock_update_item_formset.is_valid():
            error_message = ''
            stock_items = {}
            stock_ok = True

            for f in stock_update_item_formset:
                if f.cleaned_data != {}:
                    product_variant = f.cleaned_data['product_variant']
                    batch = f.cleaned_data['batch']
                    qty = f.cleaned_data['stock']

                    obj = {
                        'product_variant' : product_variant,
                        'batch' : batch,
                        "quantity": qty,
                    }

                    # to check stock availability
                    if batch:
                        if str(batch.pk) in stock_items:
                            stock_items[str(batch.pk)]['quantity'] += qty
                        else:
                            stock_items[str(batch.pk)] = obj
                    else:
                        if str(product_variant.pk) in stock_items:
                            stock_items[str(product_variant.pk)]['quantity'] += qty
                        else:
                            stock_items[str(product_variant.pk)] = obj

            for key, value in stock_items.items():
                batch = value["batch"]
                quantity = value['quantity']
                product_variant = value["product_variant"]

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

            if stock_ok:
                auto_id = get_auto_id(StockUpdate)
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = auto_id
                data.update_type = 'outward'
                data.save()

                for form_item in stock_update_item_formset:
                    batch = form_item.cleaned_data['batch']
                    quantity = form_item.cleaned_data['stock']
                    product_variant = form_item.cleaned_data['product_variant']

                    if product_variant.is_special_variant:
                        special_variant = product_variant.special_variant_added
                        variants = special_variant.product_variant.all()
                        special_variant_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False).order_by('expire_date')

                        for variant_obj in variants:
                            variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                            total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                            if variant_stocks.filter(stock__gte=quantity).exists():
                                variant_stock = variant_stocks.filter(stock__gte=quantity).first().stock
                                pk = variant_stocks.filter(stock__gte=quantity).first().pk

                                if variant_stock > quantity:
                                    Batch.objects.filter(pk=pk).update(stock=variant_stock - quantity)

                            elif total_stock > quantity:
                                for batch_item in variant_stocks:
                                    if batch_item.stock >= quantity:
                                        batch_item.stock = batch_item.stock - quantity
                                        batch_item.save()
                                        break
                                    elif batch_item.stock < quantity:
                                        total_qty -= batch_item.stock
                                        batch_item.stock = 0
                                        batch_item.save()
                            print(variant_obj.total_stock(), 'total stock of special variant')
                        print(product_variant.total_stock(), 'total stock of special variant')

                    else:
                        if Batch.objects.filter(pk=batch.pk).exists():
                            Batch.objects.filter(pk=batch.pk).update(stock = F('stock') - quantity)

                        if product_variant:
                            product_variant.stock = product_variant.total_stock()
                            product_variant.save()

                    data1 = form_item.save(commit=False)
                    data1.stockupdate = data
                    data1.save()

                response_data = {
                    "status" : "true",
                    "title" : "Successfully Created",
                    "message" : "Stock updated successfully.",
                    "redirect" : "true",
                    "redirect_url" : reverse('general:stock_updates')
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
            message = generate_form_errors(form, formset=False)
            message += generate_form_errors(stock_update_item_formset, formset=True)
            response_data = {
                "status" : "false",
                "stable" : "true",
                "title" : "Form validation error",
                "message" : str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = StockUpdateForm(initial={'date': datetime.datetime.now().date(), 'warehouse': warehouse})
        stock_update_item_formset = StockOutwardItemFormset(prefix="stock_update_item_formset")

        for form_item in stock_update_item_formset:
            form_item.fields['product_variant'].queryset = ProductVariant.objects.none()
            form_item.fields['batch'].queryset = Batch.objects.none()

        context = {
            "form" : form,
            "title" : "Create Outward Stock",
            "stock_update_item_formset" : stock_update_item_formset,
            "url" : reverse('general:create_outward_stock'),
            "redirect" : True,

        }

        return render(request,'general/entry_outward_stock.html',context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def update_stock(request,pk):
    instance = get_object_or_404(StockUpdate.objects.filter(pk=pk,is_deleted=False))

    stock_update_item = StockUpdateItem.objects.filter(stockupdate=instance)

    context = {
        "instance" : instance,
        "title" : "Stock Update",
        "stock_update_item" : stock_update_item,
    }

    return render(request,'general/update_stock.html',context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_update_stock(request,pk):
    instance = get_object_or_404(StockUpdate.objects.filter(pk=pk,is_deleted=False))
    old_stockupdate_items = StockUpdateItem.objects.filter(stockupdate_id=pk)

    extra = 0 if old_stockupdate_items.exists() else 1

    if instance.update_type == 'inward':
        item_form = StockInwardItemEditForm
        template_name = 'general/entry_batch.html'
    else:
        item_form = StockOutWardItemForm
        template_name = 'general/entry_outward_stock.html'

    StockUpdateItemFormset = inlineformset_factory(
        StockUpdate,
        StockUpdateItem,
        can_delete = True,
        extra = extra,
        form = item_form
    )

    if request.method == 'POST':
        form = StockUpdateForm(request.POST, instance=instance)
        stock_update_item_formset = StockUpdateItemFormset(request.POST, instance=instance, prefix="stock_update_item_formset")

        if form.is_valid() and stock_update_item_formset.is_valid():
            stock_ok = True
            stock_items = {}
            error_message = ''
            warehouse = form.cleaned_data['warehouse']

            if instance.update_type == 'outward':
                for f in stock_update_item_formset:
                    if f.cleaned_data != {}:
                        product_variant = f.cleaned_data['product_variant']
                        batch = f.cleaned_data['batch']
                        qty = f.cleaned_data['stock']

                        obj = {
                            'batch' : batch,
                            "quantity": qty,
                            'product_variant': product_variant,
                        }

                        # to check stock availability
                        if batch:
                            if str(batch.pk) in stock_items:
                                stock_items[str(batch.pk)]['quantity'] += qty
                            else:
                                stock_items[str(batch.pk)] = obj
                        else:
                            if str(product_variant.pk) in stock_items:
                                stock_items[str(product_variant.pk)]['quantity'] += qty
                            else:
                                stock_items[str(product_variant.pk)] = obj

                for key, value in stock_items.items():
                    batch = value["batch"]
                    quantity = value['quantity']
                    product_variant = value["product_variant"]

                    old_qty = 0
                    if StockUpdateItem.objects.filter(batch=batch, product_variant=product_variant, stockupdate=instance).exists():
                        old_qty = StockUpdateItem.objects.filter(batch=batch, product_variant=product_variant, stockupdate=instance).last().stock

                    if product_variant.is_special_variant:
                        stock = product_variant.total_stock() + old_qty
                        if quantity > stock:
                            stock_ok = False
                            error_message += f"{product_variant} has only {stock} in stock , You entered {quantity} quantity\n"
                    else:
                        stock = batch.stock + old_qty
                        if quantity > stock:
                            stock_ok = False
                            error_message += f"{product_variant} has only {stock} in stock in batch {batch}, You entered {quantity} quantity\n"

            else:
                for f in stock_update_item_formset:
                    mrp = f.cleaned_data['mrp']
                    cost = f.cleaned_data['cost']
                    retail_price = f.cleaned_data['retail_price']
                    whole_sale_price = f.cleaned_data['whole_sale_price']
                    product_variant = f.cleaned_data['product_variant']

                    if (Decimal(mrp) - Decimal(retail_price)) < 0 :
                        error_message += f'Retail price is greater than MRP of {product_variant}.\n'
                        stock_ok = False
                    if (Decimal(retail_price) - Decimal(cost)) < 0:
                        error_message += f'Cost is greater than Retail price of {product_variant}.\n'
                        stock_ok = False

                    if (Decimal(mrp) - Decimal(whole_sale_price)) < 0 :
                        error_message += f'Whole Sale price is greater than MRP of {product_variant}.\n'
                        stock_ok = False
                    if (Decimal(whole_sale_price) - Decimal(cost)) < 0 and False:
                        # wholesale price is not necessarily required for all products
                        error_message += f'Cost is greater than Whole Sale price of {product_variant}.\n'
                        stock_ok = False

            if stock_ok:
                data = form.save(commit=False)
                data.updater = request.user
                data.date_updated = datetime.datetime.now()
                data.save()

                # return the previous updated stock to old state
                for item in old_stockupdate_items:
                    batch = item.batch
                    quantity = item.stock
                    product_variant = item.product_variant

                    if instance.update_type == 'inward':
                        if batch:
                            Batch.objects.filter(pk=batch.pk).update(stock = F('stock') - quantity)
                        elif product_variant.is_special_variant:
                            special_variant = product_variant.special_variant_added
                            variants = special_variant.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False).order_by('expire_date')

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                                total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                                if variant_stocks.filter(stock__gte=quantity).exists():
                                    variant_stock = variant_stocks.filter(stock__gte=quantity).first().stock
                                    pk = variant_stocks.filter(stock__gte=quantity).first().pk

                                    if variant_stock > quantity:
                                        Batch.objects.filter(pk=pk).update(stock=variant_stock - quantity)

                                elif total_stock > quantity:
                                    for batch_item in variant_stocks:
                                        if batch_item.stock >= quantity:
                                            batch_item.stock = batch_item.stock - quantity
                                            batch_item.save()
                                            break
                                        elif batch_item.stock < quantity:
                                            total_qty -= batch_item.stock
                                            batch_item.stock = 0
                                            batch_item.save()
                                print(variant_obj.total_stock(), 'total stock of special variant')
                    else:
                        if batch:
                            Batch.objects.filter(pk=batch.pk).update(stock = F('stock') + quantity)
                        elif product_variant.is_special_variant:
                            variants = product_variant.special_variant_added.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, is_deleted=False).order_by('expire_date')

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                                if len(variant_stocks) > 0:
                                    variant_stock = variant_stocks.first().stock
                                    stock_pk = variant_stocks.first().pk
                                    Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)
                                print(variant_obj.total_stock(), 'total stock of special variant')

                    product_variant.stock = product_variant.total_stock()
                    product_variant.save()

                old_stockupdate_items.delete()

                for form_item in stock_update_item_formset:
                    if instance.update_type == 'inward':
                        batch = form_item.cleaned_data['batch']
                        batch_number = form_item.cleaned_data['batch_number']
                        add_new_batch = form_item.cleaned_data['add_new_batch']
                        product_variant = form_item.cleaned_data['product_variant']

                        mrp = form_item.cleaned_data['mrp']
                        cost = form_item.cleaned_data['cost']
                        retail_price = form_item.cleaned_data['retail_price']
                        whole_sale_price = form_item.cleaned_data['whole_sale_price']
                        quantity = form_item.cleaned_data['stock']
                        expire_date = form_item.cleaned_data['expire_date']
                        manufacturing_date = form_item.cleaned_data['manufacturing_date']
                        is_update_batch_data = form_item.cleaned_data['update_batch_data']

                        taxable_amount = 0

                        if product_variant.is_special_variant:
                            current_batch = None
                            if add_new_batch:
                                batch_number = batch_number if batch_number else '0DEFLT'
                        else:
                            if add_new_batch:
                                current_batch = None
                                if not batch_number:
                                    batch_number = '0DEFLT'
                            else:
                                if current_batch:
                                    batch_number = current_batch.batch_number
                                else:
                                    batch_number = '0DEFLT'

                        if not product_variant.is_special_variant:
                            if current_batch and Batch.objects.filter(pk=current_batch.pk).exists():
                                Batch.objects.filter(pk=current_batch.pk).update(
                                    stock=F('stock') + quantity,
                                    mrp=mrp,
                                    cost=cost,
                                    retail_price=retail_price,
                                    whole_sale_price=whole_sale_price,
                                    expire_date=expire_date,
                                    manufacturing_date=manufacturing_date,
                                )

                                batch = Batch.objects.get(pk=current_batch.pk)

                            else:
                                batch = Batch.objects.create(
                                    auto_id=get_auto_id(Batch),
                                    mrp=mrp,
                                    cost=cost,
                                    stock=quantity,
                                    creator=request.user,
                                    updater=request.user,
                                    warehouse=warehouse,
                                    batch_number=batch_number,
                                    product_variant=product_variant,
                                    product=product_variant.product,
                                    retail_price=retail_price,
                                    whole_sale_price=whole_sale_price,
                                    expire_date=expire_date,
                                    manufacturing_date=manufacturing_date,
                                )

                        else:
                            variants = product_variant.special_variant_added.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, is_deleted=False).order_by('expire_date')

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                                if variant_stocks.exists():
                                    variant_stock = variant_stocks.first().stock
                                    stock_pk = variant_stocks.first().pk
                                    Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)

                                elif add_new_batch or not variant_stocks.exists():
                                    Batch.objects.create(
                                        auto_id = get_auto_id(Batch),
                                        mrp = mrp,
                                        cost = cost,
                                        stock = quantity,
                                        creator = request.user,
                                        updater = request.user,
                                        warehouse = warehouse,
                                        batch_number = batch_number or "0DEFLT",
                                        product_variant = variant_obj,
                                        product = variant_obj.product,
                                        retail_price = retail_price,
                                        whole_sale_price = whole_sale_price,
                                        expire_date = expire_date,
                                        manufacturing_date = manufacturing_date,
                                    )
                                variant_obj.total_stock()

                        if product_variant:
                            product_variant.stock = product_variant.total_stock()
                            product_variant.save()

                        stock_item = form_item.save(commit=False)
                        stock_item.stockupdate = data
                        stock_item.batch = batch
                        stock_item.taxable_amount = taxable_amount
                        stock_item.save()

                    else:
                        batch = form_item.cleaned_data['batch']
                        quantity = form_item.cleaned_data['stock']
                        product_variant = form_item.cleaned_data['product_variant']

                        if product_variant.is_special_variant:
                            special_variant = product_variant.special_variant_added
                            variants = special_variant.product_variant.all()
                            special_variant_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False).order_by('expire_date')

                            for variant_obj in variants:
                                variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                                total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                                if variant_stocks.filter(stock__gte=quantity).exists():
                                    variant_stock = variant_stocks.filter(stock__gte=quantity).first().stock
                                    pk = variant_stocks.filter(stock__gte=quantity).first().pk

                                    if variant_stock > quantity:
                                        Batch.objects.filter(pk=pk).update(stock=variant_stock - quantity)

                                elif total_stock > quantity:
                                    for batch_item in variant_stocks:
                                        if batch_item.stock >= quantity:
                                            batch_item.stock = batch_item.stock - quantity
                                            batch_item.save()
                                            break
                                        elif batch_item.stock < quantity:
                                            total_qty -= batch_item.stock
                                            batch_item.stock = 0
                                            batch_item.save()
                                print(variant_obj.total_stock(), 'total stock of special variant')
                            print(product_variant.total_stock(), 'total stock of special variant')

                        else:
                            if Batch.objects.filter(pk=batch.pk).exists():
                                Batch.objects.filter(pk=batch.pk).update(stock = F('stock') - quantity)

                            if product_variant:
                                product_variant.stock = product_variant.total_stock()
                                product_variant.save()

                        data1 = form_item.save(commit=False)
                        data1.stockupdate = data
                        data1.save()

                response_data = {
                    "status" : "true",
                    "title" : "Successfully Updated",
                    "message" : "Stock updated successfully.",
                    "redirect" : "true",
                    "redirect_url" : reverse('general:update_stock', kwargs={'pk': data.pk}),
                }

            else:
                response_data = {
                    "status": "false",
                    "stable": "true",
                    "title": "Form validation error",
                    "message": error_message
                }

        else:
            message = generate_form_errors(form,formset=False)
            message += generate_form_errors(stock_update_item_formset,formset=True)
            print(form.errors)
            print(stock_update_item_formset.errors)
            response_data = {
                "status" : "false",
                "stable" : "true",
                "title" : "Form validation error",
                "message" : str(message)
            }

        return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = StockUpdateForm(instance=instance, initial={'date': (instance.date.date()+datetime.timedelta(days=1))})
        stock_update_item_formset = StockUpdateItemFormset(prefix="stock_update_item_formset", instance=instance)

        for form_item in stock_update_item_formset:
            form_item.fields['product_variant'].queryset = ProductVariant.objects.none()
            form_item.fields['batch'].queryset = Batch.objects.none()

        context = {
            "title" : f"Edit {instance.update_type} stock",
            "stock_update_item_formset" : stock_update_item_formset,
            "url" : request.path,
            "form" : form,
            "redirect" : True,
            "is_edit" : True,
        }

        return render(request, template_name, context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def stock_updates(request):
    instances = StockUpdate.objects.filter(is_deleted=False).order_by('-auto_id')
    title = "Update stocks"

    context = {
        "instances" : instances,
        'title' : title,
    }

    return render(request,'general/update_stocks.html',context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_stock_update(request, pk):
    instance = StockUpdate.objects.get(pk=pk)
    stock_update_items = StockUpdateItem.objects.filter(stockupdate_id=pk)

    warehouse = instance.warehouse

    # update stock
    for item in stock_update_items:
        quantity, batch = item.stock, item.batch
        product_variant = item.product_variant

        if instance.update_type == 'inward':
            if product_variant.is_special_variant:
                special_variant = product_variant.special_variant_added
                variants = special_variant.product_variant.all()
                special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, stock__gt=0, is_deleted=False).order_by('expire_date')

                for variant_obj in variants:
                    variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)
                    total_stock = variant_stocks.aggregate(stock=Sum('stock')).get('stock', 0)

                    if variant_stocks.filter(stock__gte=quantity).exists():
                        variant_stock = variant_stocks.filter(stock__gte=quantity).first().stock
                        pk = variant_stocks.filter(stock__gte=quantity).first().pk

                        if variant_stock > quantity:
                            Batch.objects.filter(pk=pk).update(stock=variant_stock - quantity)

                    elif total_stock > quantity:
                        for batch_item in variant_stocks:
                            if batch_item.stock >= quantity:
                                batch_item.stock = batch_item.stock - quantity
                                batch_item.save()
                                break
                            elif batch_item.stock < quantity:
                                total_qty -= batch_item.stock
                                batch_item.stock = 0
                                batch_item.save()
                    print(variant_obj.total_stock(), 'total stock of variant')
                print(product_variant.total_stock(), 'total stock of special variant')

            else:
                if Batch.objects.filter(pk=batch.pk, stock__gte=quantity).exists():
                    Batch.objects.filter(pk=batch.pk, stock__gte=quantity).update(stock=F('stock') - quantity)

                item.product_variant.stock = item.product_variant.total_stock()
                item.product_variant.save()

        else:
            if batch:
                Batch.objects.filter(pk=batch.pk).update(stock=F('stock') + quantity)

                if product_variant:
                    product_variant.stock = product_variant.total_stock()
                    product_variant.save()

            elif product_variant.is_special_variant:
                variants = product_variant.special_variant_added.product_variant.all()
                special_variant_batches = Batch.objects.filter(product_variant__in=variants, warehouse=warehouse, is_deleted=False).order_by('expire_date')

                for variant_obj in variants:
                    variant_stocks = special_variant_batches.filter(product_variant_id=variant_obj.pk)

                    if len(variant_stocks) > 0:
                        variant_stock = variant_stocks.first().stock
                        stock_pk = variant_stocks.first().pk
                        Batch.objects.filter(pk=stock_pk).update(stock=variant_stock + quantity)

    instance.is_deleted = True
    instance.save()

    response_data = {
        "status": "true",
        "title": "Successfully Removed",
        "message": f"{instance.update_type.title()} Stock Successfully removed.",
        "redirect": "true",
        "redirect_url": reverse('general:stock_updates')
    }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def create_invoice_design(request):
    instances = InvoiceDesign.objects.filter(is_deleted=False,is_active=True)
    if request.method == 'POST':
        form = InvoiceDesignForm(request.POST,request.FILES)

        if not instances or True:
            if form.is_valid():

                auto_id = get_auto_id(InvoiceDesign)
                # create invoice_design
                data = form.save(commit=False)
                data.creator = request.user
                data.updater = request.user
                data.auto_id = auto_id

                data.save()

                response_data = {
                    "status": "true",
                    "title": "Successfully Created",
                    "message": "Invoice Design Created Successfully.",
                    "redirect": "true",
                    "redirect_url": reverse('general:invoice_design', kwargs={'pk': data.pk})
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
            response_data = {
                "status": "false",
                "stable": "true",
                "title": "Form validation error",
                "message": str("Active Invoice Design Exists")
            }

            return HttpResponse(json.dumps(response_data), content_type='application/javascript')

    else:
        form = InvoiceDesignForm()
        context = {
            "title": "Create Invoice Design ",
            "form": form,
            "url": reverse('general:create_invoice_design'),
        }
        return render(request, 'general/invoice_design/invoice_design_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def invoice_designs(request):
    instances = InvoiceDesign.objects.filter(is_deleted=False)
    title = "InvoiceDesigns"
    query = request.GET.get("q")
    if query:
        instances = instances.filter(
            Q(auto_id__icontains=query) | Q(title__icontains=query))
        title = "Invoice Designs - %s" % query

    context = {
        "instances": instances,
        'title': title,

    }
    return render(request, 'general/invoice_design/invoice_designs.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def invoice_design(request, pk):
    instance = get_object_or_404(InvoiceDesign.objects.filter(pk=pk, is_deleted=False))
    context = {
        "instance": instance,
        "title": "InvoiceDesign : " + instance.title,
        "single_page": True,

    }
    return render(request, 'general/invoice_design/invoice_design.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def edit_invoice_design(request, pk):
    instance = get_object_or_404(InvoiceDesign.objects.filter(pk=pk, is_deleted=False))

    if request.method == 'POST':
        response_data = {}
        form = InvoiceDesignForm(request.POST,request.FILES, instance=instance)

        if form.is_valid():

            # update invoice_design
            data = form.save(commit=False)
            data.updater = request.user
            data.date_updated = datetime.datetime.now()
            data.save()

            response_data = {
                "status": "true",
                "title": "Successfully Updated",
                "message": "Invoice Design Successfully Updated.",
                "redirect": "true",
                "redirect_url": reverse('general:invoice_design', kwargs={'pk': data.pk})
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
        form = InvoiceDesignForm(instance=instance)

        context = {
            "form": form,
            "title": "Edit Invoice Design : " + instance.title,
            "instance": instance,
            "url": reverse('general:edit_invoice_design', kwargs={'pk': instance.pk}),
            "redirect": True,

        }
        return render(request, 'general/invoice_design/invoice_design_entry.html', context)


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_invoice_design(request, pk):
    reason = request.GET.get('reason')
    print(reason,"POOOOOOOO")
    instance = get_object_or_404(InvoiceDesign.objects.filter(pk=pk, is_deleted=False))

    InvoiceDesign.objects.filter(pk=pk).update(
        is_deleted=True, deleted_reason=reason)

    response_data = {
        "status": "true",
        "title": "Successfully Deleted",
        "message": "Invoice Design Successfully Deleted.",
        "redirect": "true",
        "redirect_url": reverse('general:invoice_designs')
    }
    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


@login_required
@role_required(['superadmin', 'staff', 'warehouse_manager'])
def delete_selected_invoice_designs(request):
    pks = request.GET.get('pk')
    if pks:
        pks = pks[:-1]

        pks = pks.split(',')
        for pk in pks:
            instance = get_object_or_404(
                InvoiceDesign.objects.filter(pk=pk, is_deleted=False))
            InvoiceDesign.objects.filter(pk=pk).update(
                is_deleted=True, name=instance.name + "_deleted_" + str(instance.auto_id))

        response_data = {
            "status": "true",
            "title": "Successfully Deleted",
            "message": "Selected Invoice Designs Successfully Deleted.",
            "redirect": "true",
            "redirect_url": reverse('general:invoice_designs')
        }
    else:
        response_data = {
            "status": "false",
            "title": "Nothing selected",
            "message": "Please select some items first.",
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')


def get_delivery_charge(request):
    try:
        address = request.GET.get('address')
        warehouse = request.GET.get('warehouse')
        delivery_type = request.GET.get('delivery_type')

        address = CustomerAddress.objects.get(pk=address)

        to_zone = address.zone
        delivery_charge = applicable_limit = 0

        delivery_instances = DeliveryCharge.objects.filter(is_deleted=False, to_zone=to_zone, warehouse_id=warehouse )
        charges_settings = ChargeSetting.objects.filter(warehouse_id=warehouse)

        if delivery_instances.exists():
            delivery_charge = delivery_instances.first().express_charge if delivery_type == 'express' else delivery_instances.first().normal_charge

        if charges_settings.exists():
            applicable_limit = charges_settings.first().no_delivery_charge_amount

        response_data = {
            "status": 'true',
            "delivery_charge": float(delivery_charge),
            "applicable_limit": float(applicable_limit),
        }

    except Exception as e:
        print(f'-----------\n\n\n\n\n{e}\n\n\n\n\n\n--------------')

        response_data = {
            "status": 'false',
            "message": str(e)
        }

    return HttpResponse(json.dumps(response_data), content_type='application/javascript')
