from django.conf.urls import  url,include
from django.urls import re_path
from main import views

app_name = "main"

urlpatterns = [
    url(r'^$', views.dashboard, name='dashboard'),
    url(r'^switch-language/$', views.switch_language, name='switch_language'),
    url(r'^check-password-policy/$', views.check_password_policy, name='check_password_policy'),

    url(r'^search/$', views.search, name='search'),
    
    re_path(r"^company-profile/create/$", views.company_profile_create, name="company_profile_create"),
    re_path(r"^company-profile/list/$", views.company_profile_list, name="company_profile_list"),
    re_path(r"^company-profile/info/(?P<pk>.*)/$",views.company_profile_info,name="company_profile_info",),
    re_path(r"^company-profile/edit/(?P<pk>.*)/$",views.company_profile_edit,name="company_profile_edit",),
    re_path(r"^company-profile/delete/(?P<pk>.*)/$", views.company_profile_delete, name="company_profile_delete"),
]
