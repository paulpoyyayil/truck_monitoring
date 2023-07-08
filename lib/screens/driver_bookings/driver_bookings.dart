import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/bookings.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/driver_accept_booking.dart';
import 'package:truck_monitor/service/user_bookings.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';

class DriverBookings extends StatefulWidget {
  const DriverBookings({super.key});

  @override
  State<DriverBookings> createState() => _DriverBookingsState();
}

class _DriverBookingsState extends State<DriverBookings> {
  BookingsModel? _bookingsModel;

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
    return WillPopScope(
      onWillPop: () =>
          WillPopService().backFunction(context, Homepage(selectedIndex: 0)),
      child: Scaffold(
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
                        return BookingsCard(
                          id: _bookingsModel!.data![index].id.toString(),
                          name:
                              _bookingsModel!.data![index].username!.titleCase,
                          truck:
                              _bookingsModel!.data![index].truckName!.titleCase,
                          driver: _bookingsModel!
                              .data![index].driverName!.titleCase,
                          quantity: _bookingsModel!.data![index].loadQuantity!,
                          starting: _bookingsModel!.data![index].starting!
                              .toUpperCase(),
                          ending: _bookingsModel!.data![index].ending!
                              .toUpperCase(),
                          date: _bookingsModel!.data![index].date!,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 14.h),
                      itemCount: _bookingsModel!.data!.length,
                    ),
                  ),
      ),
    );
  }
}

class BookingsCard extends StatefulWidget {
  const BookingsCard({
    super.key,
    required this.id,
    required this.name,
    required this.truck,
    required this.driver,
    required this.quantity,
    required this.starting,
    required this.ending,
    required this.date,
  });
  final String id, name, truck, driver, quantity, starting, ending, date;

  @override
  State<BookingsCard> createState() => _BookingsCardState();
}

class _BookingsCardState extends State<BookingsCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CardOutline(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowText(title: 'Name: ', text: widget.name),
              RowText(title: 'Truck: ', text: widget.truck),
              RowText(title: 'Driver: ', text: widget.driver),
              RowText(title: 'Load Quantity: ', text: widget.quantity),
              RowText(title: 'Starting: ', text: widget.starting),
              RowText(title: 'Ending: ', text: widget.ending),
              RowText(title: 'Date: ', text: widget.date),
            ],
          ),
          StatusButton(
            onTap: () async {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
              try {
                bool status = await driverAcceptBooking(
                  context: context,
                  bookingId: widget.id,
                );
                if (status) {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  getSnackbar(context, 'Booking Accepted');
                  navigationPush(context, DriverBookings());
                } else {
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  getSnackbar(context, 'Unexpected error occurred.');
                }
              } catch (e) {
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
                getSnackbar(context, e.toString());
              }
            },
            buttonText: 'Accept',
            status: isLoading,
          ),
        ],
      ),
    );
  }
}
