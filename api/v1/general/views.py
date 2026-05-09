import json
from operator import itemgetter
from django.db.models import Count, F
from django.db.models import Q
from rest_framework import status
from rest_framework.decorators import (api_view, permission_classes, renderer_classes)
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response

from api.v1.general.banner_utils import BannerUtils
from api.v1.general.functions import is_zone_exists, get_zone, get_shop_category_instances
from api.v1.general.serializers import *
from main.models import AppUpdate, DeliveryAppUpdate
from main.functions import paginate
from offers.models import Offers
from products.models import Category, ProductVariant
from products.functions import get_variation_type_products
from web.models import ProductReview


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def offer_sliders(request):
    instances = Offers.objects.filter(is_deleted=False)

    if is_zone_exists(request):
        zone = get_zone(request)
        instances = instances.filter(warehouse__deliverable_location__in=[zone])

    serialized = OfferSlidersSerializer(instances, context={"request": request}, many=True)

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def get_latest_category_offer(request):
    instances = Offers.objects.filter(is_deleted=False, offer_type__in=['category', 'sub_category']).first()

    if is_zone_exists(request):
        zone = get_zone(request)
        instances = Offers.objects.filter(is_deleted=False, offer_type__in=['category', 'sub_category'], warehouse__deliverable_location__in=[zone]).first()

    serialized = OfferSlidersSerializer(instances, context={"request": request})

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def categories(request):
    categories = Category.objects.filter(is_deleted=False)
    instances = categories.annotate(product_count=Count('product__productvariant')).order_by('-product_count')

    serialized = CategorySerializer(instances, context={"request": request}, many=True)

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)



