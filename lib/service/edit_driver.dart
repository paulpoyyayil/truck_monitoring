import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';

Future<bool> updateDriver({
  required BuildContext context,
  required String name,
  required String mobile,
  required String email,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  try {
    var url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateDriver}$userId');

    var body = json.encode({
      'name': name,
      'mobile': mobile,
      'email': email,
    });
    var response = await http.put(url, body: body, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
