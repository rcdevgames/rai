import 'dart:convert';

import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/history.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends Object implements BlocBase {
  CancelToken token = new CancelToken();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final _isLoading = BehaviorSubject<bool>();
  final _accountList = BehaviorSubject<List<Bank>>();
  final _historyList = BehaviorSubject<List<List<History>>>();
  final _totalBalance = BehaviorSubject<num>();
  final _selected = BehaviorSubject<int>();
  final _indexTab = BehaviorSubject<int>.seeded(0);

  Stream<bool> get getLoading => _isLoading.stream;
  Stream<List<Bank>> get getListBank => _accountList.stream;
  Stream<List<List<History>>> get getHistory => _historyList.stream;
  Stream<num> get getTotalBalance => _totalBalance.stream;
  Stream<int> get getSelectedDefault => _selected.stream;
  Stream<int> get getIndexTab => _indexTab.stream;

  Function(int) get updateIndexTab => _indexTab.sink.add;

  ProfileBloc() {
    fetchAccountList();
    fetchHistory();
  }

  @override
  void dispose() {
    _isLoading.close();
    _accountList.close();
    _historyList.close();
    _totalBalance.close();
    _selected.close();
    _indexTab.close();
  }

  Future fetchAccountList() async {
    try {
      var _accounts = await repo.getBankList(token);
      num _balance = 0;
      _accounts.forEach((v){
        if(v.isDefault == 1) {
          _selected.sink.add(v.bankAcctId);
        }
        _balance += v.bankAcctBalance;
      });
      _totalBalance.sink.add(_balance);
      _accountList.sink.add(_accounts);
    } catch (e) {
      print(e);
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _accountList.sink.addError(error['message']);
      } catch (e) {
        _accountList.sink.addError(e.toString().replaceAll("Exception: ", ""));
      }
    }
  }

  Future fetchHistory() async {
    try {
      var _data = await repo.getHistory();
      List<History> _list = [];
      _data.forEach((v) {
        if (v.category != "Request") {
          _list.add(v);
        }
      });

      List<List<History>> _newList = [];
      groupBy(_list, (History obj) => obj.transactionDate).forEach((k, v) => _newList.add(v.map((item) => item).toList()));
      _historyList.sink.add(_newList);
    } catch (e) {
      print(e);
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _accountList.sink.addError(error['message']);
      } catch (e) {
        _historyList.sink.addError(e.toString().replaceAll("Exception: ", ""));
      }
    }
  }

  setDefault(BuildContext context, int id) async {
    try {
      resetAccountList();
      await repo.setDefaultAccountBank(id);
      await fetchAccountList();
    } catch (e) {
      var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        // if (error['errorCode'] == 401) {
        //   sessions.clear();
        //   Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        // }
        _accountList.sink.addError(error['message']);
      } catch (e) {
        _historyList.sink.addError(e.toString().replaceAll("Exception: ", ""));
    }
  }

  updateSelected(int id) async {
    _selected.sink.add(id);
  }

  resetAccountList() {
    _accountList.sink.add(null);
  }
  resetHistory() {
    _historyList.sink.add(null);
  }
  changeTab(int i) {
    _indexTab.sink.add(i);
  }

}