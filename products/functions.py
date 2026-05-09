# Local libraries
from api.v1.general.serializers import VariantSerializer
from main.functions import get_auto_id, get_a_id
from products.models import Product, ProductStock, ProductVariant, Category, Brand, SubCategory, VariationType
from general.models import Batch
from purchases.models import Purchase
from sales.models import Sale
# django libraries
from django.db.models import Sum, Q, F
from django.core.files.images import get_image_dimensions
# standard libraries
from decimal import Decimal
import datetime


def get_exact_qty(qty, unit):
    is_base = unit.is_base
    if not is_base:
        conversion_factor = unit.conversion_factor
        return qty * conversion_factor
    else:
        return qty


def image_validation(image):
    is_ok = True
    message = ''
    if image:
        w, h = get_image_dimensions(image)
        if w < 215:
            message = "The image is %i pixel wide. It's supposed to be minimum 215px" % w
            is_ok = False
        if h < 241:
            message = "The image is %i pixel high. It's supposed to be minimum 241px" % h
            is_ok = False

    return (is_ok, message)


def update_stock_register(pk, qty, status, category, item_pk, date=datetime.datetime.now()):
    product = Product.objects.get(pk=pk)
    the_cost = product.cost
    stock_value = Decimal(the_cost) * Decimal(qty)

    increment = 0
    decrement = 0
    if status == "increase":
        increment = stock_value
    elif status == "decrease":
        decrement = stock_value

    sale = None
    sale_return = None
    purchase = None
    purchase_return = None

    if category == "sale":
        sale = Sale.objects.get(pk=item_pk)
    # elif category == "sale_return":
    # sale_return = SaleReturn.objects.get(pk=item_pk)
    elif category == "purchase":
        purchase = Purchase.objects.get(pk=item_pk)
    # elif category == "purchase_return":
    #     purchase_return = PurchaseReturn.objects.get(pk=item_pk)
    ProductStock.objects.create(product=product, date=date, increment=increment, decrement=decrement,
                                category=category, sale=sale, sale_return=sale_return, purchase=purchase,
                                purchase_return=purchase_return)


def update_stock_register_edit(pk, status, qty, category, item_pk, date=None):
    product = Product.objects.get(pk=pk)
    the_cost = product.cost
    stock_value = the_cost * qty

    increment = 0
    decrement = 0
    if status == "increase":
        increment = stock_value
    elif status == "decrease":
        decrement = stock_value

    sale = None
    # sale_return = None
    purchase = None
    # purchase_return = None
    if date:
        if category == "sale":
            sale = Sale.objects.get(pk=item_pk)
            ProductStock.objects.filter(product=product, sale=sale).update(
                increment=increment, decrement=decrement, date=date)
        # elif category == "sale_return":
        #     sale_return = SaleReturn.objects.get(pk=item_pk)
        #     ProductStock.objects.filter(product=product,sale_return=sale_return).update(increment=increment,decrement=decrement,date=date)
        elif category == "purchase":
            purchase = Purchase.objects.get(pk=item_pk)
            ProductStock.objects.filter(product=product, purchase=purchase).update(
                increment=increment, decrement=decrement, date=date)
        # elif category == "purchase_return":
        #     purchase_return = PurchaseReturn.objects.get(pk=item_pk)
        #     ProductStock.objects.filter(product=product,purchase_return=purchase_return).update(increment=increment,decrement=decrement,date=date)
        elif category == "opening":
            ProductStock.objects.filter(product=product, category=category).update(
                increment=increment, decrement=decrement, date=date)
    else:
        if category == "sale":
            sale = Sale.objects.get(pk=item_pk)
            ProductStock.objects.filter(product=product, sale=sale).update(
                increment=increment, decrement=decrement)
        # elif category == "sale_return":
        #     sale_return = SaleReturn.objects.get(pk=item_pk)
        #     ProductStock.objects.filter(product=product,sale_return=sale_return).update(increment=increment,decrement=decrement)
        elif category == "purchase":
            purchase = Purchase.objects.get(pk=item_pk)
            ProductStock.objects.filter(product=product, purchase=purchase).update(
                increment=increment, decrement=decrement)
        # elif category == "purchase_return":
        #     purchase_return = PurchaseReturn.objects.get(pk=item_pk)
        #     ProductStock.objects.filter(product=product,purchase_return=purchase_return).update(increment=increment,decrement=decrement)
        elif category == "opening":
            ProductStock.objects.filter(product=product, category=category).update(
                increment=increment, decrement=decrement)


