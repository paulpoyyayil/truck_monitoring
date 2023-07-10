import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:truck_monitor/config/colors.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/models/user_chats.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/chats.dart';
import 'package:truck_monitor/service/driver_send_chat.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/utils/willpop.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';
import 'package:truck_monitor/widgets/status_button.dart';
import 'package:truck_monitor/widgets/textfield.dart';

class DriverMessages extends StatefulWidget {
  const DriverMessages({super.key});

  @override
  State<DriverMessages> createState() => _DriverMessagesState();
}

class _DriverMessagesState extends State<DriverMessages> {
  ChatsModel? _chatsModel;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _chatsModel = await getChats(context: context);
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
          title: 'Messages',
          isMainTab: false,
          onTapped: () => navigationPush(context, Homepage(selectedIndex: 0)),
        ),
        body: _chatsModel == null
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : _chatsModel!.data!.isEmpty
                ? Center(
                    child: Text(
                      'No Messages',
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RowText(
                                        title: 'User Name: ',
                                        text: _chatsModel!
                                            .data![index].userName!.titleCase,
                                      ),
                                      RowText(
                                        title: 'Message: ',
                                        text: _chatsModel!.data![index].chat!,
                                      ),
                                      if (_chatsModel!
                                          .data![index].replay!.isNotEmpty)
                                        RowText(
                                          title: 'Reply: ',
                                          text:
                                              _chatsModel!.data![index].replay!,
                                        ),
                                      RowText(
                                        title: 'Date: ',
                                        text: DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(
                                              _chatsModel!.data![index].date!),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (_chatsModel!.data![index].replay!.isEmpty)
                                StatusButton(
                                  onTap: () {
                                    if (role == 'driver') {
                                      if (_chatsModel!
                                          .data![index].replay!.isEmpty) {
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
                                              chatId: _chatsModel!
                                                  .data![index].id
                                                  .toString(),
                                              userName: _chatsModel!
                                                  .data![index].userName!,
                                            );
                                          },
                                        );
                                      } else {
                                        getSnackbar(context,
                                            'Already replied to this message');
                                      }
                                    }
                                  },
                                  buttonText: 'Reply',
                                  status: false,
                                )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 14.h),
                      itemCount: _chatsModel!.data!.length,
                    ),
                  ),
      ),
    );
  }
}

class ChatModal extends StatefulWidget {
  const ChatModal({super.key, required this.userName, required this.chatId});
  final String userName, chatId;
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
              'Message ${widget.userName.titleCase}',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            CustomTextField(
              controller: message,
              hintText: 'Reply',
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
                      bool status = await driverSendChat(
                        context: context,
                        chatId: widget.chatId,
                        reply: message.text,
                      );
                      if (status) {
                        getSnackbar(context, 'Reply Sent');
                        navigationPush(context, DriverMessages());
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
