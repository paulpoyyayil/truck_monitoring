import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/add_truck.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/add_truck.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Add Vehicle',
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
                      controllers[3].text.isEmpty ||
                      controllers[4].text.isEmpty) {
                    getSnackbar(context, 'Add all data');
                  } else {
                    if (!isLoading) {
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                      try {
                        AddTruckModel data = await addTruck(
                          context: context,
                          truckName: controllers[0].text,
                          truckNumber: controllers[1].text,
                          truckFrom: controllers[2].text,
                          truckTo: controllers[3].text,
                          loadCapacity: controllers[4].text,
                        );
                        if (data.success!) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (mounted) {
                            getSnackbar(context, data.message!);
                            navigationPush(context, Homepage(selectedIndex: 0));
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          if (mounted) {
                            getSnackbar(context, data.message!);
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
                buttonText: 'ADD VEHICLE',
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
                hintText: "Vehicle Type",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[1],
                hintText: "Truck Number",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[2],
                hintText: "Starting Point",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[3],
                hintText: "Ending Point",
                isPassword: false,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: controllers[4],
                hintText: "Load Capacity",
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
