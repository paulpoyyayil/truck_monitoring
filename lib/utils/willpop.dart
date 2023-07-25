import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/payment_screen/payment_screen.dart';
import 'package:truck_monitor/utils/navigation.dart';

class WillPopService {
  Future<bool> exitApp(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit ?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> backFunction(BuildContext context, Widget screen) async {
    bool? result = await Navigator.push<bool?>(
        context, MaterialPageRoute(builder: ((context) => screen)));
    return result ?? false;
  }

  Future<bool> cancelPayment(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Go back'),
            content: const Text('Do you want to cancel payment ?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                ),
                onPressed: () =>
                    navigationReplacement(context, const PaymentScreen()),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
