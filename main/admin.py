from django.contrib import admin
from products.models import *
from main.models import AppUpdate, DeliveryAppUpdate


admin.site.register(ProductImages)
admin.site.register(AppUpdate)
admin.site.register(DeliveryAppUpdate)
