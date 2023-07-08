import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/screens/add_vehicle/add_vehicle.dart';
import 'package:truck_monitor/screens/book_truck/book_truck.dart';
import 'package:truck_monitor/screens/driver_bookings/driver_bookings.dart';
import 'package:truck_monitor/screens/driver_messages/driver_messages.dart';
import 'package:truck_monitor/screens/hire_drivers/hire_drivers.dart';
import 'package:truck_monitor/screens/driver_load_request/driver_load_request.dart';
import 'package:truck_monitor/screens/payment/payment.dart';
import 'package:truck_monitor/screens/user_load_request/user_load_request.dart';
import 'package:truck_monitor/screens/user_messages/user_messages.dart';
import 'package:truck_monitor/utils/logout_and_navigate.dart';
import 'package:truck_monitor/screens/user_bookings/user_bookings.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/tile_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  _onItemTapped(int index) {
    if (role == 'user') {
      switch (index) {
        case 0:
          return navigationPush(context, const HireDrivers());
        case 1:
          return navigationPush(context, const BookTruck());
        case 2:
          return navigationPush(context, const UserBookings());
        case 3:
          return navigationPush(context, const Payment());
        case 4:
          return navigationPush(context, const UserLoadRequest());
        case 5:
          return navigationPush(context, const UserMessages());
      }
    } else if (role == 'driver') {
      switch (index) {
        case 0:
          return navigationPush(context, const AddVehicleScreen());
        case 1:
          return navigationPush(context, const DriverBookings());
        case 2:
          return navigationPush(context, const LoadRequest());
        case 3:
          return navigationPush(context, const DriverMessages());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    logoutAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: role == 'user' ? userWidgets.length : driverWidgets.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18.w,
          mainAxisSpacing: 32.h,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: TileWidget(
              icon: role == 'user'
                  ? userWidgets[index].icon
                  : driverWidgets[index].icon,
              label: role == 'user'
                  ? userWidgets[index].label
                  : driverWidgets[index].label,
            ),
          );
        },
      ),
    );
  }
}
