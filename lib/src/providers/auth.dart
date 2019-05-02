import 'dart:async';
import 'package:RAI/src/models/oAuth.dart';
import 'package:RAI/src/util/api.dart';
import 'package:RAI/src/util/data.dart';
import 'package:dio/dio.dart';

class AuthProvider {
  Future<OAuth> doLogin(String code) async {
    var api = Api.oAuth();
    Response response;

    try {
      response = await api.post("", data: {
        "grant_type": "password",
        "username": code,
        "password": Static.DEFAULT_PASSWORD,
        "scope": Static.OAUTHSCOPE
      });
      return OAuth.fromJson(response.data);
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
        throw Exception(e.response.data['error_description'].toString());
      } else{
        print(e.request);
        print(e.message);
        throw Exception(e.message.toString());
      }  
    }
  }
}