import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/driver_load_request/driver_load_request.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/custom_button.dart';
import 'package:truck_monitor/service/driver_request_load.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class LoadRequestCard extends StatefulWidget {
  const LoadRequestCard(
      {super.key,
      required this.customerName,
      required this.description,
      required this.from,
      required this.to,
      required this.quantity,
      required this.userId});
  final String userId, customerName, description, from, to, quantity;

  @override
  State<LoadRequestCard> createState() => _LoadRequestCardState();
}

class _LoadRequestCardState extends State<LoadRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 14.h,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.kBorderColor,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                spreadRadius: 0,
                blurRadius: 4,
                color: AppColors.kShadowColor,
              )
            ],
          ),
          child: Column(
            children: [
              SeparatedRowText(
                  title: 'Name', text: widget.customerName.titleCase),
              SeparatedRowText(
                  title: 'Description', text: widget.description.titleCase),
              SeparatedRowText(title: 'From', text: widget.from.toUpperCase()),
              SeparatedRowText(title: 'To', text: widget.to.toUpperCase()),
              SeparatedRowText(title: 'Quantity', text: widget.quantity),
            ],
          ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          child: CustomButton(
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
                  return RequestLoadWidget(userId: widget.userId);
                },
              );
            },
            buttonText: 'Request Load',
            status: false,
          ),
        ),
      ],
    );
  }
}

class RequestLoadWidget extends StatefulWidget {
  const RequestLoadWidget({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  State<RequestLoadWidget> createState() => _RequestLoadWidgetState();
}

class _RequestLoadWidgetState extends State<RequestLoadWidget> {
  TextEditingController loadFrom = TextEditingController();
  TextEditingController loadTo = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    loadFrom.dispose();
    loadTo.dispose();
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
              'Request Load',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 22.h),
            CustomTextField(
              controller: loadFrom,
              isPassword: false,
              hintText: 'Load From',
            ),
            SizedBox(height: 16.h),
            CustomTextField(
              controller: loadTo,
              isPassword: false,
              hintText: 'Load To',
            ),
            SizedBox(height: 22.h),
            StatusButton(
              onTap: () async {
                if (loadFrom.text.isEmpty || loadTo.text.isEmpty) {
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
                  if (!isLoading) {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    try {
                      bool status = await driverRequestLoad(
                        context: context,
                        userId: widget.userId,
                        loadFrom: loadFrom.text,
                        loadTo: loadTo.text,
                      );
                      if (status) {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        Navigator.of(context).pop();
                        getSnackbar(context, 'Requested Successfully');
                        navigationPush(context, DriverLoadRequest());
                      } else {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        Alert(
                            context: context,
                            type: AlertType.error,
                            closeIcon: const SizedBox.shrink(),
                            title: 'Unexpected error occurred.',
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
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      Alert(
                          context: context,
                          type: AlertType.error,
                          closeIcon: const SizedBox.shrink(),
                          title: 'Unexpected error occurred.',
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
                    }
                  }
                }
              },
              buttonText: 'Request',
              status: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
