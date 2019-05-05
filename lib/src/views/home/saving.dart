import 'dart:async';
import 'dart:math';

import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/views/savings/saving_detail.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:RAI/src/wigdet/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pigment/pigment.dart';


class SavingPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final savingBloc = BlocProvider.of(context).savingBloc;
    savingBloc.fetchSaving(context);

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height / 1080) * 150,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Total Savings", style: TextStyle(color: Colors.white)),
                  StreamBuilder(
                    stream: savingBloc.getTotalSavings,
                    builder: (context, AsyncSnapshot<num> snapshot) {
                      if (snapshot.hasData) {
                        return Text(formatMoney.format(snapshot.data), style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold));
                      } return LoadingBlock(Theme.of(context).primaryColor);
                    }
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Total Interest Earned", style: TextStyle(color: Colors.white)),
                  StreamBuilder(
                    stream: savingBloc.getTotalInterest,
                    builder: (context, AsyncSnapshot<num> snapshot) {
                      if (snapshot.hasData) {
                        return Text(formatMoney.format(snapshot.data), style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold));
                      } return LoadingBlock(Theme.of(context).primaryColor);
                    }
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: savingBloc.getListSavings,
            builder: (context, AsyncSnapshot<List<Savings>> snapshot) {
              if (snapshot.hasData) {
                
                return LiquidPullToRefresh(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  key: _refreshIndicatorKey,
                  onRefresh: () => savingBloc.fetchSaving(context),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: i == 0 ? 20:0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Slidable(
                              actionExtentRatio: 0.40,
                              delegate: new SlidableDrawerDelegate(),
                              secondaryActions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 14, bottom: 21, left: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: ItemsAction(
                                      caption: 'Explore Switch Out Options',
                                      color: Theme.of(context).primaryColor,
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                              child: ListTileDefault(
                                leading: Row(
                                  children: <Widget>[
                                    Image.asset("assets/img/logo-scb.color.png", scale: 12,),
                                    SizedBox(width: 5),
                                    Text(formatMoney.format(snapshot.data[i].quantity, true), style: TextStyle(fontSize: 18)),
                                  ],
                                ),
                                child: Text("${(snapshot.data[i].rate/100).toStringAsFixed(2)}%", style: TextStyle(fontSize: 18)),
                                trailing: Text(formatMoney.format(snapshot.data[i].accruedInterest, true), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                isDefault: true,
                                type: 3,
                                progressBarValue: savingBloc.countPercentage(savingBloc.businessDate, snapshot.data[i].maturityDate),
                                dateTime: DateTime.now(),
                                exited: null,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => SavingDetailPage(snapshot.data[i], savingBloc.businessDate)
                                  ));
                                },
                              ),
                            )
                          )
                        ],
                      );
                    },
                  ),
                );
              }else if(snapshot.hasError) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error,
                    buttonText: "Try Again",
                    onPressed: () {
                      savingBloc.updateListSavings(null);
                      savingBloc.fetchSaving(context);
                    },
                  ),
                );
              } return LoadingBlock(Theme.of(context).primaryColor);
            }
          ),
        )
      ],
    );
  }
}