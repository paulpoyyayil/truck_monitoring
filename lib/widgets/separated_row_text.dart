import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeparatedRowText extends StatelessWidget {
  const SeparatedRowText({
    super.key,
    required this.title,
    required this.text,
  });
  final String title, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 1 / 2.25,
            child: Text(
              text,
              style: TextStyle(fontSize: 12.sp),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
