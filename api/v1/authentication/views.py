from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from api.v1.authentication.serializers import UserTokenObtainPairSerializer


class UserTokenObtainPairView(TokenObtainPairView):
    serializer_class = UserTokenObtainPairSerializer


@api_view(['GET'])
def deactivate_account(request):
    user = request.user
    user.username += '__deleted__' + str(user.id)
    user.email += '__deleted__' + str(user.id)
    user.is_active = False
    user.save()

    try:
        customer = user.customer

        customer.phone = '00000000'
        customer.is_deleted = True
        customer.save()

    except Exception as e:
        print(f'\n\n\n\n\n{e}\n\n\n\n')

    response_data = {
        "StatusCode": 6000,
        'data': {
            'title': 'Successfully deleted user',
            'message': 'Successfully deleted user',
        }
    }

    return Response(response_data, status=status.HTTP_200_OK)