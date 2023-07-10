import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truck_monitor/utils/custom_navigator.dart';

void navigationPush(BuildContext context, Widget screen) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      Navigator.push(
        context,
        CustomPageRoute(screen),
      );
    }
  });
}

void navigationReplacement(BuildContext context, Widget screen) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        CustomPageRoute(screen),
      );
    }
  });
}
