import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ButtonBottom extends StatelessWidget {
  String title;
  GestureTapCallback onTap;
  EdgeInsetsGeometry padding;
  double buttonTextSize;
  ButtonBottom({this.title, this.onTap, this.padding = const EdgeInsets.all(10), this.buttonTextSize});

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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: onTap != null ? Theme.of(context).primaryColor : Colors.grey
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Text(title, style: TextStyle(fontSize: buttonTextSize != null ? buttonTextSize.toDouble():(MediaQuery.of(context).size.width/1080) * 45, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18)
              ],
            ),
          ),
        )
      )
    );
  }
}