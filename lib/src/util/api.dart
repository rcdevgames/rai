import 'dart:convert';
import 'dart:io';
import 'package:RAI/src/util/data.dart';
import 'package:dio/dio.dart';
import 'package:cryptoutils/cryptoutils.dart';

class Api {

  static Dio oAuth() {
    var dio = new Dio();
    dio.options.baseUrl = Static.UAT_OAUTH_URL;
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 15000;
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    // dio.options.headers = {"Authorization":"Basic ${Static.TOKENOAUTH}"};
    dio.options.headers = {"Authorization":"Basic ${encode(Static.CLIENTID, Static.CLIENTSECRET)}"};
    return dio;
  }

  static Dio access() {
    var dio = new Dio();
    dio.options.baseUrl = Static.UAT_MCS_URL;
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 15000;
    dio.options.headers = {"Content-Type": "application/json"};

    return dio;
  }

  static String encode(String clientId, String secretId) {
  // var bytes = UTF8.encode(str);
  var bytes = utf8.encode("$clientId:$secretId");
  return CryptoUtils.bytesToBase64(bytes);
  }

  static Options headers(token) {
    return Options(
      headers: {"Authorization": "Bearer ${token}", "External-Authorization": "Bearer ${token}"}
    );
  }
}