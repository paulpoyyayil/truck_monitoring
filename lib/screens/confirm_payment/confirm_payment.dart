import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/payment_screen/payment_screen.dart';
import 'package:truck_monitor/service/payments.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/validate_card.dart';
import 'package:truck_monitor/utils/validate_upi.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  const ConfirmPaymentScreen({
    super.key,
    required this.paymentAmount,
    required this.paymentId,
    required this.truckId,
  });
  final String paymentAmount, truckId, paymentId;

  @override
  State<ConfirmPaymentScreen> createState() => _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  TextEditingController _upi = TextEditingController();
  TextEditingController _card = TextEditingController();
  bool _isUpiSelected = true;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _upi.dispose();
    _card.dispose();
  }

  void _togglePaymentMethod(bool isUpiSelected) {
    setState(() {
      _isUpiSelected = isUpiSelected;
    });
  }

  void _processPayment() async {
    if (!isLoading) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      try {
        bool status = await postPayments(
          context: context,
          amount: widget.paymentAmount,
          paymentDate: DateTime.now().toString(),
          truckId: widget.truckId,
          paymentId: widget.paymentId,
        );
        if (status) {
          if (mounted) {
            setState(() {
              isLoading = false;
              ;
            });
          }
          getSnackbar(context, 'Payment Success');
          navigationPush(context, PaymentScreen());
        } else {
          if (mounted) {
            setState(() {
              isLoading = false;
              ;
            });
          }
          getSnackbar(context, 'Payment Failed');
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
            ;
          });
        }
        getSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopService().cancelPayment(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Payment Amount',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                widget.paymentAmount,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _togglePaymentMethod(true),
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: _isUpiSelected
                              ? AppColors.kPrimaryColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/upi_icon.png',
                              height: 24.h,
                              width: 24.w,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.h),
                            Text(
                              'UPI',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _togglePaymentMethod(false),
                      child: Container(
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: _isUpiSelected
                              ? Colors.grey
                              : AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/debit_card_icon.png',
                              height: 24.h,
                              width: 24.w,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Debit/Credit',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              if (_isUpiSelected)
                CustomTextField(
                  controller: _upi,
                  hintText: "UPI ID",
                  isPassword: false,
                ),
              if (!_isUpiSelected)
                CustomTextField(
                  controller: _card,
                  hintText: "Card Number",
                  isPassword: false,
                  keyboardType: TextInputType.number,
                ),
              Spacer(),
              StatusButton(
                onTap: () {
                  if (_isUpiSelected) {
                    if (_upi.text.isEmpty) {
                      getSnackbar(context, 'Enter UPI ID');
                    } else {
                      bool isValid = validateUpiId(_upi.text);
                      if (isValid) {
                        _processPayment();
                      } else {
                        getSnackbar(context, 'Invalid UPI ID');
                      }
                    }
                  } else {
                    if (_card.text.isEmpty) {
                      getSnackbar(context, 'Enter Card Details');
                    } else {
                      bool isValid = validateCardNumber(_card.text);
                      if (isValid) {
                        _processPayment();
                      } else {
                        getSnackbar(context, 'Invalid Card Number');
                      }
                    }
                  }
                },
                buttonText: 'Pay',
                status: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
