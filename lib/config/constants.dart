class ApiConstants {
  static const baseUrl =
      'https://ec29-2405-201-f00a-20cc-11b-82c5-92a9-de66.ngrok-free.app/';
  static const login = 'api/login_users';
  static const registerUser = 'api/user_register';
  static const registerDriver = 'api/driver_register';
  static const driverWithVehicle = 'api/list_drivers_with_vehicle';
  static const driverWithoutVehicle = 'api/list_drivers_without_vehicle';
  static const viewTrucks = 'api/all_driver_added_Vehicle';
  static const truckBooking = 'api/truck_booking';
  static const allDriver = 'api/all_driver';
  static const addVehicle = 'api/driver_add_Vehicle';
  static const userData = 'api/single_user/';
  static const driverData = 'api/single_driver/';
  static const updateUser = 'api/update_user/';
  static const updateDriver = 'api/update_driver/';
  static const userBookings = 'api/user_single_booking/';
  static const driverBookings = 'api/driver_single_booking/';
  static const driverAcceptBooking = 'api/driver_accept_booking';
  static const cancelBooking = 'api/cancel_truck_booking';
  static const userLoadRequest = 'api/cancel_truck_booking';
  static const userAddLoad = 'api/user_add_load';
  static const userSendChat = 'api/user_chat';
  static const driverSendChat = 'api/driver_update_chat';
  static const allUserChats = 'api/user_view_chat';
  static const allDriverChats = 'api/driver_view_chat';
  static const allLoads = 'api/all_load';
  static const driverRequestLoad = 'api/driver_request_for_load';
  static const userViewLoads = 'api/user_view_load_request';
  static const userAcceptLoad = 'api/user_accept_request';
  static const driverLoads = 'api/driver_view_load_request';
}
