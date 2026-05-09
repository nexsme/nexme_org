from django.urls import path, re_path
from django.conf.urls import url, include
from orders import views
from .views import TimeSlotAutocomplete


app_name = "orders"

urlpatterns = [
    re_path(r'^timeslots-autocomplete/$', TimeSlotAutocomplete.as_view(),name='timeslot_autocomplete'),

    re_path(r'^create-time-slot/$', views.create_time_slot, name='create_time_slot'),
    re_path(r'^time-slots/$', views.time_slots, name='time_slots'),
    re_path(r'^time-slot/(?P<pk>.*)/$', views.time_slot, name='time_slot'),
    re_path(r'^edit-time-slot/(?P<pk>.*)/$', views.edit_time_slot, name='edit_time_slot'),
    re_path(r'^status-time-slot/(?P<pk>.*)/$', views.status_time_slot, name='status_time_slot'),
    re_path(r'^delete-time-slot/(?P<pk>.*)/$', views.delete_time_slot, name='delete_time_slot'),

    re_path(r'^(?P<order_type>.*)-orders/$', views.orders, name='orders'),
    re_path(r'^order/(?P<pk>.*)/$', views.order, name='order'),
    re_path(r'^assign-agent/$', views.assign_agent, name='assign_agent'),

    re_path(r'^create-order/$', views.create_order, name='create_order'),

    re_path(r'^bookings/$', views.bookings, name='bookings'),
    re_path(r'^booking/(?P<pk>.*)/$', views.booking, name='booking'),
    re_path(r'^accept_booking/(?P<pk>.*)/(?P<address_pk>.*)/$', views.accept_booking, name='accept_booking'),
    re_path(r'^accepted-bookings/$', views.accepted_bookings, name='accepted_bookings'),

    re_path(r'^returns/$', views.returns, name='returns'),
    re_path(r'^product-return/(?P<pk>.*)/$', views.product_return, name='product_return'),
    re_path(r'^accept-or-reject-return/$', views.accept_or_reject_return, name='accept_or_reject_return'),
    re_path(r'^assign-agent-for-return/$', views.assign_agent_for_return, name='assign_agent_for_return'),
    re_path(r'^product-recieved/$', views.product_recieved, name='product_recieved'),
    re_path(r'^change-order-status/(?P<pk>.*)/$', views.change_order_status, name='change_order_status'),

    re_path(r'^print-order/(?P<view_type>.*)-view/(?P<pk>.*)/$', views.print_order_invoice, name='print_order_invoice'),
    re_path(r'^print-A4/(?P<pk>.*)/$', views.print_sale_order_a4, name='print_sale_order_a4'),

    re_path(r'^create-delivery-charge/$', views.create_delivery_charge, name='create_delivery_charge'),
    re_path(r'^delivery-charges/$', views.delivery_charges, name='delivery_charges'),
    re_path(r'^delivery-charge/(?P<pk>.*)/$', views.delivery_charge, name='delivery_charge'),
    re_path(r'^edit-delivery-charge/(?P<pk>.*)/$', views.edit_delivery_charge, name='edit_delivery_charge'),
    re_path(r'^delete-delivery-charge/(?P<pk>.*)/$', views.delete_delivery_charge, name='delete_delivery_charge'),

    re_path(r'^create-minimum-charge/$', views.create_minimum_charge, name='create_minimum_charge'),
    re_path(r'^minimum-charges/$', views.minimum_charges, name='minimum_charges'),
    re_path(r'^edit-minimum-charge/(?P<pk>.*)/$', views.edit_minimum_charge, name='edit_minimum_charge'),
    re_path(r'^delete-minimum-charge/(?P<pk>.*)/$', views.delete_minimum_charge, name='delete_minimum_charge'),
]
