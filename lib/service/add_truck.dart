import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/network_exceptions.dart';
import 'package:truck_monitor/models/add_truck.dart';

Future<AddTruckModel> addTruck({
  required BuildContext context,
  required String truckName,
  required String truckNumber,
  required String truckFrom,
  required String truckTo,
  required String loadCapacity,
}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.addVehicle}');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int driverId = prefs.getInt('user_id')!;

  try {
    var response = await http.post(
      url,
      body: {
        'driver': driverId.toString(),
        'truck_name': truckName,
        'trucknumber': truckNumber,
        'truckfrom': truckFrom,
        'truckto': truckTo,
        'load_capacity': loadCapacity,
      },
    );
    if (response.statusCode == 201) {
      return AddTruckModel.fromJson(jsonDecode(response.body));
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
