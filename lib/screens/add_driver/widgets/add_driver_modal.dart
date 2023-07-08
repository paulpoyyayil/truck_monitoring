import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/big_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddDriverModal extends StatefulWidget {
  const AddDriverModal({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<AddDriverModal> createState() => _AddDriverModalState();
}

class _AddDriverModalState extends State<AddDriverModal> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  bool ownVehicle = false;

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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
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
              hintText: 'Place',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[3],
              isPassword: false,
              hintText: 'Phone',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[4],
              isPassword: false,
              hintText: 'Date of Birth',
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
                      controllers[4].text.isEmpty) {
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
                        title: 'Driver successfully',
                        buttons: [
                          DialogButton(
                            color: AppColors.kPrimaryColor,
                            onPressed: () => navigationReplacement(
                              context,
                              Homepage(selectedIndex: 2),
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
                buttonText: 'Add Driver',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
