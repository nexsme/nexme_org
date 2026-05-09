from django.core.validators import RegexValidator


phone_regex = RegexValidator(
    regex=r'^\+?1?\d{10}$', message="Not a valid number, 10 digits required")