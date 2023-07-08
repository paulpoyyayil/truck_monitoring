import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';

Future<bool> userSendChat({
  required BuildContext context,
  required String driverId,
  required String chat,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  try {
    var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userSendChat}');

    var response = await http.post(url, body: {
      'user': userId.toString(),
      'driver': driverId,
      'chat': chat,
      'date': DateTime.now().toString(),
    });
    if (response.statusCode == 201) {
      return true;
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
