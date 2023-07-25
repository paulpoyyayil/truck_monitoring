import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/payments.dart';

Future<PaymentsModel> getPayment({required BuildContext context}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  var url =
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.paymentsList}/$userId');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return PaymentsModel.fromJson(jsonDecode(response.body));
    } else {
      if (context.mounted) {
        handleNetworkException(response, context);
      }
    }
  } catch (e) {
    throw e;
  }
  throw 'Unexpected error occurred.';
}

Future<bool> postPayments({
  required BuildContext context,
  required String amount,
  required String paymentDate,
  required String truckId,
  required String paymentId,
}) async {
  var url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.payment}/$truckId/$paymentId');
  try {
    var response = await http.put(
      url,
      body: {
        'amount': amount,
        'payment_date': paymentDate,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw e;
  }
}
