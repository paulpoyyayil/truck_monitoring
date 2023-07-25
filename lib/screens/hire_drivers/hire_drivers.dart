import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/models/driver_list.dart';
import 'package:truck_monitor/screens/driver_details/driver_details.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/driver_listing.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';
import 'package:recase/recase.dart';
import 'package:remixicon/remixicon.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HireDrivers extends StatefulWidget {
  const HireDrivers({super.key});

  @override
  State<HireDrivers> createState() => _HireDriversState();
}

class _HireDriversState extends State<HireDrivers> {
  DriverListModel? _withVehicle;
  DriverListModel? _withoutVehicle;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _withVehicle = await getDriverListing(
        context: context,
        endPoint: ApiConstants.driverWithVehicle,
      );

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
    try {
      if (mounted) {
        _withoutVehicle = await getDriverListing(
          context: context,
          endPoint: ApiConstants.driverWithoutVehicle,
        );
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        getSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Hire Drivers',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        body: IgnorePointer(
          ignoring: _withVehicle == null ? true : false,
          child: Column(
            children: [
              Container(
                color: AppColors.kPrimaryColor,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: const Text(
                          'Driver\n(with vehicle)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: const Text(
                          'Driver\n(without vehicle)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _withVehicle == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 24.h,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _withVehicle!.data!.length,
                              itemBuilder: (context, index) {
                                return CardOutline(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            child: Icon(Remix.user_2_line),
                                          ),
                                          SizedBox(width: 14.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RowText(
                                                title: 'Name: ',
                                                text: _withVehicle!.data![index]
                                                    .name!.titleCase,
                                              ),
                                              RowText(
                                                title: 'Location: ',
                                                text: _withVehicle!.data![index]
                                                    .location!.titleCase,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SmallButton(
                                        onTap: () {
                                          Alert(
                                              context: context,
                                              type: AlertType.success,
                                              closeIcon:
                                                  const SizedBox.shrink(),
                                              title: 'Hired successfully',
                                              buttons: [
                                                DialogButton(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  onPressed: () =>
                                                      navigationPush(
                                                    context,
                                                    DriverDetails(
                                                      name: _withVehicle!
                                                          .data![index]
                                                          .name!
                                                          .titleCase,
                                                      location: _withVehicle!
                                                          .data![index]
                                                          .location!
                                                          .titleCase,
                                                      route:
                                                          '${_withVehicle!.data![index].transportFrom!.titleCase} - ${_withVehicle!.data![index].transportTo!.titleCase}',
                                                      phoneNumber: _withVehicle!
                                                          .data![index].mobile!,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'View Details',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ]).show();
                                        },
                                        buttonText: 'Hire',
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 14.h);
                              },
                            ),
                          ),
                    _withoutVehicle == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 24.h,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _withoutVehicle!.data!.length,
                              itemBuilder: (context, index) {
                                return CardOutline(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            child: Icon(Remix.user_2_line),
                                          ),
                                          SizedBox(width: 14.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RowText(
                                                title: 'Name: ',
                                                text: _withoutVehicle!
                                                    .data![index]
                                                    .name!
                                                    .titleCase,
                                              ),
                                              RowText(
                                                title: 'Location: ',
                                                text: _withoutVehicle!
                                                    .data![index]
                                                    .location!
                                                    .titleCase,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SmallButton(
                                        onTap: () {
                                          Alert(
                                              context: context,
                                              type: AlertType.success,
                                              closeIcon:
                                                  const SizedBox.shrink(),
                                              title: 'Hired successfully',
                                              buttons: [
                                                DialogButton(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  onPressed: () =>
                                                      navigationPush(
                                                    context,
                                                    DriverDetails(
                                                      name: _withoutVehicle!
                                                          .data![index]
                                                          .name!
                                                          .titleCase,
                                                      location: _withoutVehicle!
                                                          .data![index]
                                                          .location!
                                                          .titleCase,
                                                      route:
                                                          '${_withoutVehicle!.data![index].transportFrom!.titleCase} - ${_withoutVehicle!.data![index].transportTo!.titleCase}',
                                                      phoneNumber:
                                                          _withoutVehicle!
                                                              .data![index]
                                                              .mobile!,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Ok',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ]).show();
                                        },
                                        buttonText: 'Hire',
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 14.h);
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
