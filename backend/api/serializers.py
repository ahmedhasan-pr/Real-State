from rest_framework import serializers
from .models import Apartments, Featuredproperty, House , Notification, Plotsofland
from django.contrib.auth import authenticate

class HouseSerializer(serializers.ModelSerializer):
    class Meta:
        model = House
        fields = '__all__'
        
class ApartmentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Apartments
        fields = '__all__'
class PlotsoflandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plotsofland
        fields = '__all__'
class FeaturedpropertySerializer(serializers.ModelSerializer):
    class Meta:
        model = Featuredproperty
        fields = '__all__'


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(required=True)
    password = serializers.CharField(required=True,write_only = True)


class LoginSerializer(serializers.Serializer):
    username = serializers.EmailField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        print(f"Received data: {data}")  # لطباعة البيانات المستلمة
        user = authenticate(username=data.get('username'), password=data.get('password'))
        
        if user is None:
            raise serializers.ValidationError("بيانات الاعتماد غير صحيحة")
        
        return {'user': user}


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = '__all__'