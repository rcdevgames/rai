import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pigment/pigment.dart';

class MenuBlock extends StatelessWidget {
  String title;
  String backgroundColor = '#000000';
  IconData icon = FontAwesomeIcons.question;
  dynamic callback;


  MenuBlock(this.title, {Key key, this.icon, this.backgroundColor, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 130.0,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: Pigment.fromString(backgroundColor)
      ),
      child: InkWell(
        onTap: callback,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0),
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.red,
                ),
                child: Icon(icon, color: Colors.white, size: 35.0),
              ),
              SizedBox(height: 5.0),
              Text(title, style: TextStyle(fontSize: 16.0))
            ],
          ),
        ),
      ),
    );
  }
}