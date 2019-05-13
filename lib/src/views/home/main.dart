import 'dart:async';

import 'package:RAI/src/blocs/home/main_bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/home/deposit.dart';
import 'package:RAI/src/views/home/profile.dart';
import 'package:RAI/src/views/home/saving.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _key = GlobalKey<ScaffoldState>();

  final MainBloc mainBloc = new MainBloc();

  final List<Widget> pages = [
    new DepositPage(),
    new SavingPage(),
    new ProfilePage()
  ];

  String businessDate = "";

  @override
  void initState() {
    var interval;
    interval = new Timer.periodic(const Duration(seconds: 1), (i) async {
      var date = await sessions.load("businessDate");
      if(date != null) {
        businessDate = formatDate(DateTime.parse(date), [dd,' ',M,' ',yyyy]).toString();
        interval.cancel();
        refreshBusinessDate();
      }
      print('search Date, $date');
    });
    super.initState();
  }

  @override
  void dispose() {
    mainBloc?.dispose();
    super.dispose();
  }

  refreshBusinessDate() {
    new Timer.periodic(const Duration(milliseconds: 5348), (i) async {
      mainBloc.getUser(context);
      var date = await sessions.load("businessDate");
      businessDate = formatDate(DateTime.parse(date), [dd,' ',M,' ',yyyy]).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: mainBloc,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _key,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: StreamBuilder(
            initialData: "",
            stream: mainBloc.gettitleHeader,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return Text(snapshot.data, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15));
            }
          ),
          flexibleSpace: StreamBuilder(
            initialData: 0,
            stream: mainBloc.getMenuIndex,
            builder: (context, AsyncSnapshot<int> snapshot) {
              if (snapshot.data == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(child: Text("Choose the amount you\'d like to switch up?", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.white))),
                );
              } else if (snapshot.data == 2) {
                return Padding(
                  padding: const EdgeInsets.only(top: 63),
                  child: Center(child: Text(businessDate, style: TextStyle(color: Colors.white70))),
                );
              } return SizedBox();
            }
          ),
          leading: StreamBuilder(
            stream: mainBloc.getMenuIndex,
            builder: (context, AsyncSnapshot<int> snapshot) {
              if (snapshot.data == 2) {
                return IconButton(
                  onPressed: () => mainBloc.logout(_key),
                  icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white),
                );
              } return Container();
            }
          ),
          actions: <Widget>[
            StreamBuilder(
              stream: mainBloc.getMenuIndex,
              builder: (context, AsyncSnapshot<int> snapshot) {
                if (snapshot.data == 2) {
                  return IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('/notif'),
                    icon: Icon(Icons.notifications_none, color: Colors.white),
                  );
                } return Container();
              }
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/help'),
              icon: Icon(Icons.help_outline, color: Colors.white),
            ),
          ],
        ),
        body: StreamBuilder(
          initialData: 0,
          stream: mainBloc.getMenuIndex,
          builder: (context, AsyncSnapshot<int> snapshot) {
            return pages[snapshot.data];
          }
        ),
        bottomNavigationBar: StreamBuilder(
          initialData: 0,
          stream: mainBloc.getMenuIndex,
          builder: (context, AsyncSnapshot<int> snapshot) {
            return BottomNavigationBar(
              onTap: (int i) => mainBloc.changeMenu(i),
              currentIndex: snapshot.data,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 25,
                    width: 25,
                    child: Icon(Savewise.icons8_percentage, size: 20)
                  ),
                  title: Text("Deposit Offers", style: TextStyle(fontSize: 12))
                ),
                BottomNavigationBarItem(
                  icon: Icon(Savewise.icon_pounds),
                  title: Text("My Money", style: TextStyle(fontSize: 12))
                ),
                BottomNavigationBarItem(
                  icon: Icon(Savewise.icons8_user),
                  title: Text("My Profile", style: TextStyle(fontSize: 12))
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}