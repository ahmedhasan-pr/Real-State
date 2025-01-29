from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from .views import HouseList, LoginView, NotificationViewSet, SignupView, home, ApartmentsList, PlotsoflandList, FeaturedpropertyList

urlpatterns = [
  # مسار التوكن للحصول على التوكن
    path("token/", TokenObtainPairView.as_view(), name='token_obtain_pair'),

    # مسار لتجديد التوكن
    path("token/refresh/", TokenRefreshView.as_view(), name='token_refresh'),

    # مسارات أخرى للتطبيق الخاص بك
    path('houses/', HouseList.as_view({'get': 'list', 'post': 'create'}), name='house_list'),
    path('houses/<int:pk>/', HouseList.as_view({'get': 'retrieve', 'put': 'update', 'delete': 'destroy'}), name='house_detail'),
    path("apartment/", ApartmentsList.as_view({'get':'list', 'post':'create'}), name="apartments_list"),
    path("apartment/<int:pk>", ApartmentsList.as_view({'get':'retrieve', 'put':'update','delete':'destroy'}), name="apartments_list"),
    path("plotsofland/", PlotsoflandList.as_view({'get': 'list', 'post': 'create'}), name="plotsofland_list"),
    path("plotsofland/<int:pk>", PlotsoflandList.as_view({'get':'retrieve', 'put':'update','delete':'destroy'}), name="plotsofland_list"),
    path("notification/", NotificationViewSet.as_view({'get': 'list', 'post': 'create'}), name="notification"),
    path("featuredprperty/", FeaturedpropertyList.as_view({'get': 'list', 'post': 'create'}), name="featuredproperty_list"),
    path("featuredprperty/<int:pk>", FeaturedpropertyList.as_view({'get':'retrieve', 'put':'update','delete':'destroy'}), name="featuredproperty_list"),
    path('signup/', SignupView.as_view({'get': 'list', 'post': 'create'}), name='signup'),#Get , Post
    path('signup/<int:pk>/', SignupView.as_view({'get':'retrieve', 'put':'update','delete':'destroy'}), name='signup-detail'),#Put , Delete
    path('login/', LoginView.as_view(), name='login'),
    path("", home, name="home"),
]
