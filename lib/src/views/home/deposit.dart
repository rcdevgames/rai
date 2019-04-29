import 'dart:async';
import 'dart:math';

import 'package:RAI/src/blocs/home/deposit_bloc.dart';
import 'package:RAI/src/views/deposit/detail_purchase.dart';
import 'package:RAI/src/wigdet/input_deposit.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pigment/pigment.dart';


class DepositPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  
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
            children: <Widget>[
              Text("How much do you want to save?", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              InputDeposit(
                inputController: depositBloc.depositInput,
                increaseValue: depositBloc.addValue,
                decreaseValue: depositBloc.removeValue,
                onValueChange: (val) => depositBloc.onChange(int.parse(val)),
              )
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
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
                itemCount: 10,
                itemBuilder: (ctx, i) {
                  return Column(
                    children: <Widget>[
                      SizedBox(height: i == 0 ? 20:0),
                      SizedBox(
                        height: 120,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 1,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => DetailPurchasePage()
                                  )),
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 2, color: Colors.black26)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Image.asset("assets/img/logo-scb.color.png", scale: 12,),
                                            SizedBox(width: 5),
                                            Text("£ 9.000", style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                        Text("${(Random.secure().nextInt(10) / 10).toString()}%", style: TextStyle(fontSize: 18)),
                                        Text("£ 175", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      ],
                                    )
                                  )
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
                                  child: Text("Monday 12 Jan 2020")
                                ),
                                Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.star, size: 20, color: Colors.white),
                                      Text("Best Rate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ),
        )
      ],
    );
  }
}