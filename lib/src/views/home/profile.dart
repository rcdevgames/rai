import 'dart:async';
import 'dart:math';

import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _bankAccountKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _historyKey = GlobalKey<RefreshIndicatorState>();
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: _currentIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Total Linked Account Balance", style: TextStyle(color: Colors.white)),
              Text("£ 28.777", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _tabController.animateTo(0);
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent,
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Center(child: Text("LINKED ACCOUNTS", style: TextStyle(color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.white, fontWeight: FontWeight.w600)))
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _tabController.animateTo(1);
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.transparent,
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: Center(child: Text("MY ACTIVITIES", style: TextStyle(color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.white, fontWeight: FontWeight.w600)))
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    LiquidPullToRefresh(
                       color: Theme.of(context).primaryColor.withOpacity(0.7),
                      key: _bankAccountKey,
                      onRefresh: () {
                        final Completer<void> completer = Completer<void>();
                        Timer(const Duration(seconds: 3), () {
                          completer.complete();
                        });
                        return completer.future.then<void>((_) {
                          _bankAccountKey.currentState.show();
                        });
                      },
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (ctx, i) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 2, color: Colors.black26)
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset("assets/img/logo-scb.color.png", scale: 12),
                                        SizedBox(width: 10),
                                        Expanded(child: Text("Account $i", style: TextStyle(fontSize: 18))),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Balance", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                                            Text("£ 175", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                          ],
                                        ),
                                      ],
                                    )
                                  )
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    LiquidPullToRefresh(
                       color: Theme.of(context).primaryColor.withOpacity(0.7),
                      key: _historyKey,
                      onRefresh: () {
                        final Completer<void> completer = Completer<void>();
                        Timer(const Duration(seconds: 3), () {
                          completer.complete();
                        });
                        return completer.future.then<void>((_) {
                          _historyKey.currentState.show();
                        });
                      },
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) => Divider(),
                        itemCount: 5,
                        itemBuilder: (ctx, i) {
                          return ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("30 Nov 2019", style: TextStyle(fontSize: 11)),
                                SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset("assets/img/logo-scb.color.png", scale: 12),
                                    SizedBox(width: 10),
                                    Expanded(child: Text("Matured £12.500 with £500 interest amount from your £12.000 deposit @ interest rate 1.17% for 9 month", style: TextStyle(), textAlign: TextAlign.justify,)),
                                    SizedBox(width: 10),
                                    Icon(Savewise.icons8_1_circled_left, color: Colors.blueAccent)
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}