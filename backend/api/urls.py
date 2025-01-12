from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import HouseList, LoginView, NotificationViewSet, home, ApartmentsList, PlotsoflandList, FeaturedpropertyList

urlpatterns = [
  # مسار التوكن للحصول على التوكن
    path("token/", TokenObtainPairView.as_view(), name='token_obtain_pair'),

    # مسار لتجديد التوكن
    path("token/refresh/", TokenRefreshView.as_view(), name='token_refresh'),

    # مسارات أخرى للتطبيق الخاص بك
    path("house/", HouseList.as_view(), name="house_list"),
    path("apartment/", ApartmentsList.as_view(), name="apartments_list"),
    path("plotsofland/", PlotsoflandList.as_view(), name="plotsofland_list"),
    path("notification/", NotificationViewSet.as_view({'get': 'list', 'post': 'create'}), name="notification"),
    path("featuredprperty/", FeaturedpropertyList.as_view(), name="featuredproperty_list"),
    path("login/", LoginView.as_view(), name="login"),
    path("", home, name="home"),
]
