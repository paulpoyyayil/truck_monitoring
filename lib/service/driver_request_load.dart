import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';

Future<bool> driverRequestLoad({
  required BuildContext context,
  required String userId,
  required String loadFrom,
  required String loadTo,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int driverId = prefs.getInt('user_id')!;
  try {
    var url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.driverRequestLoad}');

    var response = await http.post(url, body: {
      'user': userId,
      'driver': driverId.toString(),
      'load': '1',
      'load_from': loadFrom,
      'load_to': loadTo
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
