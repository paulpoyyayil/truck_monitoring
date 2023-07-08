import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/utils/custom_navigator.dart';

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
      context,
      CustomPageRoute(screen),
    );
    return result ?? false;
  }
}
