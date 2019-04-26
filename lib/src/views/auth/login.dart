import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pigment/pigment.dart';
import 'package:rai/src/wigdet/input_pin.dart';
import 'package:rai/src/wigdet/keyboard_pin.dart';
import 'package:rai/src/wigdet/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();
  String pin = "";
  bool loading = false;

  Future checkLogin() async {
    setState(() {
      if (pin.length == 6) loading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      loading = false;
    });
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
  }

  Widget smallCircle = new Container(
    width: 12.0,
    height: 12.0,
    decoration: new BoxDecoration(
      color: Pigment.fromString("a2dbef"),
      shape: BoxShape.circle,
    ),
  );

  Widget bigCircle = new Container(
    width: 17.0,
    height: 17.0,
    decoration: new BoxDecoration(
      color: Pigment.fromString("002244"),
      shape: BoxShape.circle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.,
                children: <Widget>[
                  SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset('assets/svg/savewise-logo.svg'),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("SAVEWISE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        pin.length > 0 ? bigCircle : smallCircle,
                        pin.length > 1 ? bigCircle : smallCircle,
                        pin.length > 2 ? bigCircle : smallCircle,
                        pin.length > 3 ? bigCircle : smallCircle,
                        pin.length > 4 ? bigCircle : smallCircle,
                        pin.length > 5 ? bigCircle : smallCircle,
                      ],
                    ),
                  ),
                  Expanded(
                    child: InputPin(
                      textStyle: TextStyle(color: Colors.black, fontSize: 45.0, fontWeight: FontWeight.w500),
                      onBackPressed: () {
                        int codeLength = pin.length;
                        if (codeLength > 0)
                          setState(() {
                            pin = pin.substring(0, codeLength - 1);
                          });
                          print(pin);
                      },
                      onPressedKey: (String key) {
                        setState(() {
                          if (pin.length < 6)
                            pin += key;
                          checkLogin();
                        });
                        print(pin);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Loading(loading)
      ],
    );
  }
}