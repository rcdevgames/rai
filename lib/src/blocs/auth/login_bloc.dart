import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';

class LoginBloc extends Object implements BlocBase {
  final _isLoading = BehaviorSubject<bool>();
  final _pin = BehaviorSubject<String>();

  Stream<bool> get getLoading => _isLoading.stream;
  Stream<String> get getPin => _pin.stream;

  @override
  void dispose() {
    _isLoading.close();
    _pin.close();
  }

  LoginBloc() {
    _pin.sink.add("");
  }

  inputCode(GlobalKey<ScaffoldState> key, String code) {
    int codeLength = _pin.value == null ? 0 : _pin.value.length;
    print(codeLength);
    if (codeLength < 5) {
      _pin.sink.add(_pin.value + code);
    }else{
      _pin.sink.add(_pin.value + code);
      checkLogin(key);
    }
  }

  removeCode() {
    int codeLength = _pin.value.length;
    if (codeLength > 0) {
      _pin.sink.add(_pin.value.substring(0, codeLength - 1));
    }
  }

  Future checkLogin(GlobalKey<ScaffoldState> key) async {
    _isLoading.sink.add(true);
    await Future.delayed(Duration(seconds: 3));
    _isLoading.sink.add(false);
    Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
  }

  resetPin(GlobalKey<ScaffoldState> key) {
    Navigator.of(key.currentContext).pushNamed('/forgot');
  }



}