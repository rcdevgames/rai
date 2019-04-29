import 'package:flutter/material.dart';

class ForgotPinPage extends StatefulWidget {
  @override
  _ForgotPinPageState createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final _keyForget = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyForget,
      appBar: AppBar(
        title: Text("ForgotPin"),
      ),
      body: Center(
        child: Text("ForgotPin Page"),
      ),
    );
  }
}