from rest_framework import serializers
from warehouses.models import Location, Zone



class LocationSerializer(serializers.ModelSerializer):

    is_default = serializers.SerializerMethodField()

    class Meta:
        model = Zone
        fields = ['pk','name', 'is_default', 'pincode', 'district']

    def get_is_default(self,instances):
        request = self.context.get("request")
        zone_session = request.session.get('zone', '')
        if zone_session:
            if zone_session == instances.pk:
                return True
            else:
                return False
        else:
            return False
