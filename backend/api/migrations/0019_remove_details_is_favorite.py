# Generated by Django 5.1.1 on 2024-10-27 12:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0018_details_is_favorite'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='details',
            name='is_favorite',
        ),
    ]
