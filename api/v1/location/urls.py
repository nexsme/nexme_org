from django.conf.urls import url, re_path

from . import views

urlpatterns = [
    url(r'^get-zones/$', views.get_zones, name='get_zones'),
    url(r'^set-location/$', views.set_location, name='set_location'),
]