import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:RAI/src/wigdet/dialog.dart';

class ForgotPinPage extends StatefulWidget {
  @override
  _ForgotPinPageState createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final _keyForget = GlobalKey<ScaffoldState>();
  final _recoverPinUrl =
      'mailto:oneup@sc.com?subject=Recover%20existing%20pin%20request&body=Hi%20OneUp%20team,%0D%0A%0D%0ACan%20you%20help%20and%20remind%20me%20of%20my%20existing%20OneUp%20Pin%20please.%0D%0A%0D%0AThanks!';
  final _newSignUpUrl =
      'mailto:oneup@sc.com?subject=New%20pin%20request&body=Hi%20OneUp%20team,%0D%0A%0D%0AI%20would%20like%20to%20join%20the%20OneUp%20community%20where%20I%20can%20watch%20my%20money%20grow%20and%20access%20it%20when%20I%20want.%0D%0A%0D%0AThanks!';

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor, fontSize: 15);
    var styleChild = TextStyle(color: Theme.of(context).primaryColor, fontSize: 15, height: 1.3);

    return Scaffold(
      key: _keyForget,
      appBar: AppBar(
        title: Text("Forgotten Pin", style: TextStyle(fontWeight: FontWeight.normal)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("Recover or get a new Pin", style: style),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                  "To recover your existing Pin or to sign-up and get a new Pin, please email the OneUp team at oneup@sc.com they will remind you of your Pin or issue you a new Pin.",
                  style: styleChild),
            ),
            SizedBox(height: 40),
            _buildEmailLink("Recover my Pin", _recoverPinUrl),
            _buildEmailLink("Sign-up and get a new Pin", _newSignUpUrl),
          ],
        ),
      ),
    );
  }

  MaterialButton _buildEmailLink(linkText, url) {
    return MaterialButton(
      onPressed: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          dialogs.alert(context, "", "Could not open email!");
        }
      },
      minWidth: double.infinity,
      color: Theme.of(context).primaryColor,
      child: Text(linkText, style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
    );
  }
}
