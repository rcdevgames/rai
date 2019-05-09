import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:RAI/route.dart';
import 'package:RAI/src/util/data.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(UATApp());

class UATApp extends StatefulWidget {

  @override
  _UATAppState createState() => _UATAppState();
}

class _UATAppState extends State<UATApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    firebaseCloudMessaging_Listeners();
    sessions.save("env", "uat");
    super.initState();
  }

  void firebaseCloudMessaging_Listeners() async {
  _firebaseMessaging.requestNotificationPermissions();
  // if (Platform.isIOS) iOS_Permission();

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

void iOS_Permission() {
  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true)
  );
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings)
  {
    print("Settings registered: $settings");
  });
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