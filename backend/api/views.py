from django.shortcuts import HttpResponse
from .models import  Apartments, Featuredproperty, House,Notification, Plotsofland
from .serializers import HouseSerializer, LoginSerializer,NotificationSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate, login
from rest_framework import status ,viewsets
from rest_framework.permissions import IsAuthenticated



class HouseList(ListAPIView):
    queryset = House.objects.all()
    serializer_class = HouseSerializer

class ApartmentsList(ListAPIView):
    queryset = Apartments.objects.all()
    serializer_class = HouseSerializer

class PlotsoflandList(ListAPIView):
    queryset = Plotsofland.objects.all()
    serializer_class = HouseSerializer

class FeaturedpropertyList(ListAPIView):
    queryset = Featuredproperty.objects.all()
    serializer_class = HouseSerializer



class LoginView(APIView):
    def get(self, request):
        return Response({"message": "يرجى إرسال بيانات الاعتماد عبر POST"}, status=status.HTTP_405_METHOD_NOT_ALLOWED)
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.validated_data['user']
            login(request, user)
            return Response({"message": "تم تسجيل الدخول بنجاح"}, status=status.HTTP_200_OK)
        print(serializer.errors) 
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

def home(request):
    return HttpResponse("مرحبا بك في الصفحة الرئيسية")


class NotificationViewSet(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer