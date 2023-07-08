import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/user_registration.dart';

Future<UserRegistrationModel> registerUser({
  required BuildContext context,
  required String name,
  required String email,
  required String mobileNumber,
  required String userName,
  required String password,
  required String location,
}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerUser}');

  var userData = {
    "name": name,
    "email": email,
    "mobile": mobileNumber,
    "username": userName,
    "password": password,
    "location": location,
  };

  try {
    var response = await http.post(
      url,
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );
    log(response.body);
    if (response.statusCode == 201) {
      return UserRegistrationModel.fromJson(jsonDecode(response.body));
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
