# Generated by Django 4.1.7 on 2023-08-01 11:43

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django_extensions.db.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='ImpactNumber',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created', django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, verbose_name='created')),
                ('modified', django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified')),
                ('is_deleted', models.BooleanField(default=False)),
                ('african_cities', models.IntegerField(default=8)),
                ('champions', models.IntegerField(default=1500)),
                ('deployed_monitors', models.IntegerField(default=200)),
                ('data_records', models.IntegerField(default=67)),
                ('research_papers', models.IntegerField(default=10)),
                ('partners', models.IntegerField(default=300)),
                ('author', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='impactnumber_create', to=settings.AUTH_USER_MODEL, verbose_name='author')),
                ('updated_by', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='impactnumber_update', to=settings.AUTH_USER_MODEL, verbose_name='last updated by')),
            ],
        ),
    ]