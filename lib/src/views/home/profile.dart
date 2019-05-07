import 'dart:async';
import 'dart:math';

import 'package:RAI/src/blocs/home/profile_bloc.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/history.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/views/profile/profile.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:RAI/src/wigdet/slide_menu.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pigment/pigment.dart';

class ProfilePage extends StatelessWidget {
  final _key = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _bankAccountKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _historyKey = GlobalKey<RefreshIndicatorState>();
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of(context).profileBloc;
    final Map<int, Widget> contents = {
      0:Padding(
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
                                padding: const EdgeInsets.only(top: 15, bottom: 20, right: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ItemsAction(
                                    caption: 'Make Default',
                                    color: Theme.of(context).primaryColor,
                                    onTap: () => profileBloc.setDefault(context,snapshot.data[i].bankAcctId),
                                  ),
                                ),
                              )
                            ],
                            secondaryActions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 14, bottom: 21, left: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ItemsAction(
                                    caption: 'Edit',
                                    color: Theme.of(context).primaryColor,
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => AccountDetailPage(snapshot.data[i])
                                    )),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14, bottom: 21, left: 5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ItemsAction(
                                    caption: 'Delete',
                                    color: Theme.of(context).primaryColor,
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                            child: ListTileDefault(
                              isDefault: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                              isSelected: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                              type: 2,
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
      1:StreamBuilder(
        stream: profileBloc.getHistory,
          builder: (context, AsyncSnapshot<List<List<History>>> snapshot) {
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
                          Text(formatDate(snapshot.data[i][0].transactionDate, [dd,' ',M,' ',yyyy]).toString(), style: TextStyle(fontSize: 11)),
                          SizedBox(height: 15),
                          Column(
                            children: snapshot.data[i].map((v) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Image.asset("assets/img/logo-${v.bankAccRefCode.toLowerCase()}.color.png", fit: BoxFit.cover)
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(child: Text(v.description, style: TextStyle(), textAlign: TextAlign.justify,)),
                                  SizedBox(width: 10),
                                  v.category == "In" ? Icon(Savewise.icons8_1_circled_right, color: Theme.of(context).primaryColor):Icon(Savewise.icons8_1_circled_left, color: Pigment.fromString("69be28"))
                                ],
                              )
                            )).toList()
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
  };
    
    return Scaffold(
      key: _key,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 1080) * 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Total Linked Accounts Balance", style: TextStyle(color: Colors.white)),
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
            child: StreamBuilder(
              initialData: 0,
              stream: profileBloc.getIndexTab,
              builder: (context, AsyncSnapshot<int> snapshot) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: CupertinoSegmentedControl(
                        pressedColor: Theme.of(context).primaryColor.withOpacity(0.7),
                        borderColor: Theme.of(context).primaryColor,
                        selectedColor: Theme.of(context).primaryColor,
                        unselectedColor: Colors.transparent,
                        onValueChanged: (v) => profileBloc.updateIndexTab(v),
                        groupValue: snapshot.data,
                        children: {
                          0: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Center(child: Text("LINKED ACCOUNTS", style: TextStyle(color: snapshot.data == 1 ? Theme.of(context).primaryColor:Colors.white, fontWeight: FontWeight.w600)))
                          ),
                          1: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Center(child: Text("MY ACTIVITIES", style: TextStyle(color: snapshot.data == 0 ? Theme.of(context).primaryColor:Colors.white, fontWeight: FontWeight.w600)))
                          )
                        },
                      ),
                    ),
                    Expanded(
                      child: contents[snapshot.data]
                    )
                  ],
                );
              }
            )
          )
        ],
      ),
      floatingActionButton: StreamBuilder(
        initialData: 0,
        stream: profileBloc.getIndexTab,
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.data == 0) {
            return FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => AccountDetailPage(null)
              )),
              backgroundColor: Colors.white,
              heroTag: "add",
              label: Text("Add Account", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor)),
              icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
            );
          } return Container();
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}