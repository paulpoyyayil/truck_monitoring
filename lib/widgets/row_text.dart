import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.title,
    required this.text,
  });
  final String title, text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12.sp),
        ),
      ],
    );
  }
}
