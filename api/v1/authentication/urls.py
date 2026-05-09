from django.conf.urls import url, include
from django.urls import path, re_path
from rest_framework_simplejwt.views import (TokenRefreshView,)
from . import views


urlpatterns = [
    path('token/', views.UserTokenObtainPairView.as_view(),
         name='token_obtain_pair'),
    path('refresh/', TokenRefreshView.as_view(), name='token_refresh'),

    re_path(r'^deactivate-account/$', views.deactivate_account, name='deactivate_account'),
]
