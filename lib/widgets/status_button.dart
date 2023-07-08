import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:truck_monitor/config/colors.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    required this.buttonText,
    required this.status,
  });
  final VoidCallback onTap;
  final Color? backgroundColor;
  final String buttonText;
  final bool status;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            status
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.kBackgroundColor,
                    size: 24.sp,
                  )
                : Text(buttonText),
          ],
        ),
      ),
    );
  }
}
