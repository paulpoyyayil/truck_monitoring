import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:truck_monitor/screens/registration/driver_registration.dart';
import 'package:truck_monitor/screens/registration/user_registration.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:remixicon/remixicon.dart';

class RegistrationType extends StatefulWidget {
  const RegistrationType({super.key});

  @override
  State<RegistrationType> createState() => _RegistrationTypeState();
}

class _RegistrationTypeState extends State<RegistrationType> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          WillPopService().backFunction(context, const LoginScreen()),
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Already have an account? ',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      navigationPush(context, const LoginScreen());
                    },
                  text: 'Login Now ',
                  style: const TextStyle(
                    color: Color(0xffF4A124),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      navigationPush(context, const UserRegistration()),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: CardOutline(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Remix.user_line,
                              size: 96,
                              color: Colors.black,
                            ),
                            Text(
                              'User',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      navigationPush(context, const DriverRegistration()),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: CardOutline(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Remix.steering_2_fill,
                              size: 96,
                              color: Colors.black,
                            ),
                            Text(
                              'Driver',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
