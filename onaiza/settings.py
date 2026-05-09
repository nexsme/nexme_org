import os
import environ
from datetime import timedelta

import firebase_admin
from pathlib import Path
from decouple import config, Csv
from firebase_admin import credentials

from django.utils.translation import ugettext_lazy as _

env = environ.Env()
environ.Env.read_env()

BASE_DIR = Path(__file__).resolve().parent.parent

environ.Env.read_env(os.path.join(BASE_DIR, '.env'))

DEBUG = env('DEBUG')
SERVER = env('SERVER')

SECRET_KEY = env('SECRET_KEY')

ALLOWED_HOSTS = ['nexsme.com']

PLACES_MAPS_API_KEY = 'AIzaSyBlZedPGDv2kGpzevN9Q43ZyXHAXUby67w'

INSTALLED_APPS = [
    'dal',
    'mailqueue',
    'xhtml2pdf',
    'fcm_django',
    'dal_select2',
    'registration',
    'el_pagination',
    'rest_framework',
    'keyboard_shortcuts',
    'versatileimagefield',
    'django_template_maths',
    # 'pwa',

    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'main',
    'users',
    'products',
    'warehouses',
    'staffs',
    'sales',
    'purchases',
    'customers',
    'vendors',
    'suppliers',
    'finance',
    'orders',
    'web',
    'offers',
    'delivery_agent',
    'reports',
    'general'
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.locale.LocaleMiddleware',
]

ROOT_URLCONF = 'onaiza.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [Path(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'web.context_processors.web_context',
                'main.context_processors.main_context',
            ],
        },
    },
]


SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(days=210),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=730),
    'ROTATE_REFRESH_TOKENS': True,
    'BLACKLIST_AFTER_ROTATION': True
}

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 2,
}

WSGI_APPLICATION = 'onaiza.wsgi.application'

DATABASES = {
    'default': {
        # 'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': config('DB_NAME'),
        'USER': config('DB_USER'),
        'PASSWORD': config('DB_PASSWORD'),
        'HOST': config('DB_HOST'),
        'PORT': config('DB_PORT'),
    }
}
DEBUG_TOOLBAR_CONFIG = {
    'SHOW_TOOLBAR_CALLBACK': lambda request: DEBUG,
}

# DATABASES = {
#     'default': env.db(),

#     # 'extra': env.db_url(
#     #     'SQLITE_URL',
#     #     default='sqlite:////tmp/my-tmp-sqlite.db'
#     # )
# }

# DATABASES = {
#     'default': env.db(),

#     # 'extra': env.db_url(
#     #     'SQLITE_URL',
#     #     default='sqlite:////tmp/my-tmp-sqlite.db'
#     # )
# }

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

LOCALE_PATHS = (
    Path(BASE_DIR, 'locale'),
)
LANGUAGES = (
    ('ml', _('Malayalam')),
    ('en', _('English')),
    ('ar', _('Arabic')),
)
LANGUAGE_CODE = 'en-us'

LOGIN_URL = '/app/accounts/login/'
LOGOUT_URL = '/app/accounts/logout/'
LOGIN_REDIRECT_URL = '/app/dashboard/'
LOGOUT_REDIRECT_URL = ''

TIME_ZONE = 'Asia/Kolkata'

USE_I18N = True

USE_L10N = True

USE_TZ = True

MEDIA_URL = '/media/'
MEDIA_ROOT = Path(BASE_DIR, "media")
STATIC_URL = '/static/'
STATIC_ROOT = (BASE_DIR / 'static' / 'static')
STATIC_FILE_ROOT = Path(BASE_DIR, "static")
STATICFILES_DIRS = (
    Path(BASE_DIR, "static"),
)


# PWA_SERVICE_WORKER_PATH = Path(BASE_DIR, 'static/js', 'serviceworker.js')
PWA_SERVICE_WORKER_PATH = os.path.join(BASE_DIR, 'static/js', 'serviceworker.js')
PWA_APP_NAME = 'Onaiza'
PWA_APP_DESCRIPTION = "ONAIZA PWA"
PWA_APP_THEME_COLOR = '#000000'
PWA_APP_BACKGROUND_COLOR = '#ffffff'
PWA_APP_DISPLAY = 'standalone'
PWA_APP_SCOPE = '/en/app/'
PWA_APP_ORIENTATION = 'any'
PWA_APP_START_URL = '/en/app/'
PWA_APP_STATUS_BAR_COLOR = 'orange'

