from django.urls import path
from .views import DetailsList, LoginView, home,ToggleFavorite

urlpatterns = [
    path("details/", DetailsList.as_view(), name="details_list"),
    path("detaols/<int:pk>/favorite",ToggleFavorite.as_view(),name='toggle-favorite'),
    path("login/", LoginView.as_view(), name="login"),
    path("", home, name="home"),
]
