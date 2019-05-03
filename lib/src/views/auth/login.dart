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
                  SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset('assets/svg/savewise-logo.svg'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("OneUp.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 50),
                  SizedBox(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: StreamBuilder(
                      initialData: "",
                      stream: loginBloc.getPin,
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            snapshot.data.length > 0 ? bigCircle : smallCircle,
                            snapshot.data.length > 1 ? bigCircle : smallCircle,
                            snapshot.data.length > 2 ? bigCircle : smallCircle,
                            snapshot.data.length > 3 ? bigCircle : smallCircle,
                            snapshot.data.length > 4 ? bigCircle : smallCircle,
                            snapshot.data.length > 5 ? bigCircle : smallCircle,
                          ],
                        );
                      }
                    ),
                  ),
                  Expanded(
                    child: InputPin(
                      textStyle: TextStyle(color: Colors.black, fontSize: 45.0, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),
                      onBackPressed: loginBloc.removeCode,
                      onPressedKey: (String code) => loginBloc.inputCode(_key, code),
                      onForgotPassword: () => loginBloc.resetPin(_key),
                    ),
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
            }
          )
        ],
      ),
    );
  }
}