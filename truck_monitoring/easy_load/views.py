from django.shortcuts import render, redirect
from . import models
from .models import user, driver, log


# Create your views here.
def index_page(request):
    return render(request, "newindex.html")


def adddriver(request):
    return render(request, "forms/adddriver.html")


def viewdriver(request):
    data = driver.objects.all()
    return render(request, "forms/viewdriver.html", {"data": data})


def addload(request):
    return render(request, "forms/addload.html")


def viewload(request):
    return render(request, "forms/viewload.html")


def addvehicle(request):
    return render(request, "forms/addvehicle.html")


def viewvehicle(request):
    return render(request, "forms/viewvehicle.html")


def viewuser(request):
    data = user.objects.all()
    return render(request, "forms/viewuser.html", {"data": data})


def view_approved_user(request):
    data = user.objects.all()
    return render(request, "forms/view_approved_users.html", {"data": data})


def admin_approve_users(request, id):
    userdata = user.objects.get(id=id)
    userdata.status = 1
    userdata.save()
    return redirect("view_approved_user")


def admin_reject_users(request, id):
    delmember = user.objects.get(id=id)
    print(delmember)
    print(delmember.login_id)
    l_id = delmember.login_id
    print(l_id)
    data = log.objects.get(username=l_id)
    data.delete()
    return redirect("viewuser")


def view_approved_driver(request):
    data = driver.objects.all()
    return render(request, "forms/view_approved_drivers.html", {"data": data})


def admin_approve_drivers(request, id):
    userdata = driver.objects.get(id=id)
    userdata.status = 1
    userdata.save()
    return redirect("view_approved_driver")


def admin_reject_drivers(request, id):
    delmember = driver.objects.get(id=id)
    print(delmember)
    print(delmember.login_id)
    l_id = delmember.login_id
    print(l_id)
    data = log.objects.get(username=l_id)
    data.delete()
    return redirect("viewdriver")


def admin_add_driver(request):
    if request.method == "POST":
        login_id = ""
        name = request.POST.get("name")
        email = request.POST.get("email")
        mobile = request.POST.get("mobile")
        location = request.POST.get("location")
        vehicle_status = request.POST.get("vehicle_status")
        licence_no = request.POST.get("licence_no")
        transport_from = request.POST.get("transport_from")
        transport_to = request.POST.get("transport_to")
        username = request.POST.get("username")
        password = request.POST.get("password")
        role = "driver"
        driver_status = "1"

        if log.objects.filter(username=username):
            return redirect("adddriver")
        else:
            login_data = models.log(username=username, password=password, role=role)
            login_data.save()
            l_id = login_data.id
            print(l_id)
            userdata = models.driver(
                name=name,
                email=email,
                mobile=mobile,
                location=location,
                vehicle_status=vehicle_status,
                licence_no=licence_no,
                transport_from=transport_from,
                transport_to=transport_to,
                login_id_id=l_id,
                status=driver_status,
                role=role,
            )
            userdata.save()
            return redirect("view_approved_driver")

    else:
        return render(request, "adddriver.html")
