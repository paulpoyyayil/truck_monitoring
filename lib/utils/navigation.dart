import 'package:flutter/material.dart';
import 'package:truck_monitor/utils/custom_navigator.dart';

void navigationPush(BuildContext context, Widget screen) {
  Navigator.push(
    context,
    CustomPageRoute(screen),
  );
}

void navigationReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    CustomPageRoute(screen),
  );
}
