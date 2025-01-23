from rest_framework import serializers
from .models import Apartments, Featuredproperty, House , Notification, Plotsofland
from django.contrib.auth import authenticate
from django.contrib.auth.models import User

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







class SignupSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=100, required=True, help_text="اسم المستخدم.")
    email = serializers.EmailField(help_text="البريد الإلكتروني.")
    password = serializers.CharField(write_only=True, help_text="كلمة المرور.")
    confirm_password = serializers.CharField(write_only=True, help_text="تأكيد كلمة المرور.")

    def validate(self, data):
        # التحقق من تطابق كلمة المرور مع التأكيد
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError("كلمات المرور غير متطابقة.")
        
        # التحقق من وجود البريد الإلكتروني في قاعدة البيانات
        if User.objects.filter(email=data['email']).exists():
            raise serializers.ValidationError("البريد الإلكتروني مستخدم بالفعل.")
        
        # التحقق من وجود اسم المستخدم في قاعدة البيانات
        if User.objects.filter(username=data['username']).exists():
            raise serializers.ValidationError("اسم المستخدم مستخدم بالفعل.")
        
        return data

    def create(self, validated_data):
        # حذف حقل التأكيد لأننا لا نحتاجه في النموذج
        validated_data.pop('confirm_password')

        # إنشاء مستخدم جديد باستخدام جميع الحقول
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
        )
        return user

    def update(self, instance, validated_data):
        # تحديث البريد الإلكتروني إذا تم توفيره
        instance.email = validated_data.get('email', instance.email)

        # تحديث كلمة المرور إذا تم توفيرها
        password = validated_data.get('password')
        confirm_password = validated_data.get('confirm_password')

        if password and confirm_password:
            if password != confirm_password:
                raise serializers.ValidationError("كلمات المرور غير متطابقة.")
            instance.set_password(password)
        
        # تحديث اسم المستخدم إذا تم توفيره
        instance.username = validated_data.get('username', instance.username)
        instance.save()
        return instance




class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=100)  # إضافة حقل اسم المستخدم
    email = serializers.EmailField()  # الحقل الذي يتطلب البريد الإلكتروني
    password = serializers.CharField(write_only=True)  # كلمة المرور

    def validate(self, data):
        print(f"Received data: {data}")  # لطباعة البيانات المستلمة

        try:
            # البحث عن المستخدم باستخدام البريد الإلكتروني واسم المستخدم
            user = User.objects.get(username=data.get('username'), email=data.get('email'))
        except User.DoesNotExist:
            raise serializers.ValidationError("البريد الإلكتروني أو اسم المستخدم غير مسجل.")

        # التحقق من صحة كلمة المرور
        if not user.check_password(data.get('password')):
            raise serializers.ValidationError("كلمة المرور غير صحيحة.")

        return {'user': user}


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = '__all__'