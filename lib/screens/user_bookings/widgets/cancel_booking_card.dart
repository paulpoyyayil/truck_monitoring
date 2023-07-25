import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/bookings.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/cancel_booking.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/big_button.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';

class CancelBookingCard extends StatefulWidget {
  const CancelBookingCard({super.key, required this.data});
  final BookingsModelData data;

  @override
  State<CancelBookingCard> createState() => _CancelBookingCardState();
}

class _CancelBookingCardState extends State<CancelBookingCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                    text: widget.data.truckName!.titleCase,
                  ),
                  RowText(
                    title: 'Driver Name: ',
                    text: widget.data.driverName!.titleCase,
                  ),
                  RowText(
                    title: 'From: ',
                    text: widget.data.starting!.toUpperCase(),
                  ),
                  RowText(
                    title: 'To: ',
                    text: widget.data.ending!.toUpperCase(),
                  ),
                  RowText(
                    title: 'Date: ',
                    text: widget.data.date!,
                  ),
                ],
              ),
            ],
          ),
          if (widget.data.amount == null && widget.data.status == '0')
            StatusButton(
              onTap: () async {
                if (!isLoading) {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  try {
                    bool status = await cancelBooking(
                      context: context,
                      bookingId: widget.data.id.toString(),
                    );
                    if (status) {
                      if (mounted) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              content: SingleChildScrollView(
                                child: Center(
                                    child:
                                        CircularProgressIndicator.adaptive()),
                              ),
                            );
                          },
                        );
                        getSnackbar(context, 'Cancelled');
                        navigationPush(context, Homepage(selectedIndex: 0));
                      }
                    } else {
                      if (mounted) {
                        getSnackbar(context, 'Unexpected error occurred.');
                      }
                    }
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
          if (widget.data.amount != null)
            CustomBigButton(
              onTap: () {},
              buttonText: 'Payment Complete',
              backgroundColor: Colors.grey,
            )
        ],
      ),
    );
  }
}
