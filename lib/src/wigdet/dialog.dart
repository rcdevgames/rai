import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pigment/pigment.dart';

class Dialogs {
  alert(BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Confirm"),
            )
          ],
        );
      }
    );
  }

  prompt(BuildContext context, String title, Function onTap, {String cancel = "Cancel", String confirm = "Confirm"}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(cancel),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text(confirm),
            )
          ]
        );
      }
    );
  }

  promptWithIcon(BuildContext context, String title, IconData icon, Function onTap, {String cancel = "Cancel", String confirm = "Confirm"}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              icon != null ? Icon(icon, color: icon == Icons.check_circle_outline ? Pigment.fromString("#69be28"):Theme.of(context).primaryColor, size: 120):null,
              Text(title)
            ].where((v) => v != null).toList(),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(cancel),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text(confirm),
            )
          ]
        );
      }
    );
  }

  popup(BuildContext context, {String title, Widget items, Function onTap, Function onCancel}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Platform.isAndroid ? 
        AlertDialog(
          title: Text(title),
          content: items,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                if(onCancel != null) onCancel();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text("Confirm"),
            ),
          ],
        ): CupertinoAlertDialog(
          title: Text(title),
          content: items,
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                if(onCancel != null) onCancel();
              },
              child: Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text("Confirm"),
            )
          ]
        );
      }
    );
  }

  information(BuildContext context, {String title, Widget child}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: child,
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ]
        );
      }
    );
  }

  alertWithIcon(BuildContext context, {IconData icon, String title, String message}) {
    information(context, title: "", child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[ 
        icon != null ? Icon(icon, color: icon == Icons.check_circle_outline ? Pigment.fromString("#69be28"):Theme.of(context).primaryColor, size: 120):SizedBox(),
        SizedBox(height: icon != null ? 10:0),
        Text(title != null ? title:"", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
        Text(message != null ? message:"", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor.withOpacity(0.7))),
      ],
    ));
  }
}

final dialogs = Dialogs();