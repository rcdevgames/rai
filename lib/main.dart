import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:RAI/route.dart';
import 'package:RAI/src/util/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(DevApp());
}

class DevApp extends StatelessWidget {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void firebaseCloudMessaging_Listeners() async {
    _firebaseMessaging.requestNotificationPermissions();

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
    firebaseCloudMessaging_Listeners();
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