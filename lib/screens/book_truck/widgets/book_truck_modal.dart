import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/models/book_truck.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/book_truck.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookTruckModal extends StatefulWidget {
  const BookTruckModal({
    Key? key,
    required this.title,
    required this.truckId,
    required this.driverId,
    required this.truckName,
    required this.driverName,
  }) : super(key: key);

  final String title, truckId, driverId, driverName, truckName;

  @override
  State<BookTruckModal> createState() => _BookTruckModalState();
}

class _BookTruckModalState extends State<BookTruckModal> {
  late BuildContext _dialogContext;
  List<TextEditingController> controllers =
      List.generate(3, (index) => TextEditingController());
  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  _bookTruck() async {
    if (!isLoading) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      try {
        BookTruckModel? truckBooking = await bookTruck(
          context: context,
          load: controllers[0].text,
          truckName: widget.truckName,
          driverName: widget.driverName,
          from: controllers[1].text,
          to: controllers[2].text,
          date: DateFormat('dd-MM-yyyy').format(selectedDate).toString(),
          driverId: widget.driverId,
          truckId: widget.truckId,
        );
        if (truckBooking.success!) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          if (mounted) {
            Navigator.pop(context);
            getSnackbar(context, truckBooking.message!);
            navigationPush(context, Homepage(selectedIndex: 0));
          }
        } else {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
          if (mounted) {
            Alert(
              context: context,
              type: AlertType.error,
              closeIcon: const SizedBox.shrink(),
              title: truckBooking.message!,
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
              ],
            ).show();
          }
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
          title: e.toString(),
          buttons: [
            DialogButton(
              color: AppColors.kPrimaryColor,
              onPressed: () {
                Navigator.of(_dialogContext).pop();
                Navigator.pop(context);
              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _dialogContext = context;
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
              hintText: 'Load',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[1],
              isPassword: false,
              hintText: 'From (Location)',
            ),
            SizedBox(height: 14.h),
            CustomTextField(
              controller: controllers[2],
              isPassword: false,
              hintText: 'To (Location)',
            ),
            SizedBox(height: 14.h),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                ).then((date) {
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(146, 147, 149, 0.50),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  DateFormat('dd-MM-yyyy').format(selectedDate),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.kLightText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StatusButton(
                status: isLoading,
                onTap: () {
                  if (controllers[0].text.isEmpty ||
                      controllers[1].text.isEmpty ||
                      controllers[2].text.isEmpty) {
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
                      ],
                    ).show();
                  } else {
                    _bookTruck();
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
