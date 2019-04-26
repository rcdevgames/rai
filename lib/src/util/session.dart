import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions {
  SharedPreferences prefs;

  Future<bool> checkAuth() async {
    prefs = await SharedPreferences.getInstance();
    var res = prefs.getBool("isLoggedIn");
    if (res == null) return false;
    return res;
  }

  save(String key, String data) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
    if (key == "auth") prefs.setBool("isLoggedIn", true);
    prefs.commit();
  }

  clear() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> load(String key) async {
    prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

final sessions = Sessions();