def update_stock_register_delete(pk, category, item_pk):
    product = Product.objects.get(pk=pk)

    sale = None
    # sale_return = None
    purchase = None
    # purchase_return = None
    if category == "sale":
        sale = Sale.objects.get(pk=item_pk)
        ProductStock.objects.filter(
            product=product, sale=sale).update(is_deleted=True)
    # elif category == "sale_return":
    #     sale_return = SaleReturn.objects.get(pk=item_pk)
    #     ProductStock.objects.filter(product=product,sale_return=sale_return).update(is_deleted=True)
    elif category == "purchase":
        purchase = Purchase.objects.get(pk=item_pk)
        ProductStock.objects.filter(
            product=product, purchase=purchase).update(is_deleted=True)
    # elif category == "purchase_return":
    #     purchase_return = PurchaseReturn.objects.get(pk=item_pk)
    #     ProductStock.objects.filter(product=product,purchase_return=purchase_return).update(is_deleted=True)
    elif category == "opening":
        ProductStock.objects.filter(
            product=product, category=category).update(is_deleted=True)


def get_all_stock(product):
    total_stock = ProductVariant.objects.filter(product=product, is_admin_approved=True).aggregate(total_stock=Sum('stock'))['total_stock']
    return total_stock

def get_category_by_pk(pk):
    return Category.objects.get(pk=pk)

def get_vendor_by_pk(pk):
    return Brand.objects.get(pk=pk)

def get_subcategory_by_pk(pk):
    return SubCategory.objects.get(pk=pk)


def get_variation_type_products(product_variants, pk, batches, api=False):
    all_variations = VariationType.objects.filter(is_deleted=False)
    return_data = {
        "has_colour": False,
        "has_size": False,
        "has_other": False,
        "has_special": False,
        "has_disabled_colour": False,
        "has_disabled_size": False,
        "has_disabled_other": False
    }

    if product_variants.filter(pk=pk, is_special_variant=False).exists():
        # means it is real product
        variant_instance = product_variants.get(pk=pk)
        variant_data, no_variants = get_variant_type_product_datas(product_variants, variant_instance, all_variations)
    else:
        # if product is special product
        variant_data, no_variants = get_variant_type_special_product_data(product_variants, all_variations)

    colour_product_variant_pks, size_product_variant_pks, other_product_variant_pks = variant_data['colour'], variant_data['size'], variant_data['other']
    other_colour_variation_pks, other_size_variation_pks, other_other_variation_pks = no_variants['colour'], no_variants['size'], no_variants['other']

    print(colour_product_variant_pks, '----------------------------------colour_product_variant_pks')
    print(size_product_variant_pks, '----------------------------------size_product_variant_pks')
    print(other_product_variant_pks, '----------------------------------other_product_variant_pks')
    print(other_colour_variation_pks, '----------------------------------other_colour_variation_pks')
    print(other_size_variation_pks, '----------------------------------other_size_variation_pks')
    print(other_other_variation_pks, '----------------------------------other_other_variation_pks')

    if product_variants.filter(pk__in=colour_product_variant_pks).exists():
        colour_serialized = VariantSerializer(product_variants.filter(pk__in=colour_product_variant_pks).order_by('auto_id'), context={"batches": batches, 'is_api': api, 'variation_type': "colour"}, many=True)
        return_data["colour_variants"] = colour_serialized.data
        return_data["has_colour"] = True

    if product_variants.filter(pk__in=size_product_variant_pks).exists():
        size_serialized = VariantSerializer(product_variants.filter(pk__in=size_product_variant_pks).order_by('auto_id'), context={"batches": batches, 'is_api': api, 'variation_type': "size"}, many=True)
        return_data["size_variants"] = size_serialized.data
        return_data["has_size"] = True

    if product_variants.filter(pk__in=other_product_variant_pks).exists():
        other_serialized = VariantSerializer(product_variants.filter(pk__in=other_product_variant_pks).order_by('auto_id'), context={"batches": batches, 'is_api': api, 'variation_type': "other"}, many=True)
        return_data["other_variants"] = other_serialized.data
        return_data["has_other"] = True

    # serialize special variants
    if product_variants.filter(is_special_variant=True).exists():
        special_serialized = VariantSerializer(product_variants.filter(is_special_variant=True), context={"batches": batches, 'is_api': api, 'variation_type': "special"}, many=True)
        return_data["special_variants"] = special_serialized.data
        return_data["has_special"] = True

    # get other variation types to show as disabled
    if len(other_colour_variation_pks) > 0 and all_variations.filter(pk__in=other_colour_variation_pks).exists():
        return_data["has_disabled_colour"] = True
        return_data["disabled_colour"] = all_variations.filter(pk__in=other_colour_variation_pks).annotate(title=F('name')).values('title')

    if len(other_size_variation_pks) > 0 and all_variations.filter(pk__in=other_size_variation_pks).exists():
        return_data["has_disabled_size"] = True
        return_data["disabled_size"] = all_variations.filter(pk__in=other_size_variation_pks).annotate(title=F('name')).values('title')

    if len(other_other_variation_pks) > 0 and all_variations.filter(pk__in=other_other_variation_pks).exists():
        return_data["has_disabled_other"] = True
        return_data["disabled_other"] = all_variations.filter(pk__in=other_other_variation_pks).annotate(title=F('name')).values('title')

    print(f"\n\n\n\n\n{return_data} \n\n\n\n")

    return return_data


