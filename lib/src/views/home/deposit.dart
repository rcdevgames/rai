import 'dart:async';
import 'dart:math';

import 'package:RAI/src/blocs/home/deposit_bloc.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/deposit/detail_purchase.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/dialog.dart';
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
  Timer timer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    final depositBloc = BlocProvider.of(context).depositBloc;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 1080) * 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder(
                  stream: depositBloc.getAmount,
                  builder: (context, AsyncSnapshot<num> snapshot) {
                    print("Amount Deposit : ${snapshot.data}");
                    return InputDeposit(
                      inputController: depositBloc.depositInput,
                      increaseValue: (snapshot.hasData && depositBloc.depositInput.numberValue < snapshot.data) ? depositBloc.addValue:null,
                      decreaseValue: depositBloc.depositInput.numberValue > 100 ? depositBloc.removeValue: null,
                      onValueChange: (val) => depositBloc.onChange(int.parse(val)),
                      decreaseLongPress: () {
                        timer = new Timer(const Duration(milliseconds: 10), () {
                          timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                            if(depositBloc.depositInput.numberValue > 100) depositBloc.removeValue();
                          });
                        });
                      },
                      increaseLongPress: () {
                        timer = new Timer(const Duration(milliseconds: 10), () {
                          timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                            if(snapshot.hasData && depositBloc.depositInput.numberValue < snapshot.data != null) depositBloc.addValue();
                          });
                        });
                      },
                      increaseLongPressUp: () => timer.cancel(),
                      decreaseLongPressUp: () => timer.cancel(),
                    );
                  }
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
                  if (snapshot.hasData && snapshot.data.length > 0) {
                    return StreamBuilder(
                      initialData: true,
                      stream: depositBloc.getSingleItem,
                      builder: (context, AsyncSnapshot<bool> isSinglePage) {
                        return LiquidPullToRefresh(
                          color: Theme.of(context).primaryColor.withOpacity(0.7),
                          key: _refreshIndicatorKey,
                          onRefresh: depositBloc.reCallFunction,
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
                                          Image.asset("assets/img/logo-scb.color.png", scale: 15),
                                          SizedBox(width: 5),
                                          Text(formatMoney.format(depositBloc.depositInput.numberValue, true), style: TextStyle(fontSize: 16)),
                                        ],
                                      ),
                                      child: Text("${(snapshot.data[i].rate/100).toStringAsFixed(2)}%", style: TextStyle(fontSize: 16)),
                                      trailing: Text(formatMoney.format(snapshot.data[i].interest, true, true), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).primaryColor)),
                                      isDefault: true,
                                      type: 1,
                                      lefts: snapshot.data[i].isNew == false ? snapshot.data[i].expiryDate.difference(depositBloc.businessDate).inDays:null,
                                      dateTime: snapshot.data[i].maturityDate,
                                      onTap: () async {
                                        await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) => DetailPurchasePage(snapshot.data[i], depositBloc.depositInput.numberValue, depositBloc.businessDate)
                                        ));
                                        var data = await sessions.flashMessage("purchased");
                                        if (data != null) {
                                          dialogs.alertWithIcon(context, icon: Icons.check_circle_outline, title: "Success!", message: "Deposit successful. See My Savings to watch your deposit grow!");
                                          BlocProvider.of(context).changeMenu(1);
                                          BlocProvider.of(context).savingBloc.updateListSavings(null);
                                          BlocProvider.of(context).savingBloc.fetchSaving(context, true);
                                          BlocProvider.of(context).profileBloc.fetchHistory();
                                          BlocProvider.of(context).profileBloc.fetchAccountList();
                                        }
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
                  }else if(snapshot.hasData && snapshot.data.length < 1) {
                    return LiquidPullToRefresh(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      key: _refreshIndicatorKey,
                      onRefresh: depositBloc.loadDepositMatch,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(
                              child: Text("Data not found", style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
                            ),
                          )
                        ],
                      ),
                    );
                  }else if(snapshot.hasError) {
                    return ErrorPage(
                      message: snapshot.error.toString(), 
                      onPressed: () {
                        depositBloc.updateListDeposit(null);
                        depositBloc.reCallFunction();
                      },
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
            // return FloatingActionButton.extended(
            //   onPressed: depositBloc.openList,
            //   backgroundColor: Colors.white,
            //   heroTag: "more",
            //   label: Text("Show offers from the community", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor)),
            //   icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor),
            // );
            return RaisedButton(
              onPressed: depositBloc.openList,
              elevation: 0,
              color: Pigment.fromString("FAFAFA"),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Like to see more options?", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor.withOpacity(0.35), fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Show Community Offers", style: TextStyle(fontSize: 15, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w400)),
                      Icon(Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor)
                    ],
                  ),
                ],
              ),
            );
          } return Container();
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}