import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.kBorderColor,
              ),
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.kCardBackground,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 8,
                  color: AppColors.kShadowColor,
                )
              ],
            ),
            child: Icon(
              icon,
              size: 64.sp,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
