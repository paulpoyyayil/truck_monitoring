import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';

class CustomBigButton extends StatelessWidget {
  const CustomBigButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    required this.buttonText,
  });
  final VoidCallback onTap;
  final Color? backgroundColor;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      onPressed: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(buttonText),
      ),
    );
  }
}
