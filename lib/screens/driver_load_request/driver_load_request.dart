import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/load_request_card.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/app_bar.dart';

class LoadRequest extends StatefulWidget {
  const LoadRequest({super.key});

  @override
  State<LoadRequest> createState() => _LoadRequestState();
}

class _LoadRequestState extends State<LoadRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Load Request',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: ListView.separated(
          itemBuilder: (context, index) => LoadRequestCard(),
          separatorBuilder: (context, index) => SizedBox(height:14.h),
          itemCount: 2,
        ),
      ),
    );
  }
}
