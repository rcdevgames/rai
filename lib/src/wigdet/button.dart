import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ButtonBottom extends StatelessWidget {
  String title;
  GestureTapCallback onTap;
  EdgeInsetsGeometry padding;
  IconData icon;
  double buttonTextSize;
  ButtonBottom({this.title, this.onTap, this.padding = const EdgeInsets.all(10), this.buttonTextSize, this.icon = Icons.arrow_forward_ios});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Pigment.fromString("FAFAFA")
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: onTap != null ? Theme.of(context).primaryColor : Colors.grey
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Text(title, style: TextStyle(fontSize: buttonTextSize != null ? buttonTextSize.toDouble():(MediaQuery.of(context).size.width/1080) * 48, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                icon != null ? Icon(icon, color: Colors.white, size: 18):null
              ].where((v) => v != null).toList()
            ),
          ),
        )
      )
    );
  }
}