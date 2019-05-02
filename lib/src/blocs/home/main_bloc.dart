import 'dart:async';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';

class MainBloc extends Object implements BlocBase {
  final _titleHeader = BehaviorSubject<String>();
  final _menuIndex = BehaviorSubject<int>();


  Stream<String> get gettitleHeader => _titleHeader.stream;
  Stream<int> get getMenuIndex => _menuIndex.stream;

  MainBloc() {
    print('panggil');
  }

  @override
  void dispose() {
    print("Main Disposed");
    _titleHeader.close();
    _menuIndex.close();
  }

  changeMenu(int index) {
    _menuIndex.sink.add(index);
    switch (index) {
      case 1:
      _titleHeader.sink.add("Savings Summary");
        break;
      case 2:
      _titleHeader.sink.add("My Profile");
        break;
      default:
      _titleHeader.sink.add("Choose Deposit");
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