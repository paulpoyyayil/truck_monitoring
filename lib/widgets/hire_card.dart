import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';

class HireCard extends StatelessWidget {
  const HireCard({
    super.key,
    required this.name,
    required this.route,
    required this.item,
    this.onTapped,
    required this.buttonText,
  });
  final String name, route, item;
  final String buttonText;
  final dynamic onTapped;

  @override
  Widget build(BuildContext context) {
    return CardOutline(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowText(
                title: 'Name: ',
                text: name,
              ),
              SizedBox(height: 4.h),
              RowText(
                title: 'Route: ',
                text: route,
              ),
              SizedBox(height: 4.h),
              RowText(
                title: 'Item: ',
                text: item,
              ),
            ],
          ),
          Column(
            children: [
              SmallButton(
                onTap: onTapped,
                buttonText: buttonText,
              ),
            ],
          )
        ],
      ),
    );
  }
}
