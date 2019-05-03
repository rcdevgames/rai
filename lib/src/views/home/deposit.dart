import 'dart:async';
import 'dart:math';

import 'package:RAI/src/blocs/home/deposit_bloc.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/views/deposit/detail_purchase.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/input_deposit.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pigment/pigment.dart';


class DepositPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final depositBloc = new DepositBloc();
  
  @override
  void dispose() { 
    depositBloc?.dispose();
  }

  @override
  void didUpdateWidget (Type oldWidget) {
    print("Update");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 1080) * 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
              child: StreamBuilder(
                stream: depositBloc.getListDeposit,
                builder: (context, AsyncSnapshot<List<DepositMatch>> snapshot) {
                  if (snapshot.hasData) {
                    return StreamBuilder(
                      initialData: true,
                      stream: depositBloc.getSingleItem,
                      builder: (context, AsyncSnapshot<bool> isSinglePage) {
                        return LiquidPullToRefresh(
                          color: Theme.of(context).primaryColor.withOpacity(0.7),
                          key: _refreshIndicatorKey,
                          onRefresh: depositBloc.loadDepositMatch,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: isSinglePage.data ? 1:snapshot.data.length,
                            itemBuilder: (ctx, i) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: i == 0 ? 20:0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ListTileDefault(
                                      leading: Row(
                                        children: <Widget>[
                                          Image.asset("assets/img/logo-scb.color.png", scale: 12,),
                                          SizedBox(width: 5),
                                          Text(formatMoney.format(snapshot.data[i].amount, true), style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                      child: Text("${(snapshot.data[i].rate/100).toStringAsFixed(2)}%", style: TextStyle(fontSize: 18)),
                                      trailing: Text(formatMoney.format(snapshot.data[i].interest, true), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                      isDefault: true,
                                      type: snapshot.data[i].tag.contains("best") ? 1:5,
                                      dateTime: snapshot.data[i].maturityDate,
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) => DetailPurchasePage(snapshot.data[i])
                                        ));
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    );
                  }else if(snapshot.hasError) {
                    return ErrorPage(
                      message: snapshot.data.toString(), 
                      onPressed: depositBloc.loadDepositMatch,
                      buttonText: "Try Again",
                    );
                  } return LoadingBlock(Theme.of(context).primaryColor);
                }
              )
            ),
          )
        ],
      ),
      floatingActionButton: StreamBuilder(
        initialData: false,
        stream: depositBloc.getSingleItem,
        builder: (context, AsyncSnapshot<bool> isSinglePage) {
          if (isSinglePage.data) {
            return FloatingActionButton.extended(
              onPressed: depositBloc.openList,
              backgroundColor: Colors.white,
              heroTag: "more",
              label: Text("Show offers from the community", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor)),
              icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
            );
            // return RaisedButton(
            //   onPressed: depositBloc.openList,
            //   elevation: 0,
            //   color: Pigment.fromString("FAFAFA"),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text("Show offers from the community", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor)),
            //       Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor)
            //     ],
            //   ),
            // );
          } return Container();
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}