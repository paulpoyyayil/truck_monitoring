# Generated by Django 4.1.5 on 2023-06-25 07:24

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ("easy_load", "0007_drivertruck_driver_name"),
    ]

    operations = [
        migrations.AlterField(
            model_name="drivertruck",
            name="truckfrom",
            field=models.CharField(max_length=100),
        ),
        migrations.CreateModel(
            name="load",
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
                ("load_description", models.CharField(max_length=100)),
                ("load_from", models.CharField(max_length=80)),
                ("load_to", models.CharField(max_length=100)),
                ("load_quantity", models.CharField(max_length=100)),
                ("status", models.CharField(max_length=100)),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="easy_load.user"
                    ),
                ),
            ],
        ),
    ]
