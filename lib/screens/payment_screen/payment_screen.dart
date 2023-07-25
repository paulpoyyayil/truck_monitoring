import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/payments.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/payment_screen/widgets/payment_card.dart';
import 'package:truck_monitor/service/payments.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentsModel? _paymentsModel;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _paymentsModel = await getPayment(context: context);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          WillPopService().backFunction(context, Homepage(selectedIndex: 0)),
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Payments',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        body: _paymentsModel == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return PaymentCard(
                      truckName: _paymentsModel!.data![index].truckName!,
                      driverName: _paymentsModel!.data![index].driverName!,
                      loadQuantity: _paymentsModel!.data![index].loadQuantity!,
                      from: _paymentsModel!.data![index].starting!,
                      to: _paymentsModel!.data![index].ending!,
                      amount: _paymentsModel!.data![index].amount,
                      paymentDate: _paymentsModel!.data![index].paymentDate,
                      paymentId: _paymentsModel!.data![index].id.toString(),
                      truckId: _paymentsModel!.data![index].truckId.toString(),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemCount: _paymentsModel!.data!.length,
                ),
              ),
      ),
    );
  }
}
