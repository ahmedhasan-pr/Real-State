from django.shortcuts import HttpResponse
from .models import Details,Notification
from .serializers import DetailsSerializer, LoginSerializer,NotificationSerializer
from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from rest_framework.response import Response
from django.contrib.auth import authenticate, login
from rest_framework import status ,viewsets


class DetailsList(ListAPIView):
    queryset = Details.objects.all()
    serializer_class = DetailsSerializer

class ToggleFavorite(APIView):
    def post(self,request,pk):
        try:
            details = Details.objects.get(pk=pk)
        except Details.DoesNotExist:
            return Response({"error":"لم يتم العثور على العنصر"},status=status.HTTP_404_NOT_FOUND)
        
         # التبديل بين المفضلة

        details.favorite = not details.favorite # type: ignore
        details.save()
        return Response({"favorite":details.favorite},status=status.HTTP_200_OK)



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


class NotificationViewset(viewsets.ModelViewSet):
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer