from django.db import models
from django.contrib.auth.models import User


class Details(models.Model):
    image = models.ImageField(upload_to='images/', null=True, blank=True)  # يقبل قيم فارغة
    price = models.DecimalField(max_digits=10, decimal_places=2)
    TYPE_PRICE_CHOICES = [
        ('شراء', 'شراء'),
        ('ايجار', 'ايجار'),
    ]
    typePrice = models.CharField(max_length=10, choices=TYPE_PRICE_CHOICES, default='')
    favorite = models.BooleanField(default=False)
    location = models.CharField(max_length=255)
    square = models.DecimalField(max_digits=10, decimal_places=2)
    bathroom = models.IntegerField()
    room = models.IntegerField()
    garage = models.BooleanField(default=False)
    description = models.CharField(max_length=300, default='')
    def __str__(self):
        return self.typePrice


class Notification(models.Model):
    message = models.TextField()
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    is_read = models.BooleanField(default=False)