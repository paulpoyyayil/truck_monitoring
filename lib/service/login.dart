import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/data.dart';
import 'package:truck_monitor/utils/shared_pref.dart';

Future<bool> login({
  required BuildContext context,
  required String userName,
  required String password,
}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');
  try {
    var response = await http.post(url, body: {
      'username': userName,
      'password': password,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success']) {
        isLoggedIn = true;
        Services().saveUserData(jsonResponse['data']);
        return true;
      } else {
        return false;
      }
    } else {
      if (context.mounted) {
        handleNetworkException(response, context);
      }
    }
  } catch (e) {
    throw e.toString();
  }

  throw 'Login failed';
}
