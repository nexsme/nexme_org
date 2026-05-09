from django.contrib import admin

from purchases.models import *

admin.site.register(Purchase)
admin.site.register(PurchaseItem)

admin.site.register(PurchaseOrder)
admin.site.register(PurchaseOrderItem)