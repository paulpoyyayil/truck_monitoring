from django.urls import path
from easy_load import views

urlpatterns = [
    path("", views.index_page, name="index_page"),
    path("adddriver", views.adddriver, name="adddriver"),
    path("viewdriver", views.viewdriver, name="viewdriver"),
    path("addload", views.addload, name="addload"),
    path("viewload", views.viewload, name="viewload"),
    path("addvehicle", views.addvehicle, name="addvehicle"),
    path("viewvehicle", views.viewvehicle, name="viewvehicle"),
    path("viewuser", views.viewuser, name="viewuser"),
    path("view_approved_user", views.view_approved_user, name="view_approved_user"),
    path(
        "admin_approve_users/<int:id>",
        views.admin_approve_users,
        name="admin_approve_users",
    ),
    path(
        "admin_reject_users/<int:id>",
        views.admin_reject_users,
        name="admin_reject_users",
    ),
    path(
        "view_approved_driver", views.view_approved_driver, name="view_approved_driver"
    ),
    path(
        "admin_approve_drivers/<int:id>",
        views.admin_approve_drivers,
        name="admin_approve_drivers",
    ),
    path(
        "admin_reject_drivers/<int:id>",
        views.admin_reject_drivers,
        name="admin_reject_drivers",
    ),
    path("admin_add_driver", views.admin_add_driver, name="admin_add_driver"),
]
