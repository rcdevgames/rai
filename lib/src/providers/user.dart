import 'dart:convert';

import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/default_account.dart';
import 'package:RAI/src/models/default_bank.dart';
import 'package:RAI/src/models/history.dart';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/models/user.dart';
import 'package:RAI/src/util/api.dart';
import 'package:RAI/src/util/session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UserProvider {
  Future<User> getUser() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get("user/", options: Api.headers(await sessions.load("token")));
      var data = await userFromJson(response.data['data']);
      sessions.save("businessDate", data.businessDate.toString());
      return data;
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  getKYC() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get("user/accounts/default", options: Api.headers(await sessions.load("token")));
      if (num.parse(response.data["errorCode"]) == 0) {
        var data = await defaultAccountFromJson(response.data['data']);
        sessions.save("KYC", data.kycStatus.toUpperCase());
      }else{
        throw Exception(json.encode({"errorCode": 403, "message": response.data['errorMessage']}));
      }
    } on DioError catch (e) {
      if(e.response != null) {
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
        }else{
          throw Exception(json.encode(e.response.data));
        }
      } else{
        // print(e.request);
        // print(e.message);
        // throw Exception(e.message.toString());
      }
    }
  }

  Future<DefaultBank> getDefaultBank() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('user/bankAccounts/default', options: Api.headers(await sessions.load('token')));
      return defaultBankFromJson(response.data['data']);
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future<List<Bank>> getBankList() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('user/bankAccounts', options: Api.headers(await sessions.load('token')));
      return compute(bankFromJson, response.data['data'].toString());
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future<List<History>> getHistory() async {
    var api = Api.access();
    Response response;

    try {
      response = await api.get('user/deposits/histories', options: Api.headers(await sessions.load('token')));
      return compute(historyFromJson, response.data['data'].toString());
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future setDefaultAccountBank(int id) async {
    var api = Api.access();
    Response response;

    try {
      response = await api.patch("user/bankAccounts/$id/default", data: {}, options: Api.headers(await sessions.load("token")));
      return response;
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future purchaseDeposit(num amount, int bankAccId, String productId) async {
    var api = Api.access();
    Response response;

    try {
      response = await api.post("user/deposits/", data: { "productId" : productId, "quantity" : amount, "bankAcctId" : bankAccId }, options: Api.headers(await sessions.load("token")));
      print(response.data);
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future<List<Savings>> getSavingList() async {
    var api = Api.access();
    Response response;

    // try {
      response = await api.get("user/deposits?isCurrent=1", options: Api.headers(await sessions.load("token")));
      // print(response.data);
      return compute(savingsFromJson, response.data['data'].toString());
    // } on DioError catch (e) {
    //   if(e.response != null) {
    //     print(e.response.statusCode);
    //     print(e.response.data);
    //     if (e.response.statusCode == 401 || e.response.statusCode == 403) {
    //       throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
    //     }else{
    //       throw Exception(json.encode(e.response.data));
    //     }
    //   } else{
    //     print(e.request);
    //     print(e.message);
    //     throw Exception(e.message.toString());
    //   }
    // }
  }

  Future cancelSwitchOut(String requestId) async {
    var api = Api.access();
    Response response;

    try {
      response = await api.patch("user/deposits/matchorders/$requestId/cancel", data:{}, options: Api.headers(await sessions.load("token")));
      
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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

  Future sendMatchOrder(String termDepositId, num quantity) async {
    var api = Api.access();
    Response response;

    try {
      response = await api.post("user/deposits/matchorders", data: {
        "termDepositId": termDepositId,
        "quantity": quantity
      }, options: Api.headers(await sessions.load("token")));
    } on DioError catch (e) {
      if(e.response != null) {
        print(e.response.statusCode);
        print(e.response.data);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          throw Exception(json.encode({"errorCode": e.response.statusCode, "message": "Unautorized"}));
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