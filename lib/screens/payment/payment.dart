import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/payment/widgets/payment_card.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/app_bar.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Bookings',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: const PaymentCard(
            name: 'Varun',
            address: 'Kozhikode',
            from: 'Kozhikode',
            to: 'Chennai',
            mob: '9898656532',
            addMob: '9898656532',
            payment: 'COD',
          ),
        ),
      ),
    );
  }
}
