# Generated by Django 5.1.1 on 2024-10-08 01:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0016_remove_details_image_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='details',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='images/'),
        ),
        migrations.DeleteModel(
            name='Image',
        ),
    ]
