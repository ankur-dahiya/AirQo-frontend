from django.contrib import admin
import nested_admin
from .models import Event, Program, Session, PartnerLogo, Inquiry, Resource

# Register your models here.
class InquiryInline(nested_admin.NestedStackedInline):
    fields = ('inquiry','role','email', 'order')
    readonly_fields = ('author', 'updated_by')
    model = Inquiry
    extra = 0

class SessionInline(nested_admin.NestedStackedInline):
    fields = ('session_title','session_details','venue','start_time','end_time', 'order')
    readonly_fields = ('author', 'updated_by')
    model = Session
    extra = 0

class ProgramInline(nested_admin.NestedTabularInline):
    fields = ('date','program_details','order')
    readonly_fields = ('author', 'updated_by')
    model = Program
    inlines = (SessionInline,)
    extra = 0

class PartnerLogoInline(nested_admin.NestedTabularInline):
    fields=('name','partner_logo', 'order')
    readonly_fields = ('author', 'updated_by')
    model = PartnerLogo
    extra = 0

class ResourceInline(nested_admin.NestedTabularInline):
    fields=('title','link', 'resource', 'order')
    readonly_fields = ('author', 'updated_by')
    model = Resource
    extra = 0

@admin.register(Event)
class EventAdmin(nested_admin.NestedModelAdmin):
    fields= ('title', 'title_subtext', 'start_date','end_date','start_time','end_time','website_category','registration_link','event_tag','event_image','background_image','location_name','location_link','event_details','order','author', 'updated_by')
    readonly_fields = ('id', 'author', 'created', 'updated_by', 'modified')
    list_display=('title','start_date', 'event_tag','website_category','author')
    search_fields =('title','event_tag','location_name')
    list_filter = ('website_category','event_tag','start_date',)
    inlines = (ProgramInline, PartnerLogoInline, InquiryInline, ResourceInline,)
    list_per_page = 10

@admin.register(Resource)
class ResourceAdmin(admin.ModelAdmin):
    fields=('event','title','link', 'resource', 'order')
    list_display=('title','event','author',)
    search_fields =('event','title',)
    list_filter = ('author','created')
    list_per_page = 10

