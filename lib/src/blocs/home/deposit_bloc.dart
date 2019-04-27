import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';

class DepositBloc extends Object implements BlocBase {
  final depositInput = TextEditingController();
  StreamSubscription timeout;

  DepositBloc() {
    depositInput.text = '0';
  }

  @override
  void dispose() {
    depositInput.dispose();
  }


  addValue() {
    depositInput.text = (int.parse(depositInput.text) + 100).toString();
  }
  removeValue() {
    if (int.parse(depositInput.text) > 100) {
      depositInput.text = (int.parse(depositInput.text) - 100).toString();
    }
  }
  onChange(int value) async {
    timeout?.cancel();
    timeout = Future.delayed(Duration(seconds: 2)).asStream().listen((i) {
      if (value < 100) {
        depositInput.text = '100';
      }
    });
  }


}

final depositBloc = new DepositBloc();