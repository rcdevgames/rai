import 'dart:io';
import 'package:rai/src/util/data.dart';
import 'package:dio/dio.dart';

class Api {

  static Dio access() {
    var dio = new Dio();
    dio.options.baseUrl = Static.MCS_URL;
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 15000;
    dio.options.headers = {"Content-Type": "application/json"};

    return dio;
  }

  static Options headers(token) {
    return Options(
      headers: {"Authorization": "Bearer ${token}", "External-Authorization": "Bearer ${token}"}
    );
  }
}