def get_variant_type_product_datas(product_variants, variant_instance, all_variations):
    pk = variant_instance.pk

    colour_product_variant_pks = []
    size_product_variant_pks = []
    other_product_variant_pks = []
    other_colour_variation_pks = []
    other_size_variation_pks = []
    other_other_variation_pks = []

    if variant_instance.colour_variation:
        colour_product_variant_pks.append(str(pk))
        other_variation_pks = product_variants.exclude(colour_variation_id=variant_instance.colour_variation_id).values_list('colour_variation_id', flat=True)

        if variant_instance.size_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(colour_variation_id=var_other.pk, size_variation=variant_instance.size_variation).exists():
                    variant = product_variants.filter(colour_variation_id=var_other.pk, size_variation=variant_instance.size_variation).first()
                    colour_product_variant_pks.append(str(variant.pk))
                else:
                    other_colour_variation_pks.append(str(var_other.pk))

        elif variant_instance.other_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(colour_variation_id=var_other.pk, other_variation=variant_instance.other_variation).exists():
                    variant = product_variants.filter(colour_variation_id=var_other.pk, other_variation=variant_instance.other_variation).first()
                    colour_product_variant_pks.append(str(variant.pk))
                else:
                    other_colour_variation_pks.append(str(var_other.pk))

        else:
            for variant in product_variants.exclude(pk=pk):
                colour_product_variant_pks.append(str(variant.pk))

    if variant_instance.size_variation:
        size_product_variant_pks.append(str(pk))
        other_variation_pks = product_variants.exclude(size_variation_id=variant_instance.size_variation_id).values_list('size_variation_id', flat=True)

        if variant_instance.colour_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(size_variation_id=var_other.pk, colour_variation=variant_instance.colour_variation).exists():
                    variant = product_variants.filter(size_variation_id=var_other.pk, colour_variation=variant_instance.colour_variation).first()
                    size_product_variant_pks.append(str(variant.pk))
                else:
                    other_size_variation_pks.append(str(var_other.pk))

        elif variant_instance.other_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(size_variation_id=var_other.pk, other_variation=variant_instance.other_variation).exists():
                    variant = product_variants.filter(size_variation_id=var_other.pk, other_variation=variant_instance.other_variation).first()
                    size_product_variant_pks.append(str(variant.pk))
                else:
                    other_size_variation_pks.append(str(var_other.pk))

        else:
            for variant in product_variants.exclude(id=pk):
                size_product_variant_pks.append(str(variant.pk))

    if variant_instance.other_variation:
        other_product_variant_pks.append(str(pk))
        other_variation_pks = product_variants.exclude(other_variation_id=variant_instance.other_variation_id).values_list('other_variation_id', flat=True)

        if variant_instance.colour_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(other_variation_id=var_other.pk, colour_variation=variant_instance.colour_variation).exists():
                    variant = product_variants.filter(other_variation_id=var_other.pk, colour_variation=variant_instance.colour_variation).first()
                    other_product_variant_pks.append(str(variant.pk))
                else:
                    other_other_variation_pks.append(str(var_other.pk))

        elif variant_instance.size_variation:
            for var_other in all_variations.filter(id__in=other_variation_pks):
                if product_variants.filter(other_variation_id=var_other.pk, size_variation=variant_instance.size_variation).exists():
                    variant = product_variants.filter(other_variation_id=var_other.pk, size_variation=variant_instance.size_variation).first()
                    other_product_variant_pks.append(str(variant.pk))
                else:
                    other_other_variation_pks.append(str(var_other.pk))

        else:
            for variant in product_variants.exclude(pk=pk):
                other_product_variant_pks.append(str(variant.pk))

    variants_data = {
        "colour": colour_product_variant_pks,
        "size": size_product_variant_pks,
        "other": other_product_variant_pks
    }
    non_variations = {
        "colour": other_colour_variation_pks,
        "size": other_size_variation_pks,
        "other": other_other_variation_pks
    }
    return variants_data, non_variations


