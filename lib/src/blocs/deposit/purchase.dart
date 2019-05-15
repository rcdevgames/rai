import 'dart:convert';

import 'package:RAI/src/blocs/home/main_bloc.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/other/pin_confirm.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:RAI/src/wigdet/transaction_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class PurchaseBloc extends Object implements BlocBase {
  CancelToken token = new CancelToken();
  final localAuth = LocalAuthentication();

  final _isLoading = BehaviorSubject<bool>();
  final _listBank = BehaviorSubject<List<Bank>>();
  final _selected = BehaviorSubject<int>();
  final _selectedBank = BehaviorSubject<Bank>();

  Stream<bool> get getLoading => _isLoading.stream;
  Stream<int> get getSelected => _selected.stream;
  Stream<List<Bank>> get getListBank => _listBank.stream;

  Function(int) get updateSelected => _selected.sink.add;
  Function(List<Bank>) get resetList => _listBank.sink.add;
  Function(Bank) get selectbank => _selectedBank.sink.add;

  PurchaseBloc(GlobalKey<ScaffoldState> key) {
    fetchBank(key.currentContext);
  }

  @override
  void dispose() {
    _isLoading.close();
    _listBank.close();
    _selected.close();
    token.cancel("Cancelled");
  }

  Future fetchBank(BuildContext context) async {
    try {
      var list = await repo.getBankList(token);
      list.forEach((v) {
        if (v.isDefault == 1) {
          _selected.sink.add(v.bankAcctId);
          _selectedBank.sink.add(v);
        }
      });
      _listBank.sink.add(list);
    } catch (e) {
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        if (error['errorCode'] == 401) {
          sessions.clear();
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
        _listBank.sink.addError(error['message']);
      } catch (e) {
        _listBank.sink.addError(e.toString().replaceAll("Exception: ", ""));
      }
    }
  }

  doPurchase(GlobalKey<ScaffoldState> key, DepositMatch depositMatch, num amount) async {
    var list = await localAuth.getAvailableBiometrics();
    if (list.length > 0) {
      try {
        // transactionModal.purchaseModal(key.currentContext, _selectedBank.value, amount);
        // await Future.delayed(const Duration(seconds: 2));
        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate to process transaction',
            useErrorDialogs: false,
            iOSAuthStrings: IOSAuthMessages(
                cancelButton: 'cancel',
                goToSettingsButton: 'settings',
                goToSettingsDescription: 'Please set up your Touch ID.',
                lockOut: 'Please reenable your Touch ID'));

        if (didAuthenticate) {
          try {
            _isLoading.sink.add(true);
            await repo.purchaseDeposit(amount, _selected.value, depositMatch.id);
            sessions.save("purchased", "Deposit successful. See My Money to watch your deposit grow!");
            _isLoading.sink.add(false);
            Navigator.of(key.currentContext).popUntil(ModalRoute.withName('/main'));
          } catch (e) {
            _isLoading.sink.add(false);
            Map<String, dynamic> error = json.decode(e.toString().replaceAll("Exception: ", ""));
            print(error);
            if (error['errorCode'] == 401) {
              sessions.clear();
              Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            } else if (error.containsKey("errorMessage")) {
              dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['errorMessage']);
              return false;
            }
            if (error.containsKey('message')) {
              dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['message']);
            } else {
              dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['errorMessage']);
            }
          }
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          Navigator.pop(key.currentContext);
          print('notAvailable');
        } else if (e.code == auth_error.notEnrolled) {
          Navigator.pop(key.currentContext);
          print('notEnrolled');
        } else if (e.code == auth_error.otherOperatingSystem) {
          Navigator.pop(key.currentContext);
          print('otherOperatingSystem');
        } else if (e.code == auth_error.passcodeNotSet) {
          Navigator.pop(key.currentContext);
          print('passcodeNotSet');
        }
      }
    } else {
      var data = await Navigator.push(
          key.currentContext, PageTransition(type: PageTransitionType.downToUp, child: ConfirmPINPage()));
      if (data == true) {
        try {
          _isLoading.sink.add(true);
          await repo.purchaseDeposit(amount, _selected.value, depositMatch.id);
          sessions.save("purchased", "Deposit successful. See My Money to watch your deposit grow!");
          _isLoading.sink.add(false);
          Navigator.of(key.currentContext).popUntil(ModalRoute.withName('/main'));
        } catch (e) {
          _isLoading.sink.add(false);
          Map<String, dynamic> error = json.decode(e.toString().replaceAll("Exception: ", ""));
          print(error);
          if (error['errorCode'] == 401) {
            sessions.clear();
            Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
          } else if (error.containsKey("errorMessage")) {
            dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['errorMessage']);
            return false;
          }
          if (error.containsKey('message')) {
            dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['message']);
          } else {
            dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "", message: error['errorMessage']);
          }
        }
      }
    }
  }
}
