import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:RAI/route.dart';
import 'package:RAI/src/util/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env-uat');
  runApp(UATApp());
}

class UATApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: Static.APP_NAME,
      theme: ThemeData(
        primaryColor: Pigment.fromString("#002244"),
        fontFamily: 'Gotham',
        // fontFamily: 'ProximaNova',
      ),
      routes: routes
    );
  }
}