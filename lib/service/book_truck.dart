import 'dart:convert';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/models/book_truck.dart';
import 'package:truck_monitor/utils/shared_pref.dart';

Future<BookTruckModel> bookTruck({
  required BuildContext context,
  required String truckName,
  required String driverName,
  required String from,
  required String to,
  required String date,
  required String driverId,
  required String truckId,
  required String load,
}) async {
  int userId = await Services().getUserID();
  int loginId = await Services().getLoginID();
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.truckBooking}');
  print(url);
  try {
    var response = await http.post(url, body: {
      'username': loginId.toString(),
      'truck_name': truckName,
      'driver_name': driverName,
      'load_quantity': load,
      'starting': from,
      'ending': to,
      'date': date,
      'user': userId.toString(),
      'driver': driverId,
      'truck': truckId,
      'load': '9',
    });

    if (response.statusCode == 201) {
      return BookTruckModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw jsonDecode(response.body)['message'];
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