@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def sub_categories(request):
    category = request.GET.get('category')
    product_category = None

    try:
        category = category.replace('/', '') if category else None
    except:
        pass

    categories = Category.objects.filter(pk=category,is_deleted=False)

    if categories:
        product_category = Category.objects.get(pk=category,is_deleted=False)

    if product_category:
        instances = SubCategory.objects.filter(category=category,is_deleted=False)
        serialized = SubCategorySerializer(instances, context={"request": request}, many=True)

        response_data = {"StatusCode": 6000, "data": serialized.data}
    else:
        response_data = {"StatusCode": 6000, "message": "Category not found"}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def best_sellers(request):
    minimal = request.GET.get('minimal')
    query = request.GET.get('query')
    category = request.GET.get('category')
    sub_category = request.GET.get('sub_category')
    sort = request.GET.get('sort')
    page = request.GET.get('page')
    paginator = None

    try:
        category = category.replace('/', '') if category else None
        sub_category = sub_category.replace('/', '') if sub_category else None
        sort = sort.replace('/', '') if sort else None
    except:
        pass

    variants = ProductVariant.objects.filter(is_default=True, is_deleted=False, is_admin_approved=True, product__is_active=True)

    # get the best sellers item on the basis of order+sale count
    product_instances = variants.annotate(order_count=Count('orderitem'), sale_count=Count('saleitem'),
        total_count=F('sale_count') + F('order_count')).order_by('-total_count')

    if minimal:
        product_instances = product_instances[:1]

    if query:
        product_instances = product_instances.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query) |
            Q(product__brand__name__icontains=query) |
            Q(product__category__name__icontains=query) |
            Q(product__subcategory__name__icontains=query)
        )
    if category:
        product_instances = product_instances.filter(product__category__pk=category)

    if sub_category:
        product_instances = product_instances.filter(product__subcategory__pk=sub_category)

    #for pagination
    if page:
        product_instances, paginator = paginate(product_instances, request)

    serialized = BestSellersSerializer(product_instances, context={"request": request}, many=True)

    serialized_data = serialized.data

    if sort:
        try:
            if 'a-z' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'))
            elif 'z-a' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'), reverse=True)
            elif 'price_increase' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'))
            elif 'price_decrease' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'), reverse=True)

        except Exception as e:
            print('--------------------\n\n\n\n', e, '\n\n\n\n-----------------------')

    response_data = {"StatusCode": 6000, "data": serialized_data, "paginator": paginator}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def nearest_shops(request):
    instances = Vendor.objects.filter(is_deleted=False)

    query = request.GET.get('query')

    if query:
        query = query.replace('/', '')
        instances = instances.filter(name__icontains=query)

    # instances =  instances[:5]

    serialized = ShopSerializer(instances, context={"request": request}, many=True)

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def best_offers(request):
    instances = None
    today = datetime.datetime.now()

    query = request.GET.get('query')

    instances = Offers.objects.filter(offer_type="product", is_deleted=False, start_time__lte=today, end_time__gte=today).order_by('-date_added')

    if is_zone_exists(request):
        zone = get_zone(request)
        instances = instances.filter(warehouse__deliverable_location__in=[zone])

    if query:
        query = query.replace('/', '')
        instances = instances.filter(
            Q(product_variant__title__icontains=query) |
            Q(product_variant__product__name__icontains=query) |
            Q(product_variant__product__brand__name__icontains=query) |
            Q(product_variant__product__category__name__icontains=query) |
            Q(product_variant__product__subcategory__name__icontains=query)
        )

    serialized = BestOfferSerializer(instances, context={"request": request}, many=True)

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def product(request, pk):
    instance = ProductVariant.objects.get(pk=pk)

    serialized = ProductVariantSerializer(instance, context={"request": request})

    # multiple variants of this product
    zone_session = request.session.get('zone', '')
    if zone_session:
        all_batch = Batch.objects.filter(is_deleted=False, product_variant__product_id=instance.product_id, warehouse__deliverable_location__in=[zone_session])
    else:
        all_batch = Batch.objects.filter(is_deleted=False, product_variant__product_id=instance.product_id)

    variants = ProductVariant.objects.filter(product_id=instance.product_id, is_admin_approved=True, product__is_active=True, is_deleted=False)
    variations = get_variation_type_products(variants, pk, all_batch, api=True)
    # multiple variants of this product

    response_data = {"StatusCode": 6000, "data": serialized.data, 'variations': variations}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def shops(request):
    query = request.GET.get('query')

    instances = Vendor.objects.filter(is_deleted=False)

    if is_zone_exists(request):
        zone = get_zone(request)
        instances = Vendor.objects.filter(is_deleted=False, zone__pk=zone)

    if query:
        instances = instances.filter(name__icontains=query)

    serialized = ShopSerializer(instances, context={"request": request}, many=True)

    response_data = {"StatusCode": 6000, "data": serialized.data}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def shop(request, pk):
    query = request.GET.get('query')
    sort = request.GET.get('sort')
    category = request.GET.get('category')
    sub_category = request.GET.get('sub_category')

    if Vendor.objects.filter(pk=pk).exists():
        shop_instances = Vendor.objects.get(pk=pk)

        instances = ProductVariant.objects.filter(is_deleted=False, product__vendor=shop_instances, is_admin_approved=True, product__is_active=True).order_by("-auto_id")
        category_instances = get_shop_category_instances(instances)

        if query:
            query = query.replace('/','')
            instances = instances.filter(Q(title__icontains=query) | Q(product__name__icontains=query) | Q(
                product__brand__name__icontains=query) | Q(product__category__name__icontains=query) | Q(
                product__subcategory__name__icontains=query))

        if category:
            category = category.replace('/','')
            instances = instances.filter(product__category__pk=category)

        if sub_category:
            sub_category = sub_category.replace('/','')
            instances = instances.filter(product__subcategory__pk=sub_category)

        instances, paginator = paginate(instances, request)

        shop_serialized = ShopSerializer(shop_instances, context={"request": request})
        serialized = BestSellersSerializer(instances, context={"request": request}, many=True)
        category_serialized = CategorySerializer(category_instances, context={"request": request}, many=True)

        serialized_data = serialized.data

        if sort:
            try:
                if 'a-z' in sort:
                    serialized_data = sorted(serialized_data, key = itemgetter('title'))
                    # product_instances = product_instances.order_by("title")
                elif 'z-a' in sort:
                    serialized_data = sorted(serialized_data, key = itemgetter('title'), reverse=True)
                    # product_instances = product_instances.order_by("-title")
                elif 'price_increase' in sort:
                    serialized_data = sorted(serialized_data, key = itemgetter('retail_price'))
                    # product_instances = product_instances.order_by("mrp")
                elif 'price_decrease' in sort:
                    serialized_data = sorted(serialized_data, key = itemgetter('retail_price'), reverse=True)
                    # product_instances = product_instances.order_by("-mrp")

            except Exception as e:
                print('--------------------\n\n\n\n', e, '\n\n\n\n-----------------------')

        serialized_data = serialized_data[:30] # to get only 30 variants

        response_data = {
            "StatusCode": 6000,
            "shop": shop_serialized.data,
            "data": serialized_data,
            "categories": category_serialized.data,
            "paginator" : paginator
        }
    else:
        response_data = {"StatusCode": 6001, "message": "Shop Not Found", "arabic_message": "المتجر غير موجود",}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def search(request):
    instances = ProductVariant.objects.filter(is_deleted=False, is_default=True, is_admin_approved=True, product__is_active=True).order_by("-auto_id")

    query = request.GET.get('query')
    sort = request.GET.get('sort')
    category = request.GET.get('category')
    sub_category = request.GET.get('sub_category')
    page = request.GET.get('page')
    paginator = None

    if query:
        query = query.replace('/', '')
        instances = instances.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query) |
            Q(product__brand__name__icontains=query) |
            Q(product__category__name__icontains=query) |
            Q(product__subcategory__name__icontains=query)
        )

    if category:
        category = category.replace('/', '')
        instances = instances.filter(product__category__pk=category)

    if sub_category:
        sub_category = sub_category.replace('/', '')
        instances = instances.filter(product__subcategory__pk=sub_category)

    if page:
        instances, paginator = paginate(instances, request)

    serialized = BestSellersSerializer(instances, many=True, context={"request": request})

    serialized_data = serialized.data

    if sort:
        try:
            if 'a-z' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'))
            elif 'z-a' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'), reverse=True)
            elif 'price_increase' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'))
            elif 'price_decrease' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'), reverse=True)

        except Exception as e:
            print('--------------------\n\n\n\n', e, '\n\n\n\n-----------------------')


    response_data = {"StatusCode": 6000, "results": serialized_data, "paginator": paginator}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def featured_products(request):
    product_instances = ProductVariant.objects.filter(is_deleted=False, is_default=True, is_admin_approved=True, is_featured=True).order_by("-auto_id")

    query = request.GET.get('query')
    category = request.GET.get('category')
    sub_category = request.GET.get('sub_category')
    sort = request.GET.get('sort')
    page = request.GET.get('page')
    paginator = None

    try:
        category = category.replace('/', '') if category else None
        sub_category = sub_category.replace('/', '') if sub_category else None
        sort = sort.replace('/', '') if sort else None
    except:
        pass

    if query:
        product_instances = product_instances.filter(
            Q(title__icontains=query) |
            Q(product__name__icontains=query) |
            Q(product__brand__name__icontains=query) |
            Q(product__category__name__icontains=query) |
            Q(product__subcategory__name__icontains=query)
        )
    if category:
        product_instances = product_instances.filter(product__category__pk=category)

    if sub_category:
        product_instances = product_instances.filter(product__subcategory__pk=sub_category)

    if page:
        product_instances, paginator = paginate(product_instances, request)

    serialized = BestSellersSerializer(product_instances, many=True, context={"request": request})

    serialized_data = serialized.data

    if sort:
        try:
            if 'a-z' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'))
            elif 'z-a' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('title'), reverse=True)
            elif 'price_increase' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'))
            elif 'price_decrease' in sort:
                serialized_data = sorted(serialized_data, key = itemgetter('retail_price'), reverse=True)

        except Exception as e:
            print('--------------------\n\n\n\n', e, '\n\n\n\n-----------------------')

    response_data = {"StatusCode": 6000, "results": serialized_data, "paginator": paginator}

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def product_reviews(request, pk):
    product_current_rating_count = ProductVariant.objects.get(pk=pk)
    instances = ProductReview.objects.filter(product_variant__pk=pk)

    instances_count = instances.count()

    ratings = {"rating": str(round(product_current_rating_count.current_rating, 1)),
        "no_of_customers_rated": str(instances_count), }

    paginator = PageNumberPagination()
    paginator.page_size = 2
    result_page = paginator.paginate_queryset(instances, request)

    serialized = ProductReviewSerializer(instances, context={"request": request}, many=True)

    return paginator.get_paginated_response(serialized.data)


