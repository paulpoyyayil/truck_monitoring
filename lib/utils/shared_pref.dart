import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:truck_monitor/data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truck_monitor/service/set_token.dart';

class Services {
  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('username');
    if (name != "" && name != "0" && name != null) {
      return name;
    }
    return "No name";
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    if (name != "" && name != "0" && name != null) {
      return name;
    }
    return "No name";
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('user_id');
    return id;
  }

  getLoginID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('login_id');
    return id;
  }

  saveUserData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    prefs.setInt('login_id', data['login_id']);
    prefs.setString('username', data['username']);
    prefs.setString('role', data['role']);
    role = data['role'];
    prefs.setInt('user_id', data['user_id']);
    prefs.setString('l_status', data['l_status']);
    prefs.setString('name', data['name']);
    prefs.setString('vehicle_status', data['vehicle_status']);
  }

  Future logout() async {
    try {
      await FirebaseMessaging.instance.deleteToken();
      await setToken(token: "");
    } catch (_) {}

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
    prefs.remove('login_id');
    prefs.remove('username');
    prefs.remove('role');
    role = null;
    prefs.remove('user_id');
    prefs.remove('l_status');
    prefs.remove('name');
    prefs.remove('vehicle_status');
  }
}
