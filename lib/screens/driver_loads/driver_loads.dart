import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/driver_loads.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/driver_loads.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';

class DriverLoads extends StatefulWidget {
  const DriverLoads({super.key});

  @override
  State<DriverLoads> createState() => _DriverLoadsState();
}

class _DriverLoadsState extends State<DriverLoads> {
  DriverLoadsModel? _loadsModel;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _loadsModel = await getAllDriverLoads(context: context);
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
        title: 'Accepted Loads',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: _loadsModel == null
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : _loadsModel!.data!.isEmpty
              ? Center(
                  child: Text(
                    'No Accepted Loads',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return CardOutline(
                        child: Column(
                          children: [
                            SeparatedRowText(
                                title: 'Customer:',
                                text: _loadsModel!
                                    .data![index].username!.titleCase),
                            SeparatedRowText(
                                title: 'Driver Name:',
                                text: _loadsModel!
                                    .data![index].drivername!.titleCase),
                            SeparatedRowText(
                                title: 'From:',
                                text: _loadsModel!.data![index].loadFrom!
                                    .toUpperCase()),
                            SeparatedRowText(
                                title: 'To:',
                                text: _loadsModel!.data![index].loadTo!
                                    .toUpperCase()),
                            SeparatedRowText(
                                title: 'Quantity:',
                                text: _loadsModel!.data![index].loadQuantity!),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 14.h),
                    itemCount: _loadsModel!.data!.length,
                  ),
                ),
    );
  }
}
