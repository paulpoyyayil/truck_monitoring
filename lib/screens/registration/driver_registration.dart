import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/driver_registration.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:truck_monitor/service/register_driver.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController license = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();
  bool hasVehicle = false;

  bool isLoading = false;

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    email.dispose();
    userName.dispose();
    password.dispose();
    license.dispose();
    from.dispose();
    to.dispose();
    super.dispose();
  }

  bool validate() {
    if (name.text.isEmpty ||
        mobile.text.isEmpty ||
        email.text.isEmpty ||
        userName.text.isEmpty ||
        password.text.isEmpty ||
        location.text.isEmpty ||
        license.text.isEmpty ||
        from.text.isEmpty ||
        to.text.isEmpty) {
      getSnackbar(context, 'All fields are required');
      return false;
    }
    if (!EmailValidator.validate(email.text)) {
      getSnackbar(context, 'Invalid Email');
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create an Account',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 28.sp,
              ),
            ),
            Text(
              'Register to get started',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 32.h),
            CustomTextField(
              controller: name,
              hintText: "Name",
              isPassword: false,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: email,
              hintText: "Email",
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: mobile,
              hintText: "Mobile Number",
              isPassword: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: userName,
              hintText: "Username",
              isPassword: false,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: password,
              hintText: 'Password',
              isPassword: true,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: license,
              hintText: 'License Number',
              isPassword: false,
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: location,
              hintText: 'Location',
              isPassword: false,
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: from,
                      hintText: 'From',
                      isPassword: false,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: CustomTextField(
                      controller: to,
                      hintText: 'To',
                      isPassword: false,
                    ),
                  ),
                ],
              ),
            ),
            CheckboxListTile(
              title: const Text('Vehicle Status'),
              value: hasVehicle,
              onChanged: (value) {
                setState(() {
                  hasVehicle = value!;
                });
              },
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StatusButton(
                status: isLoading,
                buttonText: 'Sign Up',
                onTap: () async {
                  if (!isLoading) {
                    bool isValid = validate();
                    if (isValid) {
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      try {
                        DriverRegistrationModel apiStatus =
                            await registerDriver(
                          context: context,
                          name: name.text,
                          email: email.text,
                          mobileNumber: mobile.text,
                          userName: userName.text,
                          password: password.text,
                          location: location.text,
                          licenceNo: license.text,
                          from: from.text,
                          to: to.text,
                          vehicleStatus: hasVehicle ? 'yes' : 'no',
                        );
                        if (apiStatus.success!) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (context.mounted) {
                            navigationReplacement(context, const LoginScreen());
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (context.mounted) {
                            getSnackbar(context, apiStatus.message!);
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
    );
  }
}
