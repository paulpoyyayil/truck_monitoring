import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/confirm_payment/confirm_payment.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/custom_button.dart';
import 'package:truck_monitor/utils/calculate_distance.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    super.key,
    required this.truckName,
    required this.driverName,
    required this.loadQuantity,
    required this.from,
    required this.to,
    required this.amount,
    required this.paymentDate,
    required this.paymentId,
    required this.truckId,
  });
  final String truckName,
      driverName,
      from,
      to,
      loadQuantity,
      truckId,
      paymentId;
  final String? paymentDate, amount;

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  var amount = 0.0;
  @override
  void initState() {
    super.initState();
    if (widget.amount == null) {
      calculateAmount();
    }
  }

  calculateAmount() async {
    try {
      List<Location> from = await locationFromAddress(widget.from);
      List<Location> to = await locationFromAddress(widget.to);
      double fromLat = from.first.latitude;
      double fromLong = from.first.longitude;
      double toLat = to.first.latitude;
      double toLong = to.first.longitude;
      double distance = calculateDistance(fromLat, fromLong, toLat, toLong);
      amount = (distance * 10) + (int.parse(widget.loadQuantity) * 20);
    } catch (_) {
      amount = int.parse(widget.loadQuantity) * 20;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.kBorderColor,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 4,
                color: AppColors.kShadowColor,
              )
            ],
          ),
          child: Column(
            children: [
              SeparatedRowText(
                  title: 'Truck Name', text: widget.truckName.titleCase),
              SeparatedRowText(
                  title: 'Driver Name', text: widget.driverName.titleCase),
              SeparatedRowText(title: 'From', text: widget.from.toUpperCase()),
              SeparatedRowText(title: 'To', text: widget.to.toUpperCase()),
              SeparatedRowText(
                  title: 'Load Quantity', text: widget.loadQuantity),
              if (widget.paymentDate != null)
                SeparatedRowText(title: '', text: ''),
              SeparatedRowText(
                  title: 'Amount',
                  text: '₹${widget.amount ?? amount.toStringAsFixed(2)}'),
              if (widget.paymentDate != null)
                SeparatedRowText(
                    title: 'Payment Date',
                    text:
                        '${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.paymentDate!)).toString()}'),
            ],
          ),
        ),
        if (widget.amount == null)
          Container(
            width: MediaQuery.sizeOf(context).width,
            child: CustomButton(
              onTap: () {
                if (amount != 0.0) {
                  navigationReplacement(
                    context,
                    ConfirmPaymentScreen(
                      paymentAmount: amount.toStringAsFixed(2),
                      paymentId: widget.paymentId,
                      truckId: widget.truckId,
                    ),
                  );
                }
              },
              buttonText: 'Pay',
              status: false,
            ),
          ),
      ],
    );
  }
}
