import 'dart:async';
import 'dart:convert';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/other/pin_confirm.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

class SwitchOutBloc extends Object implements BlocBase {
  final localAuth = LocalAuthentication();
  final ctrlAmount = new MoneyMaskedTextController(thousandSeparator: ',', decimalSeparator: '', precision: 0, leftSymbol: "£ ");
  Savings saving;
  StreamSubscription timeout;

  final _amountOld = BehaviorSubject<num>();
  final _amount = BehaviorSubject<num>();
  final _isLoading = BehaviorSubject<bool>();

  Stream<num> get getAmount => _amount.stream;
  Stream<num> get getOldAmount => _amountOld.stream;
  Stream<bool> get getLoading => _isLoading.stream;

  SwitchOutBloc(Savings saving) {
    saving = saving;
    _amount.sink.add(saving.quantity);
    if(saving.exitEarlyRequests.length > 0) {
      saving.exitEarlyRequests.forEach((v) {
        if (v.status == "Active") {
          _amount.sink.add(_amount.value - v.quantity);
        }
      });
    }
    _amountOld.sink.add(_amount.value);
    ctrlAmount.updateValue(_amount.value.toDouble());
    ctrlAmount.addListener(() {
        timeout?.cancel();
        timeout = Future.delayed(Duration(milliseconds: 1500)).asStream().listen((i) {
          if (ctrlAmount.numberValue > _amountOld.value) {
            ctrlAmount.updateValue(_amountOld.value);
          }else {
            ctrlAmount.updateValue(thousandRounding(ctrlAmount.numberValue));
          }
        });
        if (ctrlAmount.numberValue < 100) {
          ctrlAmount.updateValue(100);
        }
        _amount.sink.add(ctrlAmount.numberValue);
      });
  }

  @override
  void dispose() {
    _amount.close();
    _isLoading.close();
    ctrlAmount.dispose();
  }

  num thousandRounding(num amount) {
    return ((amount/100).floor()*100).toDouble();
  }

  num earning(double interest, num i) {
    var result = (interest * (ctrlAmount.numberValue/_amountOld.value) * i);
    return result.isNaN || result.isInfinite ? 0:result;
  }

  addValue() {
    _amountOld.sink.add(_amountOld.value);
    if (_amountOld.value != null && ctrlAmount.numberValue < _amountOld.value) {
      ctrlAmount.updateValue(ctrlAmount.numberValue + 100);
    }
  }

  removeValue() {
    _amountOld.sink.add(_amountOld.value);
    if (_amountOld.value != null && ctrlAmount.numberValue > 100) {
      ctrlAmount.updateValue(ctrlAmount.numberValue - 100);
    }
  }

  onChange(String value) async {
    print(value);
  }
  
  confirmSwitchOut(BuildContext context, String termDepositId) async {
    var list = await localAuth.getAvailableBiometrics();
    if (list.length > 0) {
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please authenticate to process transaction',
          useErrorDialogs: false,
          iOSAuthStrings: IOSAuthMessages(
            cancelButton: 'cancel',
            goToSettingsButton: 'settings',
            goToSettingsDescription: 'Please set up your Touch ID.',
            lockOut: 'Please reenable your Touch ID')
      );
      print(didAuthenticate);
      if (didAuthenticate) {
        doSwitchOut(context, termDepositId);
      }
      return false;
    }
    var data = await Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: ConfirmPINPage()));
    if (data == true) {
      doSwitchOut(context, termDepositId);
    }
  }

  doSwitchOut(BuildContext context, String termDepositId) async {
    _isLoading.sink.add(true);
    try {
      await repo.sendMatchOrder(termDepositId, _amount.value);
      sessions.save("switchout", "Your switching out has been placed, this will be offered back to the community for 30 days");
      _isLoading.sink.add(false);
      Navigator.popUntil(context, ModalRoute.withName('/main'));
    } catch (e) {
      print(e);
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401 || error['errorCode'] == 403) {
          sessions.clear();
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        dialogs.alertWithIcon(context, icon: Icons.info, title: "", message: error['message']);
      } catch (e) {
        dialogs.alertWithIcon(context, icon: Icons.info, title: "", message: e.toString().replaceAll("Exception: ", ""));
      }
    }

  }

  
}