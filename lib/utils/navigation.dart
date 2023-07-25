import 'package:flutter/material.dart';

void navigationPush(BuildContext context, Widget screen) {
  if (context.mounted) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) => screen)));
  }
}

void navigationReplacement(BuildContext context, Widget screen) {
  if (context.mounted) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => screen)));
  }
}
