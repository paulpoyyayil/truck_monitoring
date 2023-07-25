import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/models/all_loads.dart';

Future<AllLoadsModel> getAllLoads({required BuildContext context}) async {
  var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.allLoads}');

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      if (body['success']) {
        return AllLoadsModel.fromJson(body);
      } else {
        return AllLoadsModel(data: []);
      }
    } else {
      return AllLoadsModel(data: []);
    }
  } catch (e) {
    throw e.toString();
  }
}
