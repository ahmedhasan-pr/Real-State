from django.shortcuts import HttpResponse
from .models import  Apartments, Featuredproperty, House,Notification, Plotsofland
from .serializers import HouseSerializer, LoginSerializer,SignupSerializer,NotificationSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth.models import User
from rest_framework import status ,viewsets
from rest_framework.permissions import IsAuthenticated



class HouseList(viewsets.ModelViewSet):
    queryset = House.objects.all()
    serializer_class = HouseSerializer

class ApartmentsList(viewsets.ModelViewSet):
    queryset = Apartments.objects.all()
    serializer_class = HouseSerializer

class PlotsoflandList(viewsets.ModelViewSet):
    queryset = Plotsofland.objects.all()
    serializer_class = HouseSerializer

class FeaturedpropertyList(viewsets.ModelViewSet):
    queryset = Featuredproperty.objects.all()
    serializer_class = HouseSerializer

class SignupView(viewsets.ModelViewSet):
    
    queryset = User.objects.all()
    serializer_class = SignupSerializer
#     def post(self, request):
#         # محاولة إنشاء حساب مستخدم جديد
#         serializer = SignupSerializer(data=request.data)
#         if serializer.is_valid():
#             user = serializer.save()
#             return Response({"message": "تم إنشاء الحساب بنجاح", "user": user.email}, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
#     def get(self, request, pk=None):
#         if pk:  # إذا كان `pk` موجودًا، جلب مستخدم معين
#             try:
#                 user = User.objects.get(pk=pk)
#                 return Response({"id": user.id, "email": user.email}, status=status.HTTP_200_OK)
#             except User.DoesNotExist:
#                 return Response({"error": "المستخدم غير موجود"}, status=status.HTTP_404_NOT_FOUND)
#         else:  # إذا لم يكن `pk` موجودًا، جلب جميع المستخدمين
#             users = User.objects.all()
#             data = [{"id": user.id, "email": user.email} for user in users]
#             return Response(data, status=status.HTTP_200_OK)
    
#     def put(self, request, pk):
#         # تحديث بيانات المستخدم
#         if not pk:
#             return Response({"message": "يجب توفير معرّف المستخدم (pk)"}, status=status.HTTP_400_BAD_REQUEST)
        
#         try:
#             user = User.objects.get(pk=pk)
#         except User.DoesNotExist:
#             return Response({"message": "المستخدم غير موجود"}, status=status.HTTP_404_NOT_FOUND)
        
#         # تفعيل التحديث الجزئي (partial=True)
#         serializer = SignupSerializer(user, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response({"message": "تم تحديث البيانات بنجاح", "user": serializer.data}, status=status.HTTP_200_OK)
        
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
#     def delete(self, request, pk):
#         # حذف مستخدم
#         if not pk:
#             return Response({"message": "يجب توفير معرّف المستخدم (pk)"}, status=status.HTTP_400_BAD_REQUEST)
        
#         try:
#             user = User.objects.get(pk=pk)
#             user.delete()
#             return Response({"message": "تم حذف المستخدم بنجاح"}, status=status.HTTP_204_NO_CONTENT)
#         except User.DoesNotExist:
#             return Response({"message": "المستخدم غير موجود"}, status=status.HTTP_404_NOT_FOUND)
# 
class LoginView(APIView):
     queryset = User.objects.all()
     serializer_class = LoginSerializer

     def post(self, request):
        # محاولة تسجيل الدخول
        serializer = LoginSerializer(data=request.data)
        
        if serializer.is_valid():
            user = serializer.validated_data['user']
            # إرجاع استجابة بنجاح مع البريد الإلكتروني للمستخدم فقط
            return Response({
                "message": "تم تسجيل الدخول بنجاح",
                "user": user.username,
                "email": user.email,
            }, status=status.HTTP_200_OK)
        
        # إرجاع الخطأ إذا كانت البيانات غير صحيحة
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

     
def home(request):
     return HttpResponse("مرحبا بك في الصفحة الرئيسية")


class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer