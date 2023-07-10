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
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.payments}/$userId');
  try {
    var response = await http.post(url);
    if (response.statusCode == 201) {
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

Future<PaymentsModel> postPayments({
  required BuildContext context,
  required String amount,
  required String payment_date,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  var url =
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.payments}/$userId');
  try {
    var response = await http.post(
      url,
      body: {
        'amount': amount,
        'payment_date': payment_date,
      },
    );
    if (response.statusCode == 201) {
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
