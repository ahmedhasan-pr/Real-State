# Generated by Django 5.1.1 on 2024-10-07 02:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_remove_details_image_image'),
    ]

    operations = [
        migrations.AddField(
            model_name='details',
            name='image',
            field=models.ImageField(default=1, upload_to='images/'),
            preserve_default=False,
        ),
        migrations.DeleteModel(
            name='Image',
        ),
    ]
