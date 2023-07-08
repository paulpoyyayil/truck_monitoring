from django.contrib import admin
from .models import log, user, driver, Drivertruck,TruckBooking, Chat_Replay, load, load_requset

# Register your models here.

admin.site.register(log)
admin.site.register(user)
admin.site.register(driver)
admin.site.register(Drivertruck)
admin.site.register(TruckBooking)
admin.site.register(Chat_Replay)
admin.site.register(load)
admin.site.register(load_requset)

