import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/screens/homepage/homepage.dart';
import 'package:truck_monitor/utils/navigation.dart';
import 'package:truck_monitor/utils/snackbar.dart';

Future<dynamic> handleNetworkException(
  http.Response response,
  BuildContext context,
) async {
  switch (response.statusCode) {
    case 400:
      // Handle bad request error
      final error = jsonDecode(response.body)['message'] ??
          jsonDecode(response.body)['data'];
      getSnackbar(context, error);
      break;

    case 401:
      // Handle unauthorized error
      getSnackbar(context, 'Unauthorized');
      // await logout();
      navigationReplacement(context, Homepage(selectedIndex: 0));
      break;

    case 404:
      // Handle not found error
      getSnackbar(context, 'Resource not found');
      break;

    default:
      // Handle other error status codes
      getSnackbar(context, 'Error ${response.statusCode}');
      break;
  }
}
