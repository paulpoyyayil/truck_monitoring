import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/call.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/big_button.dart';
import 'package:remixicon/remixicon.dart';

class DriverDetails extends StatefulWidget {
  const DriverDetails({
    super.key,
    required this.name,
    required this.location,
    required this.route,
    required this.phoneNumber,
  });
  final String name, location, route, phoneNumber;

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          WillPopService().backFunction(context, Homepage(selectedIndex: 0)),
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Profile',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomBigButton(
                  onTap: () => makePhoneCall(widget.phoneNumber),
                  buttonText: 'CALL',
                ),
              ),
              SizedBox(height: 12.w)
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 100.w,
                  width: 100.w,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: AppColors.kBorderColor,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  child: Icon(
                    Remix.user_3_line,
                    size: 64.sp,
                    color: AppColors.kLightText,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.location,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'Route',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.route,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 14.h),
            ],
          ),
        ),
      ),
    );
  }
}
