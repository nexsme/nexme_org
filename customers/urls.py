from django.contrib import admin
from django.urls import path, re_path, include
from .import views
from customers.views import CustomerAutocomplete, CustomerAddressAutocomplete

app_name = 'api_v1_customers'

urlpatterns = [
    re_path(r'^customer-autocomplete/$', CustomerAutocomplete.as_view(), name='customer_autocomplete'),
    re_path(r'^address-autocomplete/$', CustomerAddressAutocomplete.as_view(), name='address_autocomplete'),

    re_path(r'^create/$', views.create, name='create'),
    re_path(r'^customers/$', views.customers, name='customers'),
    re_path(r'^edit/(?P<pk>.*)/$', views.edit, name='edit'),
    re_path(r'^view/(?P<pk>.*)/$', views.customer, name='customer'),
    re_path(r'^delete/(?P<pk>.*)/$', views.delete, name='delete'),

    re_path(r'^get-customer/$', views.get_customer, name='get_customer'),
    re_path(r'^get-customers/$', views.get_customers, name='get_customers'),
    re_path(r'^get-balance/$',views.get_balance, name='get_balance'),

    re_path(r'^customer-revoke-access/(?P<pk>.*)/$', views.revoke_access, name='revoke_access'),
    re_path(r'^customer-save-address/$', views.save_address, name='save_address'),

    re_path(r'^update-privilege-point/$', views.create_privilege_point, name='create_privilege_point'),
    re_path(r'^privilege-point/$', views.privilege_point, name='privilege_point'),
    re_path(r'^delete-privilege-point/(?P<pk>.*)/$', views.delete_privilege_point, name='delete_privilege_point'),

    re_path(r'^pending-tickets/$', views.pending_tickets, name='pending_tickets'),
    re_path(r'^in_progress-tickets/$', views.in_progress_tickets, name='in_progress_tickets'),
    re_path(r'^mark-as-inprogress/(?P<pk>.*)/$', views.mark_as_inprogress, name='mark_as_inprogress'),
    re_path(r'^reject-ticket/(?P<pk>.*)/$', views.reject_ticket, name='reject_ticket'),
    re_path(r'^mark-as-solved-ticket/(?P<pk>.*)/$', views.mark_as_solved_ticket, name='mark_as_solved_ticket'),
    re_path(r'^rejected-tickets/$', views.rejected_tickets, name='rejected_tickets'),
    re_path(r'^solved-tickets/$', views.solved_tickets, name='solved_tickets'),

    re_path(r'^export-to-excel/$', views.export_to_excel, name='export_to_excel'),
    re_path(r'^customer-to-pdf/$', views.customer_to_pdf, name='customer_to_pdf'),
]
