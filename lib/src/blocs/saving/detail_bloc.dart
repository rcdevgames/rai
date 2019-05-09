import 'dart:convert';

import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/other/pin_confirm.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class DetailSavingBloc extends Object implements BlocBase {
  final localAuth = LocalAuthentication();

  
  final _index = BehaviorSubject<int>();
  final _isLoading = BehaviorSubject<bool>();

  Stream<int> get getIndex => _index.stream;
  Stream<bool> get getLoading => _isLoading.stream;

  Function(int) get updateIndex => _index.sink.add;

  @override
  void dispose() {
    _index.close();
    _isLoading.close();
  }

  exitEarly(BuildContext context, String requestId) async {
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
        doAction(context, requestId);
      }
      return false;
    }
    var data = await Navigator.push(context, PageTransition(type: PageTransitionType.downToUp, child: ConfirmPINPage()));
    if (data == true) {
      doAction(context, requestId);
    }
  }

  doAction(BuildContext context, String requestId) async {
    try {
      _isLoading.sink.add(true);
      await repo.cancelSwitchOut(requestId);
      _isLoading.sink.add(false);
      Navigator.pop(context, true);
      dialogs.alertWithIcon(context, icon: Icons.check_circle_outline, title: "Success", message: "Switch Out Canceled.");
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

  num countPercentage(DateTime businessDate, DateTime date) {
    DateTime startDate = DateTime.now();
    var max = date.difference(startDate).inDays;
    var value = date.difference(businessDate).inDays;
    return ((value/max)*100)/100;
  }
  
}