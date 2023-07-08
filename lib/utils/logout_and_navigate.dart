import 'package:flutter/material.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/shared_pref.dart';

logoutAndNavigate(BuildContext context) async {
  if (role == null) {
    if (isLoggedIn) Services().logout();
    if (context.mounted) {
      navigationReplacement(context, const LoginScreen());
    }
  }
}
