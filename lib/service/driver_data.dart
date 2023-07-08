import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/driver_data.dart';

Future<DriverModel> getDriverData({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;

  var url =
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.driverData}$userId');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return DriverModel.fromJson(jsonResponse);
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
