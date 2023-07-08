// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/add_driver/widgets/add_driver_modal.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/big_button.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Driver',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomBigButton(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                    builder: (context) {
                      return const AddDriverModal(title: 'Add Driver');
                    },
                  );
                },
                buttonText: 'ADD DRIVER',
              ),
            ),
            SizedBox(height: 12.w)
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: const Column(
          children: [
            CardOutline(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RowText(
                            title: 'Driver Name: ',
                            text: 'Ramu',
                          ),
                          RowText(
                            title: 'Location: ',
                            text: 'Kozhikode',
                          ),
                          RowText(
                            title: 'Phone Number: ',
                            text: '9898656532',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
