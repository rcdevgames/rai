import 'package:flutter/material.dart';
import 'package:rai/src/views/auth/login.dart';
import 'package:rai/src/views/home/main.dart';

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new LoginPage(),
  '/main': (BuildContext context) => new MainPage(),
  
  
};