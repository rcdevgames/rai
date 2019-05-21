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
import 'package:flutter_masked_text/flutter_masked_text.dart';

class DepositBloc extends Object implements BlocBase {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  StreamSubscription timeout;
  StreamSubscription timeout1;
  final depositInput = new MoneyMaskedTextController(thousandSeparator: ',', decimalSeparator: '', precision: 0, leftSymbol: "£ ");
  // final depositInput = TextEditingController();
  final _listDeposit = BehaviorSubject<List<DepositMatch>>();
  final _listDepositBackup = BehaviorSubject<List<DepositMatch>>();
  final _businessDate = BehaviorSubject<String>();
  final _singleitem = BehaviorSubject<bool>();
  final _amount = BehaviorSubject<num>();
  final _oldAmount = BehaviorSubject<num>();
  DateTime businessDate;

  Stream<List<DepositMatch>> get getListDeposit => _listDeposit.stream;
  Stream<bool> get getSingleItem => _singleitem.stream;
  Stream<num> get getAmount => _amount.stream;

  Function(bool) get updateSingleItem => _singleitem.sink.add;
  Function(List<DepositMatch>) get updateListDeposit => _listDeposit.sink.add;

  DepositBloc() {
    depositInput.updateValue(0);
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
    _amount.sink.add(_amount.value);
    if (_amount != null && depositInput.numberValue < _amount.value) {
      depositInput.updateValue(depositInput.numberValue + 100);
    }
  }
  removeValue() {
    _amount.sink.add(_amount.value);
    if (_amount != null && depositInput.numberValue > 100) {
      depositInput.updateValue(depositInput.numberValue - 100);
    }
  }
  onChange(int value) async {
    print(value);
  }
  Future loadDepositMatch() async {
    _singleitem.sink.add(false);
    try {
      var defaultBank = await repo.getDefaultBank();
      depositInput.updateValue(thousandRounding(defaultBank.bankAcctBalance));
      _amount.sink.add(thousandRounding(defaultBank.bankAcctBalance));
      _oldAmount.sink.add(thousandRounding(defaultBank.bankAcctBalance));
      var user = await repo.getUser();
      var endDate = DateTime.parse(user.businessDate);
      businessDate = endDate;

      var depositsMatch = await repo.getDepositMatch(num.parse(depositInput.numberValue.toString()), 10, user.businessDate, formatDate(endDate.add(const Duration(days: 540)), [yyyy, '-', mm, '-', dd]).toString());
      depositsMatch.sort((a, b) => b.tag.compareTo(a.tag));
      if(depositsMatch.length > 1) _singleitem.sink.add(true);
      _listDeposit.sink.add(depositsMatch);
      _listDepositBackup.sink.add(depositsMatch);


      // Handle Listener
      depositInput.addListener(() {
        try {
          var amounts = depositInput.numberValue.isNaN ? depositInput.numberValue:0;
          if (_oldAmount.value != depositInput.numberValue) {
            _singleitem.sink.add(false);
            _listDeposit.sink.add(null);
          }
          timeout?.cancel();
          timeout = Future.delayed(Duration(milliseconds: 1500)).asStream().listen((i) {
            if (depositInput.numberValue < 100 && _oldAmount.value > 100) {
              depositInput.updateValue(100);
            }else if (depositInput.numberValue > _amount.value) {
              depositInput.updateValue(_amount.value);
            }else {
              depositInput.updateValue(thousandRounding(depositInput.numberValue));
            }
            if (_oldAmount.value != depositInput.numberValue) {
              timeout1?.cancel();
              timeout1 = Future.delayed(Duration(milliseconds: 500)).asStream().listen((i) async {
                reCallFunction();
              });
            }else{
              _singleitem.sink.add(true);
              _listDeposit.sink.add(_listDepositBackup.value);
            }
          });
          if (depositInput.text.length < 3) {
            depositInput.updateValue(0);
          }else if (depositInput.numberValue > _amount.value) {
            depositInput.updateValue(_amount.value.toDouble());
          }
          _amount.sink.add(_amount.value);
          print("Amounts : $amounts");
        } catch (e) {
          depositInput.updateValue(0);
        }

        // try {
        //   if(depositInput.text.length > 3) {
        //     timeout?.cancel();
        //     timeout = Future.delayed(Duration(milliseconds: 1000)).asStream().listen((i) {
        //       if (depositInput.numberValue < 100 && _oldAmount.value > 100) {
        //         depositInput.updateValue(100);
        //       }else if (depositInput.numberValue > _amount.value) {
        //         depositInput.updateValue(_amount.value);
        //       }else {
        //         depositInput.updateValue(thousandRounding(depositInput.numberValue));
        //       }
        //       if (_oldAmount.value != depositInput.numberValue) reCallFunction();
        //     });
        //     if (depositInput.numberValue < 100 && _oldAmount.value > 100) {
        //       depositInput.updateValue(100);
        //     }else if (depositInput.numberValue > _amount.value) {
        //       depositInput.updateValue(_amount.value.toDouble());
        //     }
        //   }
        // } catch (e) {
        //   print("Catch Deposit $e");
        // }
      });
    } catch (e) {
      print("Error : $e");
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _listDeposit.sink.addError(error['message']);
      } catch (err) {
        if (e.toString().contains("Bad Request")) {
          _listDeposit.sink.add([]);
        }else{
          _listDeposit.sink.addError(e.toString().replaceAll("Exception: ", ""));
        }
      }
    }
  }
  openList() {
    _singleitem.sink.add(false);
  }
  Future<void> reCallFunction() async {
    _singleitem.sink.add(false);
    try {
      var endDate = DateTime.parse(await sessions.load("businessDate"));

      var depositsMatch = await repo.getDepositMatch(num.parse(depositInput.numberValue.toString()), 10, await sessions.load("businessDate"), formatDate(endDate.add(const Duration(days: 540)), [yyyy, '-', mm, '-', dd]).toString());
      depositsMatch.sort((a, b) => b.tag.compareTo(a.tag));
      if(depositsMatch.length > 1) _singleitem.sink.add(true);
      _listDeposit.sink.add(depositsMatch);
      _listDepositBackup.sink.add(depositsMatch);
      _oldAmount.sink.add(depositInput.numberValue);
    } catch (e) {
      print(e);
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _listDeposit.sink.addError(error['message']);
      } catch (err) {
        if (e.toString().contains("Bad Request")) {
          _listDeposit.sink.add([]);
        }else{
          _listDeposit.sink.addError(e.toString().replaceAll("Exception: ", ""));
        }
      }
    }
  }

  num thousandRounding(num amount) {
    return ((amount/100).floor()*100).toDouble();
  }


}