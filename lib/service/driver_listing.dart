import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/driver_list.dart';

Future<DriverListModel> getDriverListing({
  required BuildContext context,
  required String endPoint,
}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}$endPoint');
  log(url.toString());
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return DriverListModel.fromJson(jsonDecode(response.body));
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
