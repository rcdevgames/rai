import 'dart:async';
import 'dart:convert';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SavingBloc extends Object implements BlocBase {
  final _listSavings = BehaviorSubject<List<Savings>>();
  final _totalSavings = BehaviorSubject<num>.seeded(0);
  final _totalInterest = BehaviorSubject<num>.seeded(0);
  DateTime businessDate;

  Stream<List<Savings>> get getListSavings => _listSavings.stream;
  Stream<num> get getTotalSavings => _totalSavings.stream;
  Stream<num> get getTotalInterest => _totalInterest.stream;

  Function(List<Savings>) get updateListSavings => _listSavings.sink.add;

  @override
  void dispose() {
    _listSavings.close();
    _totalSavings.close();
    _totalInterest.close();
  }

  Future fetchSaving(BuildContext context, bool refresh) async {
    sessions.remove("switchout");
    businessDate = DateTime.parse(await sessions.load("businessDate"));
    if (_listSavings.value == null || refresh == true) {
      try {
        var result = await repo.getSavingList();
        num interest = 0, saving = 0;
        if (result.length > 0) {
          result.asMap().forEach((i, v) {
            interest += v.accruedInterest;
            saving += v.quantity;
          });
          _totalInterest.sink.add(interest);
          _totalSavings.sink.add(saving);
        }
        _listSavings.sink.add(result);
        print(result);
      } catch (e) {
        print(e);
        try {
          var error = json.decode(e.toString().replaceAll("Exception: ", ""));
          if (error['errorCode'] == 401 || error['errorCode'] == 403) {
            sessions.clear();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
          }
          _listSavings.sink.addError(error['message']);
        } catch (e) {
          _listSavings.sink.addError(e.toString().replaceAll("Exception: ", ""));
        }
      }
    }
  }

  num countPercentage(DateTime businessDate, DateTime maturityDate, DateTime startDate) {
    var max = maturityDate.difference(startDate).inDays;
    var value = businessDate.difference(startDate).inDays;
    var result = ((value/max)*100)/100;
    // print("startDate: $startDate");
    // print("maturityDate: $maturityDate");
    // print("businessDate: $businessDate");
    // print("Max: $max");
    // print("Value: $value");
    // print("Result Percent: $result");
    // print("==========================================");
    if (result < 0) {
      return 0.0;
    }else if(result > 1) {
      return 1.0;
    }else{
      return result;
    }
  }
  
}