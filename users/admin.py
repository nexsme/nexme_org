from django.contrib import admin

from users.models import *


admin.site.register(Wishlistitem)
admin.site.register(CartItem)

@admin.action(description="Mark selected stories as published")
def make_active_and_unread(self, request, queryset):
    queryset.update(is_active=True, is_read=False,is_visited=False,is_deleted=False)
make_active_and_unread.short_description = "Mark selected notifications as active and unread"
class NotificationAdmin(admin.ModelAdmin):
    list_filter = ['user']
    list_display = ['message','is_active']
    actions = [make_active_and_unread]


admin.site.register(Notification, NotificationAdmin)
