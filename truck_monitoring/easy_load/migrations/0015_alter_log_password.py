# Generated by Django 4.2.2 on 2023-07-08 04:35

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("easy_load", "0014_chat_replay_drivername_chat_replay_username_and_more"),
    ]

    operations = [
        migrations.AlterField(
            model_name="log",
            name="password",
            field=models.CharField(max_length=80),
        ),
    ]
