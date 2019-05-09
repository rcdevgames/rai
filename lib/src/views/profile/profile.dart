import 'package:RAI/src/models/bank.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class AccountDetailPage extends StatefulWidget {
  Bank details;
  AccountDetailPage(this.details);

  @override
  AccountDetailPageState createState() => AccountDetailPageState();
}

class AccountDetailPageState extends State<AccountDetailPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.details == null ? "Add Accounts":"Edit Accounts", style: TextStyle(fontWeight: FontWeight.normal)),
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
            onPressed: () {},
            color: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text("SAVE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
            ),
            label: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        )
      ),
    );
  }
}