import 'dart:async';
import 'dart:convert';
import 'package:RAI/src/models/notification.dart';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class NotificationsBloc extends Object implements BlocBase {
  CancelToken token = new CancelToken();
  final _listNotifications = BehaviorSubject<List<Notifications>>();

  Stream<List<Notifications>> get getListNotifications => _listNotifications.stream;
  Function(List<Notifications>) get updateListNotification => _listNotifications.sink.add;

  @override
  void dispose() {
    token?.cancel();
    _listNotifications.close();
  }

  Future fetchNotifications(BuildContext context) async {
    print("Call Service");
    try {
      var result = await repo.fetchNotification(token);
      print(result);
      _listNotifications.sink.add(result);
    } catch (e) {
      print(e);
        try {
          var error = json.decode(e.toString().replaceAll("Exception: ", ""));
          if (error['errorCode'] == 401) {
            sessions.clear();
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
          }
          if (error.containsKey('message')) {
            _listNotifications.sink.addError(error['message']);
          } else {
            _listNotifications.sink.addError(error['errorMessage']);
          }
        } catch (e) {
          _listNotifications.sink.addError(e.toString().replaceAll("Exception: ", ""));
        }
    }
  }
  
}