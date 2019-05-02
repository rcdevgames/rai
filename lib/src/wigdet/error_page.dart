import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  String message;
  String buttonText;
  Function onPressed;
  ErrorPage({Key key, @required this.message, @required this.onPressed, @required this.buttonText}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline, size: 70, color: Theme.of(context).primaryColor),
            SizedBox(height: 20),
            Text(message, style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            RaisedButton(
              child: Text(buttonText, style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}