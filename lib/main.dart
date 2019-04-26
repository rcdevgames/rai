import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:rai/route.dart';
import 'package:rai/src/util/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: Static.APP_NAME,
      theme: ThemeData(
        primaryColor: Pigment.fromString("#002244"),
        // fontFamily: 'Gotham'
      ),
      routes: routes,
    );
  }
}