import 'dart:async';

import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _key = GlobalKey<ScaffoldState>();
  String token;
  int count = 0;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Notification", style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      body: GestureDetector(
        onTap: () async {
          if (mounted) {
            timer?.cancel();
            setState(()  {
              timer = new Timer(const Duration(seconds: 2), () {
                count = 0;
              });
              count++;
            });
            if (count == 7) {
              Clipboard.setData(new ClipboardData(text: await sessions.load("NotificationToken")));
              _key.currentState.showSnackBar(SnackBar
                (content: Text('Token Copied')));
              timer?.cancel();
              setState(() => count = 0);
            }
            print(count);
          }
        },
        child: Center(
          child: Text("Notification Page"),
        ),
      ),
    );
  }
}