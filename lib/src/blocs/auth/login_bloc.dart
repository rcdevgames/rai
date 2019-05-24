import 'dart:async';
import 'dart:convert';
import 'package:RAI/src/providers/repository.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rxdart/rxdart.dart';
import 'package:RAI/src/util/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LoginBloc extends Object implements BlocBase {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _isLoading = BehaviorSubject<bool>();
  final _pin = BehaviorSubject<String>();
  final localAuth = LocalAuthentication();

  Stream<bool> get getLoading => _isLoading.stream;
  Stream<String> get getPin => _pin.stream;
  

  @override
  void dispose() {
    _isLoading.close();
    _pin.close();
  }

  LoginBloc() {
    _pin.sink.add("");
  }

  inputCode(GlobalKey<ScaffoldState> key, String code) {
    int codeLength = _pin.value == null ? 0 : _pin.value.length;
    if (codeLength < 5) {
      _pin.sink.add(_pin.value + code);
    }else{
      _pin.sink.add(_pin.value + code);
      checkLogin(key);
    }
  }

  removeCode() {
    int codeLength = _pin.value.length;
    if (codeLength > 0) {
      _pin.sink.add(_pin.value.substring(0, codeLength - 1));
    }
  }

  Future checkLogin(GlobalKey<ScaffoldState> key) async {
    _isLoading.sink.add(true);
    try {
      var response = await repo.doLogin(_pin.value);
      firebaseCloudMessaging_Listeners();
      sessions.save('userPin', _pin.value);
      sessions.save("token", response.accessToken);
      print(response.accessToken);
      await repo.setToken(await sessions.load("NotificationToken"));
      await repo.getKYC();
      _isLoading.sink.add(false);
      Navigator.of(key.currentContext).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
    } catch (e) {
      try {
        var error = json.decode(e.toString().replaceAll("Exception: ", ""));
        print("Error : ${error}");
        if(error.containsKey("errorMessage")) {
          dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "Failed", message: error['errorMessage']);
        }else if (error.containsKey("detail")){
          dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: error['title'], message: error['o:errorPath']);
        }else{
          dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "Failed", message: error['error']);
        }
      } catch (err) {
        var message = e.toString().contains("You entered an incorrect user name or password") ? "You entered an incorrect 6 digit code":e.toString().replaceAll("Exception: ", "");
        dialogs.alertWithIcon(key.currentContext, icon: Icons.info, title: "Failed", message: message);
      }
      _pin.sink.add("");
      _isLoading.sink.add(false);
    }
  }

  resetPin(GlobalKey<ScaffoldState> key) {
    Navigator.of(key.currentContext).pushNamed('/forgot');
  }

  checkIdentification(GlobalKey<ScaffoldState> key) async {
    var list = await localAuth.getAvailableBiometrics();
    String code = await sessions.load("userPin");
    await Future.delayed(const Duration(milliseconds: 800));
    if (list.length > 0 && (code != null && code.length == 6)) {
      try {
        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate to login',
            useErrorDialogs: false,
            iOSAuthStrings: IOSAuthMessages(
              cancelButton: 'cancel',
              goToSettingsButton: 'settings',
              goToSettingsDescription: 'Please set up your Touch ID.',
              lockOut: 'Please reenable your Touch ID')
        );

        if (didAuthenticate) {
          _pin.sink.add(code);
          checkLogin(key);
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          print('notAvailable');
        }else if(e.code == auth_error.notEnrolled) {
          print('notEnrolled');
        }else if(e.code == auth_error.otherOperatingSystem) {
          print('otherOperatingSystem');
        }else if(e.code == auth_error.passcodeNotSet) {
          print('passcodeNotSet');
        }
      }
    }
  }

  void firebaseCloudMessaging_Listeners() async {
    // _firebaseMessaging.requestNotificationPermissions();
    // if (Platform.isIOS) iOS_Permission();

    var token = await _firebaseMessaging.getToken();
    sessions.save("NotificationToken", token);
    print("Token FCM : $token");

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //   },
    // );
  }



}