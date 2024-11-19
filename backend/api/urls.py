from django.urls import path
from .views import DetailsList, LoginView, home

urlpatterns = [
    path("details/", DetailsList.as_view(), name="details_list"),
    path("login/", LoginView.as_view(), name="login"),
    path("", home, name="home"),
]
