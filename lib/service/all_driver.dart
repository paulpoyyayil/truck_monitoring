import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/all_drivers.dart';

Future<AllDriverModel> getAllDriver({required BuildContext context}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.allDriver}');

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return AllDriverModel.fromJson(jsonDecode(response.body));
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
