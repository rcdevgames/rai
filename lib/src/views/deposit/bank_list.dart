import 'dart:math';

import 'package:RAI/src/blocs/deposit/purchase.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/wigdet/button.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pigment/pigment.dart';

class BankListPage extends StatefulWidget {
  DepositMatch depositMatch;
  BankListPage(this.depositMatch);
  
  @override
  _BankListPageState createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final _key = GlobalKey<ScaffoldState>();
  PurchaseBloc purchaseBloc;

  @override
  void initState() {
    purchaseBloc = new PurchaseBloc(_key);
    super.initState();
  }

  @override
  void dispose() {
    purchaseBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text("Make Deposit", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/help'),
                icon: Icon(Icons.help_outline, color: Colors.white),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: purchaseBloc.getListBank,
            builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
              if (snapshot.hasData) {
                return LiquidPullToRefresh(
                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                  key: _refreshIndicatorKey,
                  onRefresh: () async => purchaseBloc.fetchBank(context),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: i == 0 ? 20:0),
                            i == 0 ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("Choose an account", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
                            ):Container(),
                            StreamBuilder(
                              stream: purchaseBloc.getSelected,
                              builder: (context, AsyncSnapshot<int> id) {
                                return ListTileDefault(
                                  isDefault: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                  isSelected: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                  type: 4,
                                  onTap: () => snapshot.data[i].bankAcctBalance < widget.depositMatch.amount ? {}:{
                                    purchaseBloc.updateSelected(snapshot.data[i].bankAcctId),
                                    purchaseBloc.selectbank(snapshot.data[i])
                                    
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: snapshot.data[i].bankAcctBalance < widget.depositMatch.amount ? 
                                        Image.asset("assets/img/logo-${snapshot.data[i].bankCode.toLowerCase()}.png", fit: BoxFit.cover):
                                        Image.asset("assets/img/logo-${snapshot.data[i].bankCode.toLowerCase()}.color.png", fit: BoxFit.cover)
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(child: Text('Bank ${snapshot.data[i].bankAcctName}', style: TextStyle(color: snapshot.data[i].bankAcctBalance < widget.depositMatch.amount ? Colors.grey:Theme.of(context).primaryColor, fontSize: 12))),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Balance", style: TextStyle(fontWeight: FontWeight.normal, color: snapshot.data[i].bankAcctBalance < widget.depositMatch.amount ? Colors.grey:Theme.of(context).primaryColor)),
                                          Text(formatMoney.format(snapshot.data[i].bankAcctBalance, true), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: snapshot.data[i].bankAcctBalance < widget.depositMatch.amount ? Colors.grey:Theme.of(context).primaryColor))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }else if(snapshot.hasError) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error.toString(),
                    onPressed: () async {
                      purchaseBloc.fetchBank(context);
                      purchaseBloc.resetList(null);
                    },
                    buttonText: "Try Again",
                  ),
                );
              } return LoadingBlock(Theme.of(context).primaryColor);
            }
          ),
          bottomNavigationBar: ButtonBottom(
            title: "CONFIRM DEPOSIT",
            onTap: () => purchaseBloc.doPurchase(_key, widget.depositMatch),
          )
        ),
        StreamBuilder(
          initialData: false,
          stream: purchaseBloc.getLoading,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}