@api_view(['GET'])
@renderer_classes((JSONRenderer,))
def app_update(request):
    latest_instance = None
    os = request.GET.get('os')
    if AppUpdate.objects.exists():
        latest_instance = AppUpdate.objects.first()
    if latest_instance:
        if os == 'android':
            serialized = AppAndroidUpdateSerializer(latest_instance, context={"request": request})
            response_data = {
                "StatusCode": 6000,
                "data": serialized.data
            }
        elif os == 'ios':
            serialized = AppIOSUpdateSerializer(latest_instance, context={"request": request})
            response_data = {
                "StatusCode": 6000,
                "data": serialized.data
            }
        else:
            response_data = {
                "StatusCode": 6001,
                "message": "Invalid OS"
            }

    else:
        response_data = {
            "StatusCode": 6001,
            "message": "Version not found"
        }

    return Response(response_data, status=status.HTTP_200_OK)


@api_view(['GET'])
@permission_classes((AllowAny,))
@renderer_classes((JSONRenderer,))
def banners(request):
    banner_type = request.GET.get('banner_type', None)
    banner_utils = BannerUtils(banner_type, request)
    data = banner_utils.serialized_datas()

    response_data = {"StatusCode": 6000, "data": data}

    return Response(response_data, status=status.HTTP_200_OK)
