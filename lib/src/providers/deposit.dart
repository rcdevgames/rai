import 'dart:convert';

import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/api.dart';
import 'package:RAI/src/util/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DepositProvider {
  Future<List<DepositMatch>> getDepositMatch(num amount, int limit, String startDate, String endDate) async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('deposits/matchorders/?amount=$amount&limit=$limit&startDate=$startDate&endDate=$endDate', options: Api.headers(await sessions.load('token')));
      return compute(depositMatchFromJson, response.data['data'].toString());
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Your session is expired, you will be redirected to login page"}));
        }else{
          throw Exception(json.encode(e.response.data));
        }
      } else{
        print(e.request);
        print(e.message);
        throw Exception(e.message.toString());
      }
    }   
  }
}