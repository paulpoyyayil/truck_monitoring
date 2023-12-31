# Generated by Django 4.1.5 on 2023-06-25 06:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("easy_load", "0005_driver_transport_from_driver_transport_to"),
    ]

    operations = [
        migrations.CreateModel(
            name="Drivertruck",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("truck_name", models.CharField(max_length=100, unique=True)),
                ("trucknumber", models.CharField(max_length=80, unique=True)),
                ("truckfrom", models.CharField(max_length=100, unique=True)),
                ("truckto", models.CharField(max_length=100)),
                ("load_capacity", models.CharField(max_length=40)),
                ("status", models.CharField(max_length=10)),
                (
                    "driver",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="easy_load.driver",
                    ),
                ),
            ],
        ),
        migrations.DeleteModel(
            name="truck",
        ),
    ]
