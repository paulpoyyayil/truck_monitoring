import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/driver_registration.dart';

Future<DriverRegistrationModel> registerDriver({
  required BuildContext context,
  required String name,
  required String email,
  required String mobileNumber,
  required String userName,
  required String password,
  required String licenceNo,
  required String vehicleStatus,
  required String location,
  required String from,
  required String to,
}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerDriver}');

  var userData = {
    "name": name,
    "email": email,
    "mobile": mobileNumber,
    "username": userName,
    "password": password,
    "licence_no": licenceNo,
    "vehicle_status": vehicleStatus,
    "location": location,
    "transport_from": from,
    "transport_to": to,
  };

  try {
    var response = await http.post(
      url,
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );
    log(response.body);
    if (response.statusCode == 201) {
      return DriverRegistrationModel.fromJson(jsonDecode(response.body));
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
