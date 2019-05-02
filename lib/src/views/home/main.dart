import 'package:RAI/src/blocs/home/main_bloc.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/home/deposit.dart';
import 'package:RAI/src/views/home/profile.dart';
import 'package:RAI/src/views/home/saving.dart';
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
  final mainBloc = new MainBloc();
  final List<Widget> pages = [
    new DepositPage(),
    new SavingPage(),
    new ProfilePage()
  ];

  String businessDate = "";

  @override
  void initState() {
    sessions.load("businessDate").then((date) {
      businessDate = formatDate(DateTime.parse(date), [dd,' ',M,' ',yyyy]).toString();
    });
    super.initState();
  }

  @override
  void dispose() {
    mainBloc?.dispose();
    super.dispose();
    print('Main Dispose');
  }

  toSummary() {
    mainBloc.changeMenu(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _key,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: StreamBuilder(
          initialData: "Choose Deposit",
          stream: mainBloc.gettitleHeader,
          builder: (context, AsyncSnapshot<String> snapshot) {
            return Text(snapshot.data);
          }
        ),
        flexibleSpace: StreamBuilder(
          initialData: 0,
          stream: mainBloc.getMenuIndex,
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.data == 2) {
              return Padding(
                padding: const EdgeInsets.only(top: 65),
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
                icon: Icon(FontAwesomeIcons.piggyBank),
                title: Text("Deposits")
              ),
              BottomNavigationBarItem(
                icon: Icon(Savewise.icons8_graph),
                title: Text("Summary")
              ),
              BottomNavigationBarItem(
                icon: Icon(Savewise.icons8_user_female),
                title: Text("Profile")
              ),
            ],
          );
        }
      ),
    );
  }
}