import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';

Future<bool> driverAcceptBooking(
    {required BuildContext context, required String bookingId}) async {
  var url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.driverAcceptBooking}/$bookingId');

  try {
    var response = await http.post(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      if (context.mounted) {
        handleNetworkException(response, context);
      }
    }
  } catch (e) {
    rethrow;
  }
  throw 'Unexpected error occurred.';
}
