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
  Stream<num> get getTotalSavings => _totalInterest.stream;
  Stream<num> get getTotalInterest => _totalInterest.stream;

  Function(List<Savings>) get updateListSavings => _listSavings.sink.add;

  @override
  void dispose() {
    _listSavings.close();
    _totalSavings.close();
    _totalInterest.close();
  }

  fetchSaving(BuildContext context) async {
    businessDate = DateTime.parse(await sessions.load("businessDate"));
    try {
      var result = await repo.getSavingList();
      num interest = 0, saving = 0;
      result.asMap().forEach((i, v) {
        interest += v.accruedInterest;
        saving += v.quantity;
      });
      _totalInterest.sink.add(interest);
      _totalSavings.sink.add(saving);
      _listSavings.sink.add(result);
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

  num countPercentage(DateTime businessDate, DateTime date) {
    DateTime startDate = DateTime.now();
    var max = date.difference(startDate).inDays;
    var value = date.difference(businessDate).inDays;
    return ((value/max)*100)/100;
  }
  
}