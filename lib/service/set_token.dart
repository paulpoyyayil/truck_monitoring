import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/config/constants.dart';
import 'package:truck_monitor/data.dart';

Future<bool> setToken({required String token}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('user_id')!;
  try {
    var url = role == 'user'
        ? Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateUser}$userId')
        : Uri.parse(
            '${ApiConstants.baseUrl}${ApiConstants.updateDriver}$userId');

    var body = json.encode({'fcm_token': token});
    var response = await http.put(
      url,
      body: body,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
