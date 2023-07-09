import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/all_loads.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/load_request_card.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/all_loads.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';

class DriverLoadRequest extends StatefulWidget {
  const DriverLoadRequest({super.key});

  @override
  State<DriverLoadRequest> createState() => _DriverLoadRequestState();
}

class _DriverLoadRequestState extends State<DriverLoadRequest> {
  AllLoadsModel? _loadsModel;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _loadsModel = await getAllLoads(context: context);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          WillPopService().backFunction(context, Homepage(selectedIndex: 0)),
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Load Request',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        body: _loadsModel == null
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: ListView.separated(
                  itemBuilder: (context, index) => LoadRequestCard(
                    customerName: _loadsModel!.data![index].username!,
                    description: _loadsModel!.data![index].loadDescription!,
                    from: _loadsModel!.data![index].loadFrom!,
                    to: _loadsModel!.data![index].loadTo!,
                    quantity: _loadsModel!.data![index].loadQuantity!,
                    userId: _loadsModel!.data![index].user.toString(),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemCount: 2,
                ),
              ),
      ),
    );
  }
}
