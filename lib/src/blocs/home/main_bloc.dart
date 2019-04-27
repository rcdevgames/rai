import 'dart:async';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';

class MainBloc extends Object implements BlocBase {
  final _actionButtons = BehaviorSubject<List<Widget>>();
  final _titleHeader = BehaviorSubject<String>();
  final _menuIndex = BehaviorSubject<int>();

  Stream<List<Widget>> get getActionButtons => _actionButtons.stream;
  Stream<String> get gettitleHeader => _titleHeader.stream;
  Stream<int> get getMenuIndex => _menuIndex.stream;

  @override
  void dispose() {
    _actionButtons.close();
    _titleHeader.close();
    _menuIndex.close();
  }

  changeMenu(int index) {
    _menuIndex.sink.add(index);
    _actionButtons.sink.add([
      IconButton(
        icon: Icon(Icons.help_outline),
        onPressed: (){},
      ),
    ]);
    switch (index) {
      case 1:
      _titleHeader.sink.add("Savings Summary");
        break;
      case 2:
      _titleHeader.sink.add("My Profile");
      _actionButtons.sink.add([
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: (){},
        ),
        IconButton(
          icon: Icon(Icons.help_outline),
          onPressed: (){},
        ),
      ]);
        break;
      default:
      _titleHeader.sink.add("Choose Deposit");
        break;
    }
  }

  logout(GlobalKey<ScaffoldState> key) {
    dialogs.prompt(key.currentContext, "Are you sure to logout?",() {
      Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    });
  }

  help() {

  }

  notification() {

  }

}

final mainBloc = new MainBloc();