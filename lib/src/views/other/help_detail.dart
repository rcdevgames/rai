import 'package:RAI/src/models/help.dart';
import 'package:flutter/material.dart';

class HelpDetailPage extends StatelessWidget {
  Article detail;
  HelpDetailPage(this.detail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help - ${detail.title}"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(0.2)
        ),
        child: ListView(
          children: <Widget>[
            Text(detail.body, style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor), textAlign: TextAlign.justify,)
          ],
        ),
      )
    );
  }
}