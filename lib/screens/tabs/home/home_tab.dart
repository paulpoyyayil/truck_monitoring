import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/screens/driver_loads/driver_loads.dart';
import 'package:truck_monitor/screens/truck_stop/truck_stop.dart';
import 'package:truck_monitor/screens/add_vehicle/add_vehicle.dart';
import 'package:truck_monitor/screens/book_truck/book_truck.dart';
import 'package:truck_monitor/screens/driver_bookings/driver_bookings.dart';
import 'package:truck_monitor/screens/hire_drivers/hire_drivers.dart';
import 'package:truck_monitor/screens/driver_load_request/driver_load_request.dart';
import 'package:truck_monitor/screens/payment_screen/payment_screen.dart';
import 'package:truck_monitor/screens/user_load_request/user_load_request.dart';
import 'package:truck_monitor/screens/user_messages/user_messages.dart';
import 'package:truck_monitor/service/set_token.dart';
import 'package:truck_monitor/utils/logout_and_navigate.dart';
import 'package:truck_monitor/screens/user_bookings/user_bookings.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/tile_widget.dart';

bool isDeviceTokenSet = false;

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
          return navigationPush(context, const PaymentScreen());
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
          return navigationPush(context, const DriverLoadRequest());
        case 3:
          return navigationPush(context, const DriverLoads());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    logoutAndNavigate(context);
    if (!isDeviceTokenSet) {
      putToken();
    }
  }

  putToken() async {
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      await setToken(token: deviceToken!);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  role == 'user' ? userWidgets.length : driverWidgets.length,
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
            if (role == 'user') SizedBox(height: 14.h),
            if (role == 'user')
              GestureDetector(
                onTap: () => navigationPush(context, const TruckStop()),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kCardBackground,
                        border: Border.all(
                          color: AppColors.kBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: AppColors.kShadowColor,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Icon(
                          Remix.bus_line,
                          size: 64.sp,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Truck Stop',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
