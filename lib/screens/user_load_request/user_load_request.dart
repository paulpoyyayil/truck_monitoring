import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/user_add_load.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class UserLoadRequest extends StatefulWidget {
  const UserLoadRequest({super.key});

  @override
  State<UserLoadRequest> createState() => _UserLoadRequestState();
}

class _UserLoadRequestState extends State<UserLoadRequest> {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Add Load',
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
              child: StatusButton(
                onTap: () async {
                  if (controllers[0].text.isEmpty ||
                      controllers[1].text.isEmpty ||
                      controllers[2].text.isEmpty ||
                      controllers[3].text.isEmpty) {
                    getSnackbar(context, 'Add all data');
                  } else {
                    if (!isLoading) {
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      try {
                        bool status = await userAddLoad(
                          context: context,
                          desciption: controllers[0].text,
                          from: controllers[1].text,
                          to: controllers[2].text,
                          quantity: controllers[3].text,
                        );
                        if (status) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (mounted) {
                            getSnackbar(context, 'Load Added successfully');
                            navigationPush(context, Homepage(selectedIndex: 0));
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (mounted) {
                            getSnackbar(context, 'Unexpected error occurred.');
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        getSnackbar(context, e.toString());
                      }
                    }
                  }
                },
                buttonText: 'ADD LOAD',
                status: isLoading,
              ),
            ),
            SizedBox(height: 12.w)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              CustomTextField(
                controller: controllers[0],
                hintText: "Load Description",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[1],
                hintText: "From",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[2],
                hintText: "To",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[3],
                hintText: "Load Quantity",
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
