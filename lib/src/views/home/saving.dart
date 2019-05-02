import 'dart:async';
import 'dart:math';

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
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (MediaQuery.of(context).size.height / 1080) * 220,
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
                  Text("£ 25.000", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Total Interest Earned", style: TextStyle(color: Colors.white)),
                  Text("£ 452", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: LiquidPullToRefresh(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            key: _refreshIndicatorKey,
            onRefresh: () {
              final Completer<void> completer = Completer<void>();
              Timer(const Duration(seconds: 3), () {
                completer.complete();
              });
              return completer.future.then<void>((_) {
                _refreshIndicatorKey.currentState.show();
              });
            },
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (ctx, i) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: i == 0 ? 20:0),
                    SizedBox(
                      height: 143,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                              child: Slidable(
                                delegate: new SlidableDrawerDelegate(),
                                actionExtentRatio: 0.25,
                                secondaryActions: <Widget>[
                                  ItemsAction(
                                    caption: 'Explore Exit Early Options',
                                    color: Theme.of(context).primaryColor,
                                    onTap: () => print('More'),
                                  )
                                ],
                                child: GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 2, color: Colors.black26)
                                    ),
                                    child: Center(
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Image.asset("assets/img/logo-scb.color.png", scale: 15,),
                                                SizedBox(width: 5),
                                                Text("£ 9.000"),
                                              ],
                                            ),
                                            Text((Random.secure().nextInt(10) / 10).toString()),
                                            Text("£ 175"),
                                          ],
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            LinearPercentIndicator(
                                              width: MediaQuery.of(context).size.width - 100,
                                              lineHeight: 18,
                                              percent: (Random.secure().nextInt(10) / 10),
                                              progressColor: Theme.of(context).primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Pigment.fromString("FAFAFA")
                                  ),
                                  child: Text("Matures 12 Jan 2020")
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Pigment.fromString("FAFAFA")
                                  ),
                                  child: Text("In Early Exit (1)", style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}