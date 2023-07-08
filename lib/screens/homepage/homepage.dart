// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/tabs/home/home_tab.dart';
// import 'package:truck_monitor/screens/tabs/notification/notification_tab.dart';
import 'package:truck_monitor/screens/tabs/phone/phone_tab.dart';
import 'package:truck_monitor/screens/tabs/profile/profile_tab.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:remixicon/remixicon.dart';

class Homepage extends StatefulWidget {
  Homepage({
    super.key,
    required this.selectedIndex,
  });
  int selectedIndex;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _onItemTapped(int index) {
    if (mounted) {
      widget.selectedIndex = index;
      setState(() {});
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomeTab();
      // case 1:
      //   return const NotificationTab();
      case 1:
        return const PhoneTab();
      case 2:
        return const ProfileTab();
      default:
        return const Center(
          child: Text("Error"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopService().exitApp(context),
      child: Scaffold(
        appBar: CustomAppbar(index: widget.selectedIndex),
        body: _getDrawerItemWidget(widget.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: widget.selectedIndex,
          selectedItemColor: AppColors.kPrimaryColor,
          unselectedItemColor: const Color.fromRGBO(0, 0, 0, 0.3),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
          ),
          selectedIconTheme: const IconThemeData(size: 28.0),
          iconSize: 24.0,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Remix.home_line),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Remix.phone_line),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Remix.user_3_line),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
