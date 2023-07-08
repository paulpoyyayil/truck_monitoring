import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/models/user_chats.dart';

Future<ChatsModel> getChats({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  var url = role == 'user'
      ? Uri.parse('${ApiConstants.baseUrl}${ApiConstants.allUserChats}/$userId')
      : Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.allDriverChats}/$userId');
  log(url.toString());
  try {
    var response = await http.get(url);
    log(response.body);
    if (response.statusCode == 200) {
      return ChatsModel.fromJson(jsonDecode(response.body));
    } else {
      if (context.mounted) {
        handleNetworkException(response, context);
      }
    }
  } catch (e) {
    throw e.toString();
  }
  throw 'Unexpected error occurred.';
}
