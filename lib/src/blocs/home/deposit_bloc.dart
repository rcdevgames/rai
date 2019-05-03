import 'dart:async';
import 'dart:convert';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/session.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class DepositBloc extends Object implements BlocBase {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  StreamSubscription timeout;
  StreamSubscription timeout1;
  final depositInput = TextEditingController();
  final _listDeposit = BehaviorSubject<List<DepositMatch>>();
  final _businessDate = BehaviorSubject<String>();
  final _singleitem = BehaviorSubject<bool>();
  final _amount = BehaviorSubject<num>();

  Stream<List<DepositMatch>> get getListDeposit => _listDeposit.stream;
  Stream<bool> get getSingleItem => _singleitem.stream;

  Function(bool) get updateSingleItem => _singleitem.sink.add;

  DepositBloc() {
    depositInput.text = '0';
    loadDepositMatch();
  }

  @override
  void dispose() {
    depositInput.dispose();
    _listDeposit.close();
    _businessDate.close();
    _singleitem.close();
  }


  addValue() {
    if (_amount != null && num.parse(depositInput.text) < _amount.value) {
      depositInput.text = (int.parse(depositInput.text) + 100).toString();
      reCallFunction();
    }
  }
  removeValue() {
    if (_amount != null && int.parse(depositInput.text) > 100) {
      depositInput.text = (int.parse(depositInput.text) - 100).toString();
      reCallFunction();
    }
  }
  onChange(int value) async {
    timeout?.cancel();
    timeout = Future.delayed(Duration(milliseconds: 1500)).asStream().listen((i) {
      if (value < 100) {
        depositInput.text = '100';
      }else if (value > _amount.value) {
        depositInput.text = _amount.value.toString();
      }
      reCallFunction();
    });
  }
  Future loadDepositMatch() async {
    _singleitem.sink.add(false);
    try {
      var defaultBank = await repo.getDefaultBank();
      depositInput.text = defaultBank.bankAcctBalance.round().toString();
      _amount.sink.add(defaultBank.bankAcctBalance.round());
      var user = await repo.getUser();
      var endDate = DateTime.parse(user.businessDate);

      var depositsMatch = await repo.getDepositMatch(num.parse(depositInput.text), 10, user.businessDate, formatDate(endDate.add(const Duration(days: 540)), [yyyy, '-', mm, '-', dd]).toString());
      depositsMatch.sort((a, b) => b.tag.compareTo(a.tag));
      _singleitem.sink.add(true);
      _listDeposit.sink.add(depositsMatch);
    } catch (e) {
      print(e);
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _listDeposit.sink.addError(error['message']);
      } catch (e) {
        _listDeposit.sink.addError(e.toString().replaceAll("Exception: ", ""));
      }
    }
  }
  openList() {
    _singleitem.sink.add(false);
  }
  reCallFunction() {
    print(depositInput.text);
    timeout1?.cancel();
    timeout1 = Future.delayed(Duration(milliseconds: 800)).asStream().listen((i) async {
      _listDeposit.sink.add(null);
      _singleitem.sink.add(false);
      try {
        var endDate = DateTime.parse(await sessions.load("businessDate"));

        var depositsMatch = await repo.getDepositMatch(num.parse(depositInput.text), 10, await sessions.load("businessDate"), formatDate(endDate.add(const Duration(days: 540)), [yyyy, '-', mm, '-', dd]).toString());
        depositsMatch.sort((a, b) => b.tag.compareTo(a.tag));
        _singleitem.sink.add(true);
        _listDeposit.sink.add(depositsMatch);
      } catch (e) {
        print(e);
        try {
          var error = json.decode(e.toString().replaceAll("Exception: ", ""));
          if (error['errorCode'] == 401) {
            sessions.clear();
            navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
          }
          _listDeposit.sink.addError(error['message']);
        } catch (e) {
          _listDeposit.sink.addError(e.toString().replaceAll("Exception: ", ""));
        }
      }
    });
  }


}