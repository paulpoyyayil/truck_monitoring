import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/registration/select_reg_type.dart';
import 'package:truck_monitor/service/login.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000))
        .then((value) => _askPermission());
  }

  _askPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopService().exitApp(context),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Don’t have an account? ',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigationPush(context, const RegistrationType());
                    },
                  text: 'Create Now ',
                  style: const TextStyle(
                    color: Color(0xffF4A124),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 36.sp,
                ),
              ),
              Text(
                'Login to your account',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 40.h),
              CustomTextField(
                controller: _userName,
                hintText: "Your Username",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: _password,
                hintText: 'Your Password',
                isPassword: true,
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: StatusButton(
                  buttonText: 'Login',
                  status: isLoading,
                  onTap: () async {
                    if (!isLoading) {
                      if (_userName.text.isEmpty || _password.text.isEmpty) {
                        if (context.mounted) {
                          getSnackbar(context, 'All fields are required');
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        try {
                          bool apiStatus = await login(
                            context: context,
                            userName: _userName.text,
                            password: _password.text,
                          );
                          if (apiStatus) {
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            if (context.mounted) {
                              navigationReplacement(
                                  context, Homepage(selectedIndex: 0));
                            }
                          } else {
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            if (context.mounted) {
                              getSnackbar(context, 'Invalid login credentials');
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (context.mounted) {
                            getSnackbar(context, e.toString());
                          }
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
