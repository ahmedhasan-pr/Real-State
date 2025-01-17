# Generated by Django 5.1.1 on 2024-10-07 01:37

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_alter_details_description'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='details',
            name='image',
        ),
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.FileField(upload_to='images/')),
                ('details', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='api.details')),
            ],
        ),
    ]
