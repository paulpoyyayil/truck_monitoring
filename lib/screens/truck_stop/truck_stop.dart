import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/all_drivers.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/all_driver.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:remixicon/remixicon.dart';

class TruckStop extends StatefulWidget {
  const TruckStop({super.key});

  @override
  State<TruckStop> createState() => _TruckStopState();
}

class _TruckStopState extends State<TruckStop> {
  AllDriverModel? _allDriverModel;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _allDriverModel = await getAllDriver(context: context);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Truck Stop',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: _allDriverModel == null
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CardOutline(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              child: Icon(Remix.user_2_line),
                            ),
                            SizedBox(width: 14.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RowText(
                                  title: 'Name: ',
                                  text: _allDriverModel!
                                      .data![index].name!.titleCase,
                                ),
                                RowText(
                                  title: 'Location: ',
                                  text: _allDriverModel!.data![index].location!
                                      .toUpperCase(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SmallButton(
                          onTap: () async {
                            List<Location> locations =
                                await locationFromAddress(
                                    _allDriverModel!.data![index].location!);

                            MapsLauncher.launchCoordinates(
                              locations.first.latitude,
                              locations.first.longitude,
                              _allDriverModel!.data![index].location,
                            );
                          },
                          buttonText: 'Location',
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemCount: _allDriverModel!.data!.length,
              ),
            ),
    );
  }
}
