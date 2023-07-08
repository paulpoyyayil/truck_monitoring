import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/utils/logout_and_navigate.dart';
import 'package:truck_monitor/widgets/hire_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  void initState() {
    super.initState();
    logoutAndNavigate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        children: [
          ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return HireCard(
                name: 'Varun',
                route: 'Calicut - Chennai',
                item: 'Rice',
                buttonText: role == 'user' ? 'Hire' : 'Accept',
                onTapped: () {
                  Alert(
                      context: context,
                      type: AlertType.success,
                      closeIcon: const SizedBox.shrink(),
                      title: role == 'user'
                          ? 'Hired successfully'
                          : 'Accepted successfully',
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
                      ]).show();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 14.h);
            },
          ),
        ],
      ),
    );
  }
}
