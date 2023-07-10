import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/service/all_driver.dart';
import 'package:truck_monitor/service/all_users.dart';
import 'package:truck_monitor/service/user_send_chat.dart';
import 'package:truck_monitor/utils/logout_and_navigate.dart';
import 'package:truck_monitor/utils/call.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/small_button.dart';
import 'package:recase/recase.dart';
import 'package:remixicon/remixicon.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class PhoneTab extends StatefulWidget {
  const PhoneTab({Key? key}) : super(key: key);

  @override
  State<PhoneTab> createState() => _PhoneTabState();
}

class _PhoneTabState extends State<PhoneTab> {
  var _allDriverModel;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    logoutAndNavigate(context);
    try {
      _allDriverModel = role == 'user'
          ? await getAllDriver(context: context)
          : await getAllUsers(context: context);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: role == 'user' ? 2 : 1,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            if (role == 'user')
              Container(
                color: AppColors.kPrimaryColor,
                child: const TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: Icon(Remix.phone_fill),
                      text: 'Calls',
                    ),
                    Tab(
                      icon: Icon(Remix.message_fill),
                      text: 'Chats',
                    ),
                  ],
                ),
              ),
            if (role == 'driver')
              Container(
                color: AppColors.kPrimaryColor,
                child: const TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: Icon(Remix.message_fill),
                      text: 'Chats',
                    ),
                  ],
                ),
              ),
            if (role == 'user')
              Expanded(
                child: TabBarView(
                  children: [
                    _allDriverModel == null
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 14.h,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _allDriverModel!.data!.length,
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
                                                text: _allDriverModel!
                                                    .data![index].name!
                                                    .toString()
                                                    .titleCase,
                                              ),
                                              RowText(
                                                title: 'Location: ',
                                                text: _allDriverModel!
                                                    .data![index].location!
                                                    .toString()
                                                    .titleCase,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SmallButton(
                                        onTap: () => makePhoneCall(
                                            _allDriverModel!
                                                .data![index].mobile!),
                                        buttonText: 'Call',
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
                    _allDriverModel == null
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 14.h,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _allDriverModel!.data!.length,
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
                                                text: _allDriverModel!
                                                    .data![index].name!
                                                    .toString()
                                                    .titleCase,
                                              ),
                                              RowText(
                                                title: 'Location: ',
                                                text: _allDriverModel!
                                                    .data![index].location!
                                                    .toString()
                                                    .titleCase,
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
                                              return ChatModal(
                                                driverName: _allDriverModel!
                                                    .data![index].name!,
                                                driverId: _allDriverModel!
                                                    .data![index].id
                                                    .toString(),
                                              );
                                            },
                                          );
                                        },
                                        buttonText: 'Message',
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
            if (role == 'driver')
              Expanded(
                child: TabBarView(
                  children: [
                    _allDriverModel == null
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 14.h,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _allDriverModel!.data!.length,
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
                                                text: _allDriverModel!
                                                    .data![index].name!
                                                    .toString()
                                                    .titleCase,
                                              ),
                                              RowText(
                                                title: 'Location: ',
                                                text: _allDriverModel!
                                                    .data![index].location!
                                                    .toString()
                                                    .titleCase,
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
                                              return ChatModal(
                                                driverName: _allDriverModel!
                                                    .data![index].name!,
                                                driverId: _allDriverModel!
                                                    .data![index].id
                                                    .toString(),
                                              );
                                            },
                                          );
                                        },
                                        buttonText: 'Message',
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
    );
  }
}

class ChatModal extends StatefulWidget {
  const ChatModal({
    super.key,
    required this.driverName,
    required this.driverId,
  });
  final String driverName, driverId;

  @override
  State<ChatModal> createState() => _ChatModalState();
}

class _ChatModalState extends State<ChatModal> {
  TextEditingController message = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 18.h,
        ),
        child: Column(
          children: [
            Text(
              'Message ${widget.driverName.titleCase}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: message,
              hintText: 'Message',
              isPassword: false,
            ),
            SizedBox(height: 22.h),
            StatusButton(
              onTap: () async {
                if (message.text.isEmpty) {
                  Alert(
                      context: context,
                      type: AlertType.error,
                      closeIcon: const SizedBox.shrink(),
                      title: 'Enter message',
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
                } else {
                  if (!isLoading) {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    try {
                      bool status = await userSendChat(
                        context: context,
                        driverId: widget.driverId,
                        chat: message.text,
                      );
                      if (status) {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        getSnackbar(context, 'Message Sent');
                        Navigator.pop(context);
                      } else {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                        getSnackbar(context, 'Unexpected error occurred.');
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      getSnackbar(context, e.toString());
                      Navigator.pop(context);
                    }
                  }
                }
              },
              buttonText: 'SEND',
              status: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
