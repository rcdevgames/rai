import 'dart:async';
import 'package:RAI/src/blocs/home/deposit_bloc.dart';
import 'package:RAI/src/blocs/home/profile_bloc.dart';
import 'package:RAI/src/blocs/home/saving_bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';

class MainBloc extends Object implements BlocBase {
  DepositBloc _depositBloc;
  SavingBloc _savingBloc;
  ProfileBloc _profileBloc;

  final _titleHeader = BehaviorSubject<String>();
  final _menuIndex = BehaviorSubject<int>();


  Stream<String> get gettitleHeader => _titleHeader.stream;
  Stream<int> get getMenuIndex => _menuIndex.stream;

  MainBloc() {
    _depositBloc = new DepositBloc();
    _savingBloc = new SavingBloc();
    _profileBloc = new ProfileBloc();
  }

  DepositBloc get depositBloc => _depositBloc;
  SavingBloc get savingBloc => _savingBloc;
  ProfileBloc get profileBloc => _profileBloc;

  @override
  void dispose() {
    _titleHeader.close();
    _menuIndex.close();
    _depositBloc.dispose();
    _savingBloc.dispose();
    _profileBloc.dispose();
  }

  changeMenu(int index) {
    _menuIndex.sink.add(index);
    switch (index) {
      case 1:
      _titleHeader.sink.add("My Cash");
        break;
      case 2:
      _titleHeader.sink.add("My Profile");
        break;
      default:
      _titleHeader.sink.add("Choose the amount you\'d like to switch up?");
        break;
    }
  }

  logout(GlobalKey<ScaffoldState> key) {
    dialogs.prompt(key.currentContext, "Are you sure to logout?",() {
      sessions.clear();
      Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }

  help() {

  }

  notification() {

  }

}

final mainBloc = new MainBloc();