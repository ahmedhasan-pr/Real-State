from django.contrib import admin
from .models import Apartments, Featuredproperty, House, Notification, Plotsofland

# Register your models here.
admin.site.register(House)
admin.site.register(Featuredproperty)
admin.site.register(Apartments)
admin.site.register(Plotsofland)
admin.site.register(Notification)