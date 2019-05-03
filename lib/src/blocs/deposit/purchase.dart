import 'dart:convert';

import 'package:RAI/src/blocs/home/main_bloc.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PurchaseBloc extends Object implements BlocBase {
  // MainBloc mainBloc;
  
  final _isLoading = BehaviorSubject<bool>();
  final _listBank = BehaviorSubject<List<Bank>>();
  final _selected = BehaviorSubject<int>();

  Stream<bool> get getLoading => _isLoading.stream;
  Stream<int> get getSelected => _selected.stream;
  Stream<List<Bank>> get getListBank => _listBank.stream;

  Function(int) get updateSelected => _selected.sink.add;
  Function(List<Bank>) get resetList => _listBank.sink.add;

  PurchaseBloc(GlobalKey<ScaffoldState> key) {
    fetchBank(key.currentContext);
  }

  @override
  void dispose() {
    _isLoading.close();
    _listBank.close();
    _selected.close();
  }

  Future fetchBank(BuildContext context) async {
    try {
      var list = await repo.getBankList();
      list.forEach((v){
        if(v.isDefault == 1) {
          _selected.sink.add(v.bankAcctId);
        }
      });
      _listBank.sink.add(list);
    } catch (e) {
      var error = json.decode(e.toString().replaceAll("Exception: ", ""));
      if (error['errorCode'] == 401) {
        sessions.clear();
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
      _listBank.sink.addError(error['message']);
    }
  }

  doPurchase(GlobalKey<ScaffoldState> key, DepositMatch depositMatch) async {
    try {
      _isLoading.sink.add(true);
      await repo.purchaseDeposit(depositMatch.amount, _selected.value, depositMatch.id);
      dialogs.alertWithIcon(key.currentContext, icon: Icons.check_circle_outline, title: "Success", message: "Deposit successful. See My Cash to watch your deposit grow!");
      _isLoading.sink.add(false);
      Navigator.of(key.currentContext).popUntil(ModalRoute.withName('/main'));
    } catch (e) {
      _isLoading.sink.add(false);
      Map<String, dynamic> error = json.decode(e.toString().replaceAll("Exception: ", ""));
      print(error);
      if (error['errorCode'] == 401) {
        sessions.clear();
        Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else if (error.containsKey("errorMessage")) {
        dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "Error", message: error['errorMessage']);
        return false;
      }
      dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "Error", message: error['message']);
    }
  }

}