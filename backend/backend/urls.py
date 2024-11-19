from django.conf import settings
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from api.views import home  # Import your home view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    path('api/', include('api.urls')),  # تضمين مسارات تطبيق api
    path('', home, name='home'),  # مسار للصفحة الرئيسية
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)  # إعداد مسارات الوسائط
