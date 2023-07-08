import 'package:flutter/material.dart';

getSnackbar(context, String content, {backgroundColor, textColor, duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? const Color(0xFF323232),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor ?? Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration ?? 2),
    ),
  );
}
