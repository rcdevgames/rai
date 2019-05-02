import 'dart:math';

import 'package:RAI/src/blocs/deposit/purchase.dart';
import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
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
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text("Make Deposit"),
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
                      return Column(
                        children: <Widget>[
                          SizedBox(height: i == 0 ? 20:0),
                          StreamBuilder(
                            stream: purchaseBloc.getSelected,
                            builder: (context, AsyncSnapshot<int> id) {
                              print(id.data);
                              return ListTileDefault(
                                isDefault: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                isSelected: id.hasData ? (snapshot.data[i].bankAcctId == id.data):false,
                                type: 4,
                                onTap: () => purchaseBloc.updateSelected(snapshot.data[i].bankAcctId),
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
                              );
                            }
                          ),
                        ],
                      );
                    },
                  ),
                );
              }else if(snapshot.hasError) {
                return Center(
                  child: ErrorPage(
                    message: snapshot.error,
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
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Pigment.fromString("FAFAFA")
              ),
              child: RaisedButton.icon(
                onPressed: () => purchaseBloc.doPurchase(_key, widget.depositMatch),
                color: Theme.of(context).primaryColor,
                icon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text("Choose Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                ),
                label: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            )
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