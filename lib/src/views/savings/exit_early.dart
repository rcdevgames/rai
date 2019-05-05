import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ExitEarlyPage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Saving Detail"),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/help'),
            icon: Icon(Icons.help_outline, color: Colors.white),
          ),
        ],
      ),
      body: Container(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Pigment.fromString("FAFAFA")
          ),
          child: RaisedButton.icon(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/main'));
            },
            color: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text("Confirm Switch Out", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
            ),
            label: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        )
      ),
    );
  }
}