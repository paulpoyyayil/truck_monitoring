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
    var response = await http.put(url, body: {'replay': reply});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
