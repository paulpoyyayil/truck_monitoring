import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';

Future<bool> driverSendChat({
  required BuildContext context,
  required String chatId,
  required String reply,
}) async {
  try {
    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.driverSendChat}/$chatId');
    log(url.toString());
    var response = await http.put(url, body: {'replay': reply});
    log(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw e;
  }
}
