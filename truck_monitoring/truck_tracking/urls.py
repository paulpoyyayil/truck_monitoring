from django.urls import path
from truck_tracking import views

urlpatterns = [
   
   path('login_users', views.LoginAPIView.as_view(), name='login_users'),

   path('user_register', views.UserRegisterAPIView.as_view(), name='user_register'),

   path('driver_register', views.DriverRegisterAPIView.as_view(), name='driver_register'),

   path('all_user', views.Get_All_User_APIView.as_view(), name='all_user'),

   path('single_user/<int:id>', views.Single_User_APIView.as_view(), name='single_user'),

   path('update_user/<int:id>', views.Update_UserAPIView.as_view(), name='update_user'),

   path('all_driver', views.Get_All_Driver_APIView.as_view(), name='all_driver'),

   path('single_driver/<int:id>', views.Single_Driver_APIView.as_view(), name='single_driver'),

   path('update_driver/<int:id>', views.Update_DriverAPIView.as_view(), name='update_driver'),

   path('list_drivers_with_vehicle', views.get_All_Drivers_With_Vehicle.as_view(), name='list_drivers_with_vehicle'),

   path('list_drivers_without_vehicle', views.get_All_Drivers_Without_Vehicle.as_view(), name='list_drivers_without_vehicle'),

   path('driver_add_Vehicle', views.Driver_Add_Vehicle_APIView.as_view(), name='driver_add_Vehicle'),

   path('all_driver_added_Vehicle', views.Get_All_Truck_Added_By_Driver_APIView.as_view(), name='all_driver_added_Vehicle'),

   path('single_truck_added_by_driver/<int:id>', views.Single_Truck_Added_By_Driver_APIView.as_view(), name='single_truck_added_by_driver'),

   path('update_truck_added_by_driver/<int:id>', views.Update_Truck_Added_By_Driver_APIView.as_view(), name='update_truck_added_by_driver'),

   path('delete_truck/<int:id>', views.Delete_TruckAPIView.as_view(), name='delete_truck'),

   path('user_add_load', views.User_Add_Load_APIView.as_view(), name='user_add_load'),


    path('all_load', views.Get_All_Load_APIView.as_view(), name='all_load'),

   path('single_load/<int:id>', views.Single_load_APIView.as_view(), name='single_load'),

   path('update_load/<int:id>', views.Update_Load_APIView.as_view(), name='update_load'),

   path('delete_load/<int:id>', views.Delete_LoadAPIView.as_view(), name='delete_load'),

   path('truck_booking', views.TruckBookingAPIView.as_view(), name='truck_booking'),


   path('cancel_truck_booking/<int:id>', views.Cancel_BookingAPIView.as_view(), name='cancel_truck_booking'),

   path('user_single_booking/<int:id>', views.UsersSingleBookingAPIView.as_view(), name='user_single_booking'),

   path('driver_single_booking/<int:id>', views.diversSingleBookingAPIView.as_view(), name='driver_single_booking'),

   path('driver_accept_booking/<int:id>', views.Driver_Accept_booking_APIView.as_view(), name='driver_accept_booking'),

   path('driver_reject_booking/<int:id>', views.Reject_BookingAPIView.as_view(), name='driver_reject_booking'),

   path('user_chat', views.UserChatAndReplayAPIView.as_view(), name='user_chat'),

   path('driver_view_chat/<int:id>', views.DriverViewChatAPIView.as_view(), name='driver_view_chat'),

   path('driver_update_chat/<int:id>', views.Update_ChatReply_APIView.as_view(), name='driver_update_chat'),

   path('user_view_chat/<int:id>', views.UserViewChatAndReplyAPIView.as_view(), name='user_view_chat'),

   path('driver_request_for_load', views.LoadRequestAPIView.as_view(), name='driver_request_for_load'),

   path('user_accept_request/<int:id>', views.User_Accept_Load_Request_APIView.as_view(), name='user_accept_request'),

   path('user_view_load_request/<int:id>', views.Users_View_load_Request_APIView.as_view(), name='user_view_load_request'),

   path('driver_view_load_request/<int:id>', views.Drivers_View_load_Request_APIView.as_view(), name='driver_view_load_request'),

   path('payment/<int:id>', views.PaymentAPIView.as_view(), name='payment'),

]