import 'package:RAI/src/views/auth/tour_page.dart';
import 'package:RAI/src/views/other/help.dart';
import 'package:RAI/src/views/other/notification.dart';
import 'package:flutter/material.dart';
import 'package:RAI/src/views/auth/login.dart';
import 'package:RAI/src/views/home/main.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new TourPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/main': (BuildContext context) => new MainPage(),
  '/help': (BuildContext context) => new HelpPage(),
  '/notif': (BuildContext context) => new NotificationPage(),
};