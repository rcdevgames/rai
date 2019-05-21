import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  SharedPreferences prefs;

  save(String key, String data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    prefs.commit();
  }

  clear() async {
    prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    List<String> listSessions = ['token', 'KYC', 'amount', 'businessDate'];
    listSessions.map((v) => prefs.remove(v));
  }

  remove(String key) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<String> load(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<String> flashMessage(String key) async {
    prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(key);
    prefs.remove(key);
    return data;
  }
}

final sessions = Sessions();