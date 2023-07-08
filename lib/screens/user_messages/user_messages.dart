import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:truck_monitor/models/user_chats.dart';
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/service/chats.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';
import 'package:truck_monitor/widgets/app_bar.dart';
import 'package:truck_monitor/widgets/card_outline.dart';
import 'package:truck_monitor/widgets/row_text.dart';

class UserMessages extends StatefulWidget {
  const UserMessages({super.key});

  @override
  State<UserMessages> createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
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

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowText(
                                      title: 'Driver Name: ',
                                      text: _chatsModel!
                                          .data![index].driverName!.titleCase,
                                    ),
                                    RowText(
                                      title: 'Message: ',
                                      text: _chatsModel!.data![index].chat!,
                                    ),
                                    if (_chatsModel!
                                        .data![index].replay!.isNotEmpty)
                                      RowText(
                                        title: 'Reply: ',
                                        text: _chatsModel!.data![index].replay!,
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
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 14.h),
                    itemCount: _chatsModel!.data!.length,
                  ),
                ),
    );
  }
}
