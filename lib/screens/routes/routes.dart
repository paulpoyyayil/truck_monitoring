import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/screens/routes/widgets/select_route_modal.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';

class Routes extends StatefulWidget {
  const Routes({super.key});

  @override
  State<Routes> createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Routes',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              CardOutline(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowText(
                              title: 'From: ',
                              text: 'Kozhikode',
                            ),
                            RowText(
                              title: 'To: ',
                              text: 'Chennai',
                            ),
                            RowText(
                              title: 'Vehicle: ',
                              text: 'Tipper',
                            ),
                            RowText(
                              title: 'Driver: ',
                              text: 'Ragu',
                            ),
                            RowText(
                              title: 'Contact: ',
                              text: '9898656532',
                            ),
                          ],
                        ),
                      ],
                    ),
                    SmallButton(
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
                            return const SelectRouteModal(
                                title: 'Select Route');
                          },
                        );
                      },
                      buttonText: 'Select Route',
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
