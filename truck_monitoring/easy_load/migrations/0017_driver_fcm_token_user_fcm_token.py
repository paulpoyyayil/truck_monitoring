# Generated by Django 4.2.2 on 2023-07-14 06:47

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("easy_load", "0016_truckbooking_amount_truckbooking_payment_date"),
    ]

    operations = [
        migrations.AddField(
            model_name="driver",
            name="fcm_token",
            field=models.CharField(default="", max_length=500),
        ),
        migrations.AddField(
            model_name="user",
            name="fcm_token",
            field=models.CharField(default="", max_length=500),
        ),
    ]
