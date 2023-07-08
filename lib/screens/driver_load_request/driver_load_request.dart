import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/custom_button.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';

class LoadRequest extends StatefulWidget {
  const LoadRequest({super.key});

  @override
  State<LoadRequest> createState() => _LoadRequestState();
}

class _LoadRequestState extends State<LoadRequest> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Load Request',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.kBorderColor,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
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
                child: Column(
                  children: [
                    SeparatedRowText(title: 'Name', text: 'Varun'),
                    SeparatedRowText(title: 'Address', text: 'Kozhikode'),
                    SeparatedRowText(title: 'From', text: 'Kozhikode'),
                    SeparatedRowText(title: 'To', text: 'Chennai'),
                    SeparatedRowText(title: 'Mobile', text: '9898656532'),
                    SeparatedRowText(
                        title: 'Additional Mobile', text: '9898656532'),
                    SeparatedRowText(title: 'Item', text: 'Rice'),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: CustomButton(
                  onTap: () {},
                  buttonText: 'Accept',
                  status: isLoading,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
