import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:RAI/src/wigdet/keyboard_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class ConfirmPIN extends CupertinoPageRoute {
  ConfirmPIN() : super(builder: (BuildContext context) => new ConfirmPINPage());


  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new ScaleTransition(scale: animation, child: new ConfirmPINPage());
  }
}

class ConfirmPINPage extends StatefulWidget {
  @override
  _ConfirmPINPageState createState() => _ConfirmPINPageState();
}

class _ConfirmPINPageState extends State<ConfirmPINPage> {
  final _key = new GlobalKey<ScaffoldState>();
  String _pin = "";
  String _userPIN;


  @override
  void initState() { 
    super.initState();
    loadUserPIN();
  }

  loadUserPIN() async {
    _userPIN = await sessions.load("userPin");
  }

  Widget smallCircle = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Container(
      width: 12.0,
      height: 12.0,
      decoration: new BoxDecoration(
        color: Pigment.fromString("a2dbef"),
        shape: BoxShape.circle,
      ),
    ),
  );

  Widget bigCircle = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: Container(
      width: 18.0,
      height: 18.0,
      decoration: new BoxDecoration(
        color: Pigment.fromString("002244"),
        shape: BoxShape.circle,
      ),
    ),
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                height: 80,
                width: 100,
              ),
            ),
            SizedBox(height: 5),
            Text("OneUp.", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
            SizedBox(height: 10),
            Text("ENTER YOUR 6-DIGIT CODE", style: TextStyle(fontSize: 10, color: Colors.grey)),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width / 1.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _pin.length > 0 ? bigCircle : smallCircle,
                  _pin.length > 1 ? bigCircle : smallCircle,
                  _pin.length > 2 ? bigCircle : smallCircle,
                  _pin.length > 3 ? bigCircle : smallCircle,
                  _pin.length > 4 ? bigCircle : smallCircle,
                  _pin.length > 5 ? bigCircle : smallCircle,
                ],
              ),
            ),

            Expanded(
              child: InputPin(
                textStyle: TextStyle(color: Colors.black, fontSize: 45.0, fontWeight: FontWeight.normal),
                onBackPressed: () {
                  setState(() {
                    if (_pin.length > 0) {
                      _pin = _pin.substring(0, _pin.length - 1);
                    }
                  });
                },
                onPressedKey: (String code) {
                  setState(() {
                   if (_pin.length < 6)  _pin += code;
                   if (_pin.length == 6) {
                     if (_pin == _userPIN) {
                       Navigator.pop(context, true);
                     }else{
                       _pin = "";
                       dialogs.alertWithIcon(context, icon: Icons.info, title: "Failed", message: "Wrong Code !");
                     }
                   }
                  });
                },
                onForgotPassword: null,
                isLogin: false,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Pigment.fromString("FAFAFA")
          ),
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text("Cancel", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
            ),
          ),
        )
      ),
    );
  }
}