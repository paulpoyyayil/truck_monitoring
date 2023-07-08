import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/user_registration.dart';
import 'package:truck_monitor/screens/login/login.dart';
import 'package:truck_monitor/service/register_user.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController location = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    email.dispose();
    userName.dispose();
    password.dispose();
    location.dispose();
    super.dispose();
  }

  bool validate() {
    if (name.text.isEmpty ||
        mobile.text.isEmpty ||
        email.text.isEmpty ||
        userName.text.isEmpty ||
        password.text.isEmpty ||
        location.text.isEmpty) {
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
            SizedBox(height: 40.h),
            CustomTextField(
              controller: name,
              hintText: "Name",
              isPassword: false,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: email,
              hintText: "Email",
              isPassword: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: mobile,
              hintText: "Mobile Number",
              isPassword: false,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: userName,
              hintText: "Username",
              isPassword: false,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: password,
              hintText: 'Password',
              isPassword: true,
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: location,
              hintText: 'Location',
              isPassword: false,
            ),
            SizedBox(height: 48.h),
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
                        UserRegistrationModel apiStatus = await registerUser(
                          context: context,
                          name: name.text,
                          email: email.text,
                          mobileNumber: mobile.text,
                          userName: userName.text,
                          password: password.text,
                          location: location.text,
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
