import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:truck_monitor/service/driver_data.dart';
import 'package:truck_monitor/service/edit_driver.dart';
import 'package:truck_monitor/service/edit_user.dart';
import 'package:truck_monitor/service/user_data.dart';
import 'package:truck_monitor/utils/logout_and_navigate.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/shared_pref.dart';
import 'package:remixicon/remixicon.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var _userModel;
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());

  bool isLoading = false;
  bool isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future _getData() async {
    logoutAndNavigate(context);
    try {
      _userModel = role == 'user'
          ? await getUserData(context: context)
          : await getDriverData(context: context);
      if (_userModel != null) {
        if (_userModel!.success!) {
          controllers[0].text = _userModel!.data!.name!;
          controllers[1].text = _userModel!.data!.mobile!;
          controllers[2].text = _userModel!.data!.email!;
        }
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _userModel == null
          ? SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: StatusButton(
                          onTap: () async {
                            if (mounted) {
                              setState(() {
                                isLoggingOut = true;
                              });
                            }
                            await Services().logout().then((value) {
                              if (mounted) {
                                setState(() {
                                  isLoggingOut = false;
                                });
                              }
                            });
                            if (context.mounted) {
                              navigationReplacement(
                                  context, const LoginScreen());
                            }
                          },
                          status: isLoggingOut,
                          buttonText: 'LOGOUT',
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: StatusButton(
                          onTap: () async {
                            if (!isLoading) {
                              if (mounted) {
                                setState(() {
                                  isLoading = true;
                                });
                              }
                              try {
                                bool status = role == 'user'
                                    ? await updateUser(
                                        context: context,
                                        name: controllers[0].text,
                                        mobile: controllers[1].text,
                                        email: controllers[2].text,
                                      )
                                    : await updateDriver(
                                        context: context,
                                        name: controllers[0].text,
                                        mobile: controllers[1].text,
                                        email: controllers[2].text,
                                      );
                                if (status) {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Center(
                                              child: CircularProgressIndicator
                                                  .adaptive()),
                                        ),
                                      );
                                    },
                                  );
                                  _getData().then(
                                      (value) => Navigator.of(context).pop());
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      isLoading = false;
                                    });
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
                          },
                          buttonText: 'EDIT',
                          status: isLoading,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w)
                ],
              ),
            ),
      body: _userModel == null
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 100.w,
                      width: 100.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: AppColors.kBorderColor,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      ),
                      child: Icon(
                        Remix.user_3_line,
                        size: 64.sp,
                        color: AppColors.kLightText,
                      ),
                    ),
                  ),
                  SizedBox(height: 48.h),
                  CustomTextField(
                    controller: controllers[0],
                    isPassword: false,
                    hintText: 'Name',
                  ),
                  SizedBox(height: 14.h),
                  CustomTextField(
                    controller: controllers[1],
                    isPassword: false,
                    hintText: 'Phone Number',
                  ),
                  SizedBox(height: 14.h),
                  CustomTextField(
                    controller: controllers[2],
                    isPassword: false,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 14.h),
                ],
              ),
            ),
    );
  }
}
