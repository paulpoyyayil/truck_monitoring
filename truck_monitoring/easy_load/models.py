from django.db import models

# Create your models here.

class log(models.Model):
    username=models.CharField(max_length=100,unique=True)
    password=models.CharField(max_length=80)
    role=models.CharField(max_length=10)
    def __str__(self):
        return self.username


class user(models.Model):
    login_id = models.ForeignKey(log, on_delete=models.CASCADE)
    name=models.CharField(max_length=100,unique=True)
    email=models.EmailField(max_length=100,unique=True)
    mobile=models.CharField(max_length=13,unique=True)
    location=models.CharField(max_length=50)
    role=models.CharField(max_length=10)
    status=models.CharField(max_length=10)
    def __str__(self):
        return self.name


class driver(models.Model):
    login_id = models.ForeignKey(log, on_delete=models.CASCADE)
    name=models.CharField(max_length=100,unique=True)
    email=models.EmailField(max_length=100,unique=True)
    mobile=models.CharField(max_length=13,unique=True)
    location=models.CharField(max_length=50)
    vehicle_status = models.CharField(max_length=50)
    licence_no=models.CharField(max_length=20,unique=True)
    role=models.CharField(max_length=10)
    status=models.CharField(max_length=10)
    transport_from = models.CharField(max_length=100)
    transport_to = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Drivertruck(models.Model):
    driver = models.ForeignKey(driver, on_delete=models.CASCADE)
    driver_name=models.CharField(max_length=100)
    truck_name=models.CharField(max_length=100)
    trucknumber=models.CharField(max_length=80)
    truckfrom=models.CharField(max_length=100)
    truckto=models.CharField(max_length=100)
    load_capacity=models.CharField(max_length=40)
    status=models.CharField(max_length=10)


    def __str__(self):
        return self.truck_name



class load(models.Model):
    user= models.ForeignKey(user, on_delete=models.CASCADE)
    username= models.CharField(max_length=100)
    load_description=models.CharField(max_length=100)
    load_from=models.CharField(max_length=80,)
    load_to=models.CharField(max_length=100)
    load_quantity=models.CharField(max_length=100)
    status=models.CharField(max_length=100)


    def __str__(self):
        return self.load_description 


class TruckBooking(models.Model):
    user=models.ForeignKey(user, on_delete=models.CASCADE)
    driver=models.ForeignKey(driver, on_delete=models.CASCADE)
    username= models.CharField(max_length=100)
    truck=models.ForeignKey(Drivertruck, on_delete=models.CASCADE)
    truck_name=models.CharField(max_length=100)
    driver_name=models.CharField(max_length=100)
    load=models.ForeignKey(load, on_delete=models.CASCADE)
    load_quantity=models.CharField(max_length=100)
    starting=models.CharField(max_length=80,)
    ending=models.CharField(max_length=100)
    date=models.CharField(max_length=100)
    status=models.CharField(max_length=10)
    def __str__(self):
        return self.username


class Chat_Replay(models.Model):
    user=models.ForeignKey(user, on_delete=models.CASCADE, blank=True, null=True)
    driver = models.ForeignKey(driver, on_delete=models.CASCADE, blank=True, null=True)
    username = models.CharField(max_length=100)
    drivername = models.CharField(max_length=100)
    chat = models.CharField(max_length=500)
    date = models.CharField(max_length=100)
    replay= models.CharField(max_length=500,default='')
    chat_status = models.CharField(max_length=10)

    def __str__(self):
        return self.chat



class load_requset(models.Model):
    user= models.ForeignKey(user, on_delete=models.CASCADE, blank=True, null=True)
    driver = models.ForeignKey(driver, on_delete=models.CASCADE, blank=True, null=True)
    load = models.ForeignKey(load, on_delete=models.CASCADE, blank=True, null=True)
    username = models.CharField(max_length=100)
    drivername = models.CharField(max_length=100)
    load_from=models.CharField(max_length=80,)
    load_to=models.CharField(max_length=100)
    load_quantity=models.CharField(max_length=100)
    amount = models.CharField(max_length=100, blank=True, null=True)
    status=models.CharField(max_length=100)


    def __str__(self):
        return self.load_from 

