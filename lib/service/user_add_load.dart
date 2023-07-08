import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';

Future<bool> userAddLoad({
  required BuildContext context,
  required String desciption,
  required String from,
  required String to,
  required String quantity,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userAddLoad}');

  var body = {
    'user': userId.toString(),
    'load_description': desciption,
    'load_from': from,
    'load_to': to,
    'load_quantity': quantity,
  };

  try {
    var response = await http.post(url, body: body);
    if (response.statusCode == 201) {
      return true;
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
