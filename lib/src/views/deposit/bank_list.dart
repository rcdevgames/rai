import 'dart:math';

import 'package:flutter/material.dart';

class BankListPage extends StatefulWidget {
  @override
  _BankListPageState createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Make Deposit"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (ctx, i) {
          return Container(
            height: MediaQuery.of(context).size.height / 12,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Center(
              child: ListTile(
                onTap: (){},
                leading: Image.asset("assets/img/logo-scb.color.png", scale: 12),
                title: Text('Bank $i (${Random.secure().nextInt(9999)})'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Balance", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("£ 17.620", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: ListTile(
              onTap: () => Navigator.of(context).popUntil(ModalRoute.withName('/main')),
              title: Text("Choose Deposit", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        )
      ),
    );
  }
}