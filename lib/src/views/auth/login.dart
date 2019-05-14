import 'package:RAI/src/util/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pigment/pigment.dart';
import 'package:RAI/src/blocs/auth/login_bloc.dart';
import 'package:RAI/src/wigdet/keyboard_pin.dart';
import 'package:RAI/src/wigdet/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<ScaffoldState>();
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    sessions.clear();
    loginBloc = new LoginBloc();
    loginBloc.checkIdentification(_key);
  }

  @override
  void dispose() {
    loginBloc?.dispose();
    super.dispose();
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
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.asset('assets/img/oneup-logo.png'),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("OneUp",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).primaryColor)),
                  SizedBox(height: 10),
                  Text("ENTER YOUR 6-DIGIT CODE",
                      style: TextStyle(fontSize: 10, color: Colors.grey)),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: StreamBuilder(
                        initialData: "",
                        stream: loginBloc.getPin,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              snapshot.data.length > 0
                                  ? bigCircle
                                  : smallCircle,
                              snapshot.data.length > 1
                                  ? bigCircle
                                  : smallCircle,
                              snapshot.data.length > 2
                                  ? bigCircle
                                  : smallCircle,
                              snapshot.data.length > 3
                                  ? bigCircle
                                  : smallCircle,
                              snapshot.data.length > 4
                                  ? bigCircle
                                  : smallCircle,
                              snapshot.data.length > 5
                                  ? bigCircle
                                  : smallCircle,
                            ],
                          );
                        }),
                  ),
                  Expanded(
                    child: Container()
                  ),
                  InputPin(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 43.0,
                        fontWeight: FontWeight.w300),
                    onBackPressed: loginBloc.removeCode,
                    onPressedKey: (String code) =>
                        loginBloc.inputCode(_key, code),
                    onForgotPassword: () => loginBloc.resetPin(_key),
                  )
                ],
              ),
            ),
          ),
          StreamBuilder(
              initialData: false,
              stream: loginBloc.getLoading,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                return Loading(snapshot.data);
              })
        ],
      ),
    );
  }
}
