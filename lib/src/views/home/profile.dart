import 'dart:async';
import 'dart:math';

import 'package:RAI/src/blocs/home/profile_bloc.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/history.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:RAI/src/wigdet/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pigment/pigment.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _bankAccountKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _historyKey = GlobalKey<RefreshIndicatorState>();
  final profileBloc = new ProfileBloc();
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    profileBloc?.dispose();
    print("close");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height / 1080) * 220,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Total Linked Account Balance", style: TextStyle(color: Colors.white)),
              StreamBuilder(
                stream: profileBloc.getTotalBalance,
                builder: (context, AsyncSnapshot<num> snapshot) {
                  if (snapshot.hasData) {
                    return Text(formatMoney.format(snapshot.data, true), style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold));
                  } return LoadingBlock(Colors.white);
                }
              ),
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
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
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
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: StreamBuilder(
                        stream: profileBloc.getListBank,
                        builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
                          if (snapshot.hasData) {
                            return LiquidPullToRefresh(
                              color: Theme.of(context).primaryColor.withOpacity(0.7),
                              key: _bankAccountKey,
                              onRefresh: profileBloc.fetchAccountList,
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (ctx, i) {
                                  return StreamBuilder(
                                    stream: profileBloc.getSelectedDefault,
                                    builder: (context, AsyncSnapshot<int> id) {
                                      return Slidable(
                                        delegate: new SlidableDrawerDelegate(),
                                        actionExtentRatio: 0.25,
                                        actions: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                                            child: ItemsAction(
                                              caption: 'Make Default',
                                              color: Theme.of(context).primaryColor,
                                              onTap: () => profileBloc.setDefault(snapshot.data[i].bankAcctId),
                                            ),
                                          )
                                        ],
                                        child: ListTileDefault(
                                          isDefault: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                          isSelected: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                          type: 4,
                                          onTap: () {},
                                          leading: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Image.asset("assets/img/logo-${snapshot.data[i].bankCode.toLowerCase()}.color.png", fit: BoxFit.cover)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Bank ${snapshot.data[i].bankAcctName}'),
                                              Text('(${snapshot.data[i].bankAcctNo.substring(snapshot.data[i].bankAcctNo.length - 4)})'),
                                            ],
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Balance", style: TextStyle(fontWeight: FontWeight.bold)),
                                              Text(formatMoney.format(snapshot.data[i].bankAcctBalance, true), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  );
                                },
                              ),
                            );
                          }else if(snapshot.hasError) {
                            return Center(
                              child: ErrorPage(
                                message: snapshot.error,
                                onPressed: () {
                                  profileBloc.resetAccountList();
                                  profileBloc.fetchAccountList();
                                },
                                buttonText: "Try Again",
                              ),
                            );
                          } return LoadingBlock(Theme.of(context).primaryColor);
                        }
                      ),
                    ),
                    StreamBuilder(
                      stream: profileBloc.getHistory,
                      builder: (context, AsyncSnapshot<List<History>> snapshot) {
                        if (snapshot.hasData) {
                          return LiquidPullToRefresh(
                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                            key: _historyKey,
                            onRefresh: profileBloc.fetchHistory,
                            child: ListView.separated(
                              separatorBuilder: (ctx, i) => Divider(),
                              itemCount: snapshot.data.length,
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
                                          SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: Image.asset("assets/img/logo-${snapshot.data[i].bankAccRefCode.toLowerCase()}.color.png", fit: BoxFit.cover)
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(child: Text(snapshot.data[i].description, style: TextStyle(), textAlign: TextAlign.justify,)),
                                          SizedBox(width: 10),
                                          snapshot.data[i].category == "In" ? Icon(Savewise.icons8_1_circled_right, color: Theme.of(context).primaryColor):Icon(Savewise.icons8_1_circled_left, color: Pigment.fromString("69be28"))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        } else if(snapshot.hasError) {
                          return Center(
                            child: ErrorPage(
                              message: snapshot.error,
                              onPressed: () {
                                profileBloc.resetHistory();
                                profileBloc.fetchHistory();
                              },
                              buttonText: "Try Again",
                            ),
                          );
                        } return LoadingBlock(Theme.of(context).primaryColor);
                      }
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