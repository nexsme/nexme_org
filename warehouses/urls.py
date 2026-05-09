from django.urls import path, re_path
from warehouses import views
from warehouses.views import WarehouseAutocomplete, ToWarehouseAutocomplete, LocationAutocomplete, WarehouseLocationAutocomplete, ZoneAutocomplete

app_name = "warehouses"


urlpatterns = [
    re_path(r'^warehouse-autocomplete/$', WarehouseAutocomplete.as_view(),name='warehouse_autocomplete'),
    re_path(r'^towarehouse-autocomplete/$', ToWarehouseAutocomplete.as_view(),name='towarehouse_autocomplete'),
    re_path(r'^location-autocomplete/$', LocationAutocomplete.as_view(),name='location_autocomplete'),
    re_path(r'^zone-autocomplete/$', ZoneAutocomplete.as_view(),name='zone_autocomplete'),
    re_path(r'^warehouse-location-autocomplete/$', WarehouseLocationAutocomplete.as_view(),name='warehouse_location_autocomplete'),

    re_path(r'^create-warehouse/$', views.create_warehouse,name='create_warehouse'),
    re_path(r'^warehouses/$', views.warehouses, name='warehouses'),
    re_path(r'^edit-warehouse/(?P<pk>.*)/$',views.edit_warehouse, name='edit_warehouse'),
    re_path(r'^view-warehouse/(?P<pk>.*)/$',views.warehouse, name='warehouse'),
    re_path(r'^delete-warehouse/(?P<pk>.*)/$',views.delete_warehouse, name='delete_warehouse'),
    re_path(r'^delete-selected-warehouses/$', views.delete_selected_warehouses,name='delete_selected-warehouses'),

    re_path(r'^set/deliverable-locations/(?P<pk>.*)/$',views.set_locations, name='set_locations'),
    re_path(r'^set/non-deliverable-locations/(?P<pk>.*)/$',views.set_non_deliverable_locations, name='set_non_deliverable_locations'),

    re_path(r'^create-location/$', views.create_location,name='create_location'),
    re_path(r'^locations/$', views.locations, name='locations'),
    re_path(r'^edit-location/(?P<pk>.*)/$',views.edit_location, name='edit_location'),
    re_path(r'^view-location/(?P<pk>.*)/$',views.location, name='location'),
    re_path(r'^delete-location/(?P<pk>.*)/$',views.delete_location, name='delete_location'),
    re_path(r'^delete-selected-locations/$', views.delete_selected_locations,name='delete_selected-locations'),

    re_path(r'^get-warehouse-variant/$', views.get_warehouse_variant,name='get_warehouse_variant'),
    re_path(r'^our-orders/$',views.our_orders, name='our_orders'),

    re_path(r'^zones/$', views.zones, name='zones'),
    re_path(r'^view-zone/(?P<pk>.*)/$',views.zone, name='zone'),

    re_path(r'^create-warehouse-delivery/$', views.create_warehouse_delivery, name='create_warehouse_delivery'),
    re_path(r'^warehouse-delivery-charges/$', views.warehouse_delivery_charges, name='warehouse_delivery_charges'),
    re_path(r'^warehouse-delivery/(?P<pk>.*)/$', views.warehouse_delivery, name='warehouse_delivery'),
    re_path(r'^edit-warehouse-delivery/(?P<pk>.*)/$', views.edit_warehouse_delivery, name='edit_warehouse_delivery'),
    re_path(r'^delete-warehouse-delivery/(?P<pk>.*)/$', views.delete_warehouse_delivery, name='delete_warehouse_delivery'),
]
