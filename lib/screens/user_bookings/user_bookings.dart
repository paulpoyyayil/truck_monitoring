import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/models/bookings.dart';
import 'package:truck_monitor/models/user_view_load.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/user_bookings/widgets/cancel_booking_card.dart';
import 'package:truck_monitor/screens/user_bookings/widgets/load_request_card.dart';
import 'package:truck_monitor/service/user_bookings.dart';
import 'package:truck_monitor/service/user_view_load.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';

class UserBookings extends StatefulWidget {
  const UserBookings({super.key});

  @override
  State<UserBookings> createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  BookingsModel? _bookingsModel;
  UserViewLoadModel? _loadModel;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    try {
      _bookingsModel = await fetchBookings(context: context);
    } catch (e) {
      getSnackbar(context, e.toString());
    }
    try {
      if (mounted) {
        _loadModel = await userViewLoads(context: context);
      }
    } catch (e) {
      if (mounted) {
        getSnackbar(context, e.toString());
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Bookings & Loads',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.kPrimaryColor,
              child: TabBar(
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: const Text(
                        'Bookings',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: const Text(
                        'Load\nRequests',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _bookingsModel == null
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _bookingsModel!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Bookings',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 24.h),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return CancelBookingCard(
                                      data: _bookingsModel!.data![index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 14.h),
                                itemCount: _bookingsModel!.data!.length,
                              ),
                            ),
                  _loadModel == null
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _loadModel!.data!.isEmpty
                          ? Center(
                              child: Text(
                                'No Loads',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 24.h),
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return LoadRequestCard(
                                    data: _loadModel!.data![index],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 14.h),
                                itemCount: _loadModel!.data!.length,
                              ),
                            ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
