import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cryptoutils/cryptoutils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {

  static Dio oAuth() {
    var dio = new Dio();
    dio.options.baseUrl = DotEnv().env['OAUTH_URL'];
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 15000;
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
    // dio.options.headers = {"Authorization":"Basic ${Static.TOKENOAUTH}"};
    dio.options.headers = {"Authorization":"Basic ${encode(DotEnv().env['CLIENTID'], DotEnv().env['CLIENTSECRET'])}"};
    return dio;
  }

  static Dio access() {
    var dio = new Dio();
    dio.options.baseUrl = DotEnv().env['MCS_URL'];
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