import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/big_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SelectRouteModal extends StatefulWidget {
  const SelectRouteModal({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<SelectRouteModal> createState() => _SelectRouteModalState();
}

class _SelectRouteModalState extends State<SelectRouteModal> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  bool isCashOnDelivery = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 22.h),
            CustomTextField(
              controller: controllers[0],
              isPassword: false,
              hintText: 'Name',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[1],
              isPassword: false,
              hintText: 'Address',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[2],
              isPassword: false,
              hintText: 'From (Location)',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[3],
              isPassword: false,
              hintText: 'To (Location)',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[4],
              isPassword: false,
              hintText: 'Phone Number',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[5],
              isPassword: false,
              hintText: 'Additional Phone Number',
            ),
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cash on Delivery'),
                Checkbox(
                  value: isCashOnDelivery,
                  onChanged: (value) {
                    setState(() {
                      isCashOnDelivery = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 22.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomBigButton(
                onTap: () {
                  if (controllers[0].text.isEmpty ||
                      controllers[1].text.isEmpty ||
                      controllers[2].text.isEmpty ||
                      controllers[3].text.isEmpty ||
                      controllers[4].text.isEmpty ||
                      controllers[5].text.isEmpty) {
                    Alert(
                        context: context,
                        type: AlertType.error,
                        closeIcon: const SizedBox.shrink(),
                        title: 'All fields are required',
                        buttons: [
                          DialogButton(
                            color: AppColors.kPrimaryColor,
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]).show();
                  } else {
                    Alert(
                        context: context,
                        type: AlertType.success,
                        closeIcon: const SizedBox.shrink(),
                        title: 'Route Selected successfully',
                        buttons: [
                          DialogButton(
                            color: AppColors.kPrimaryColor,
                            onPressed: () => navigationReplacement(
                              context,
                              Homepage(selectedIndex: 0),
                            ),
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]).show();
                  }
                },
                buttonText: 'Book',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
