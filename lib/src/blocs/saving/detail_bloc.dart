import 'package:RAI/src/util/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class DetailSavingBloc extends Object implements BlocBase {
  final _index = BehaviorSubject<int>();

  Stream<int> get getIndex => _index.stream;
  Function(int) get updateIndex => _index.sink.add;

  @override
  void dispose() {
    _index.close();
  }

  exitEarly() {
    print("Exit Early");
  }

  num countPercentage(DateTime businessDate, DateTime date) {
    DateTime startDate = DateTime.now();
    var max = date.difference(startDate).inDays;
    var value = date.difference(businessDate).inDays;
    return ((value/max)*100)/100;
  }
  
}