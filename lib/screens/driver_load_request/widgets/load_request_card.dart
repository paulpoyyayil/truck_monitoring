import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/screens/driver_load_request/widgets/custom_button.dart';
import 'package:truck_monitor/widgets/separated_row_text.dart';

class LoadRequestCard extends StatefulWidget {
  const LoadRequestCard(
      {super.key,
      required this.customerName,
      required this.description,
      required this.from,
      required this.to,
      required this.quantity});
  final String customerName, description, from, to, quantity;

  @override
  State<LoadRequestCard> createState() => _LoadRequestCardState();
}

class _LoadRequestCardState extends State<LoadRequestCard> {
  bool isLoading = false;

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
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
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
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
              Future.delayed(Duration(seconds: 2)).then((value) {
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            },
            buttonText: 'Accept',
            status: isLoading,
          ),
        ),
      ],
    );
  }
}