def get_variant_type_special_product_data(product_variants, all_variations):
    colour_product_variant_pks = []
    size_product_variant_pks = []
    other_product_variant_pks = []

    if product_variants.filter(Q(colour_variation__isnull=False)|Q(size_variation__isnull=False)|Q(other_variation__isnull=False)).exists():

        colour_variation_pks = []
        size_variation_pks = []
        other_variation_pks = []

        if product_variants.filter(colour_variation__isnull=False).exists():
            colour_variation_pks = product_variants.filter(colour_variation__isnull=False).values_list('colour_variation_id', flat=True)
        if product_variants.filter(size_variation__isnull=False).exists():
            size_variation_pks = product_variants.filter(size_variation__isnull=False).values_list('size_variation_id', flat=True)
        if product_variants.filter(other_variation__isnull=False).exists():
            other_variation_pks = product_variants.filter(other_variation__isnull=False).values_list('other_variation_id', flat=True)

        colour_variations = all_variations.filter(pk__in=colour_variation_pks)
        size_variations = all_variations.filter(pk__in=size_variation_pks)
        other_variations = all_variations.filter(pk__in=other_variation_pks)

        for variation in colour_variations:
            colour_product_variant_pks.append(product_variants.filter(colour_variation_id=variation.pk).first().pk)
        for variation in size_variations:
            size_product_variant_pks.append(product_variants.filter(size_variation_id=variation.pk).first().pk)
        for variation in other_variations:
            other_product_variant_pks.append(product_variants.filter(other_variation_id=variation.pk).first().pk)

    variants_data = {
        "colour": colour_product_variant_pks,
        "size": size_product_variant_pks,
        "other": other_product_variant_pks
    }
    non_variations = {"colour": [], "size": [], "other": []}

    return variants_data, non_variations


def special_variant_stock(variant_instance, zone=None):
    available_stock = 0
    special_variant = variant_instance.special_variant_added
    variants = special_variant.product_variant.all()
    all_batches = Batch.objects.filter(product_variant__in=variants, stock__gt=0, is_deleted=False)
    if zone:
        all_batches = all_batches.filter(warehouse__deliverable_location=zone)

    for variant_item in variants:
        if not all_batches.filter(product_variant_id=variant_item.pk).exists():
            return 0
        stock = all_batches.filter(product_variant_id=variant_item.pk).aggregate(stock=Sum('stock')).get('stock', 0)
        available_stock = min(stock, available_stock) if available_stock else stock

    return available_stock
