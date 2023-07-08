import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/bookings.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/cancel_booking.dart';
import 'package:truck_monitor/service/user_bookings.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';

class UserBookings extends StatefulWidget {
  const UserBookings({super.key});

  @override
  State<UserBookings> createState() => _UserBookingsState();
}

class _UserBookingsState extends State<UserBookings> {
  BookingsModel? _bookingsModel;
  bool isLoading = false;

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

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Bookings',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: _bookingsModel == null
          ? Center(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CardOutline(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowText(
                                      title: 'Truck Name: ',
                                      text: _bookingsModel!
                                          .data![index].truckName!.titleCase,
                                    ),
                                    RowText(
                                      title: 'Driver Name: ',
                                      text: _bookingsModel!
                                          .data![index].driverName!.titleCase,
                                    ),
                                    RowText(
                                      title: 'From: ',
                                      text: _bookingsModel!
                                          .data![index].starting!
                                          .toUpperCase(),
                                    ),
                                    RowText(
                                      title: 'To: ',
                                      text: _bookingsModel!.data![index].ending!
                                          .toUpperCase(),
                                    ),
                                    RowText(
                                      title: 'Date: ',
                                      text: _bookingsModel!.data![index].date!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            StatusButton(
                              onTap: () async {
                                if (mounted) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                }
                                if (!isLoading) {
                                  try {
                                    String status = await cancelBooking(
                                      context: context,
                                      bookingId: _bookingsModel!.data![index].id
                                          .toString(),
                                    );
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SingleChildScrollView(
                                            child: Center(
                                                child: CircularProgressIndicator
                                                    .adaptive()),
                                          ),
                                        );
                                      },
                                    );
                                    _getData().then((value) {
                                      if (mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                      Navigator.of(context).pop();
                                    });
                                    getSnackbar(context, status);
                                  } catch (e) {
                                    if (mounted) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                    getSnackbar(context, e.toString());
                                  }
                                }
                              },
                              buttonText: 'Cancel Booking',
                              status: isLoading,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 14.h),
                    itemCount: _bookingsModel!.data!.length,
                  ),
                ),
    );
  }
}