PWA_APP_ICONS = [
    {
        'src': '/static/web/images/icons/onaiza-fav-icon.png',
        'sizes': '160x160'
    },
    {
        "src": "/static/web/images/icons/android-chrome-192x192.png",
        "sizes": "192x192",
        "type": "image/png"
    },
    {
        "src": "/static/web/images/icons/android-chrome-512x512.png",
        "sizes": "512x512",
        "type": "image/png",
    },
    {
        "src": "/static/web/images/icons/android-chrome-maskable-192x192.png",
        "sizes": "192x192",
        "type": "image/png",
        "purpose": "maskable"
    },
    {
        "src": "/static/web/images/icons/android-chrome-maskable-512x512.png",
        "sizes": "512x512",
        "type": "image/png",
        "purpose": "maskable"
    }
]
PWA_APP_ICONS_APPLE = [
    {
        'src': '/static/web/images/icons/onaiza-fav-icon.png',
        'sizes': '160x160'
    }
]
PWA_APP_SPLASH_SCREEN = [
    {
        'src': '/static/images/icon.png',
        'media': '(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)'
    }
]
PWA_APP_DIR = 'ltr'
PWA_APP_LANG = 'en-US'
# =========PWA END========

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

VERSATILEIMAGEFIELD_SETTINGS = {
    'cache_length': 2592000,
    'cache_name': 'versatileimagefield_cache',
    'jpeg_resize_quality': 70,
    'sized_directory_name': '__sized__',
    'filtered_directory_name': '__filtered__',
    'placeholder_directory_name': '__placeholder__',
    'create_images_on_demand': True,
    'image_key_post_processor': None,
    'progressive_jpeg': False
}


PASSWORD_ENCRYPTION_KEY = 'a54MqS4Re_tP6nlVYX6fBBAc025sztJw6URlW35vxCY='
RZP_ID_KEY = 'rzp_test_xXz5zxppS2b41C'
RZP_SECRET_KEY = 'rjbhtzY9knrsW745a5ng4kqw'


# START keyboard_shortcuts settings #
HOTKEYS = [
    {
        'keys': 'alt + d',    # go home
        'link': '/app'
    },
]

SPECIAL_DISABLED = True
# END keyboard_shortcuts settings #

EL_PAGINATION_NEXT_LABEL = '>'

#email configuration
EMAIL_USE_TLS = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_HOST_USER = 'Nexsme@gmail.com'
EMAIL_HOST_PASSWORD = 'rjbqafkmnvskiolb'
EMAIL_PORT = 587
DEFAULT_FROM_EMAIL = 'Nexsme@gmail.com'
DEFAULT_BCC_EMAIL = 'Nexsme@gmail.com'

DEFAULT_REPLY_TO_EMAIL = 'Nexsme@gmail.com'
SERVER_EMAIL = 'Nexsme@gmail.com'
ADMIN_EMAIL = 'Nexsme@gmail.com'


#twilio configuration
# TWILIO_ACCOUNT_SID = env("TWILIO_ACCOUNT_SID", cast=[str])
# TWILIO_AUTH_TOKEN = env("TWILIO_AUTH_TOKEN", cast=[str])
# TWILIO_PHONE_NUMBER = env("TWILIO_PHONE_NUMBER", cast=[str])

TWILIO_ACCOUNT_SID='AC3ded81b10b4067ed2a08a1b0fe704813'
TWILIO_AUTH_TOKEN='64d7b7247ba72b943f39247ff9d1e8c5'
TWILIO_PHONE_NUMBER='+17175395564'


FCM_DJANGO_SETTINGS = {
    "APP_VERBOSE_NAME": "nexsme",
    "ONE_DEVICE_PER_USER": False,
    "DELETE_INACTIVE_DEVICES": True,
    "UPDATE_ON_DUPLICATE_REG_ID": True,
}

RAZORPAY_API_KEY=env('RAZORPAY_API_KEY')
RZP_SECRET_KEY=env('RZP_SECRET_KEY')

RAZORPAY_API_KEY= config('RAZORPAY_API_KEY')
RZP_SECRET_KEY= config('RZP_SECRET_KEY')


cred = credentials.Certificate(BASE_DIR / 'ServiceAccount.json')
default_app = firebase_admin.initialize_app(cred)


FAST2SMS_API_KEY = 'vn6DOCyoxQwPbKWFV4GLXeH3Y2Z1SgBkTpm7iIUh5r0Asj8uaMegIWO9P3J65lfMw2AEahrxLdp0VHoZ'