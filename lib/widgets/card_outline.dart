import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';

class CardOutline extends StatelessWidget {
  const CardOutline({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.kBorderColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 4,
            color: AppColors.kShadowColor,
          )
        ],
      ),
      child: child,
    );
  }
}
