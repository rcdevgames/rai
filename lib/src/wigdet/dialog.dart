import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialogs {
  alert(BuildContext context, String title, String description) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Platform.isAndroid ? 
        AlertDialog(
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
        ):CupertinoAlertDialog(
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

  prompt(BuildContext context, String title, Function onTap) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Platform.isAndroid ? 
        AlertDialog(
          title: Text(title),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
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
          actions: Platform.isAndroid ? 
          <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                onTap();
              },
              child: Text("Confirm"),
            ),
          ]: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
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
        return Platform.isAndroid ? 
        AlertDialog(
          title: Text(title),
          content: child,
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ): CupertinoAlertDialog(
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
}

final dialogs = Dialogs();