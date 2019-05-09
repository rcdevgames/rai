import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:RAI/route.dart';
import 'package:RAI/src/util/data.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(ProductionApp());

class ProductionApp extends StatefulWidget {

  @override
  _ProductionAppState createState() => _ProductionAppState();
}

class _ProductionAppState extends State<ProductionApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    firebaseCloudMessaging_Listeners();
    sessions.save("env", "prod");
    super.initState();
  }

  void firebaseCloudMessaging_Listeners() async {
    _firebaseMessaging.requestNotificationPermissions();

    var token = await _firebaseMessaging.getToken();
    sessions.save("NotificationToken", token);
    print(token);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

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