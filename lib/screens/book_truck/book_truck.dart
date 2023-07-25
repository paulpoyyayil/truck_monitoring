import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/models/truck_listing.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/truck_listing.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';
import 'package:recase/recase.dart';
import 'package:remixicon/remixicon.dart';

import 'widgets/book_truck_modal.dart';

class BookTruck extends StatefulWidget {
  const BookTruck({super.key});

  @override
  State<BookTruck> createState() => _BookTruckState();
}

class _BookTruckState extends State<BookTruck> {
  TruckListingModel? _truckListing;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _truckListing = await getTruckListing(context: context);
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
        title: 'Book Truck',
        isMainTab: false,
        onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
      ),
      body: _truckListing == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: ListView.separated(
                itemCount: _truckListing!.data!.length,
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
                                  text: _truckListing!
                                      .data![index].driverName!.titleCase,
                                ),
                                RowText(
                                  title: 'From: ',
                                  text: _truckListing!
                                      .data![index].truckfrom!.titleCase,
                                ),
                                RowText(
                                  title: 'To: ',
                                  text: _truckListing!
                                      .data![index].truckto!.titleCase,
                                ),
                                RowText(
                                  title: 'Vehicle: ',
                                  text: _truckListing!
                                      .data![index].truckName!.titleCase,
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
                                return BookTruckModal(
                                  title: 'Book Truck',
                                  truckId:
                                      _truckListing!.data![index].id.toString(),
                                  driverId: _truckListing!.data![index].driver
                                      .toString(),
                                  truckName:
                                      _truckListing!.data![index].truckName!,
                                  driverName:
                                      _truckListing!.data![index].driverName!,
                                );
                              },
                            );
                          },
                          buttonText: 'Book',
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
    );
  }
}
