# Generated by Django 4.2.2 on 2023-07-17 05:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0007_rename_phone_profile_phone_number_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='email',
            field=models.EmailField(max_length=20, null=True, unique=True),
        ),
    ]