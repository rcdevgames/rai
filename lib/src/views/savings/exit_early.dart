import 'dart:async';

import 'package:RAI/src/blocs/saving/switchout_bloc.dart';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/wigdet/button.dart';
import 'package:RAI/src/wigdet/input_deposit.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ExitEarlyPage extends StatefulWidget {
  Savings item;
  DateTime businessDate;
  ExitEarlyPage(this.item, this.businessDate);
  
  @override
  _ExitEarlyPageState createState() => _ExitEarlyPageState();
}

class _ExitEarlyPageState extends State<ExitEarlyPage> {
  final _key = GlobalKey<ScaffoldState>();
  SwitchOutBloc switchOutBloc;
  Timer timer;

  @override
  void initState() { 
    super.initState();
    switchOutBloc = new SwitchOutBloc(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Switch Out", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/help'),
                icon: Icon(Icons.help_outline, color: Colors.white),
              ),
            ],
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("How much would you like back from?", style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor), textAlign: TextAlign.center,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: MediaQuery.of(context).size.height / 6.3,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset("assets/img/logo-scb.color.png")
                          ),
                          SizedBox(width: 10),
                          Text("Standard Chartered Bank", style: TextStyle(fontSize: 16))
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Table(
                          children: <TableRow>[
                            TableRow(
                              children: <Widget>[
                                Text("Deposit", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                                Container(decoration: BoxDecoration(border: Border(left: BorderSide(), right: BorderSide())),child: Text("Rate", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center)),
                                Text("Interest Due", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                              ]
                            ),
                            TableRow(
                              children: <Widget>[
                                StreamBuilder(
                                  initialData: 0,
                                  stream: switchOutBloc.getOldAmount,
                                  builder: (context, AsyncSnapshot<num> snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                                      child: Text(formatMoney.format(!snapshot.hasError ? snapshot.data:0, true), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                                    );
                                  }
                                ),
                                Container(padding: const EdgeInsets.only(top: 10, bottom: 5), decoration: BoxDecoration(border: Border(left: BorderSide(), right: BorderSide())),child: Text("${(widget.item.rate/100).toStringAsFixed(2)}%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                                  child: Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 1), true, true), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                                )
                              ]
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: 
                  // InputDeposit(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width,
                  //   inputController: switchOutBloc.ctrlAmount,
                  //   increaseValue: switchOutBloc.addValue,
                  //   decreaseValue: switchOutBloc.removeValue,
                  //   onValueChange: switchOutBloc.onChange,
                  // )
                  StreamBuilder(
                    stream: switchOutBloc.getOldAmount,
                    builder: (context, AsyncSnapshot<num> snapshot) {
                      return InputDeposit(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        inputController: switchOutBloc.ctrlAmount,
                        increaseValue: (snapshot.hasData && snapshot.data > switchOutBloc.ctrlAmount.numberValue ) ? () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          switchOutBloc.addValue();
                        }:null,
                        decreaseValue: switchOutBloc.ctrlAmount.numberValue > 100 ? () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          switchOutBloc.removeValue();
                        }:null,
                        onValueChange: switchOutBloc.onChange,
                        decreaseLongPress: () {
                        timer = new Timer(const Duration(milliseconds: 10), () {
                          timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                            if(switchOutBloc.ctrlAmount.numberValue > 100) switchOutBloc.removeValue();
                          });
                        });
                      },
                      increaseLongPress: () {
                        timer = new Timer(const Duration(milliseconds: 10), () {
                          timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                            if(snapshot.hasData && switchOutBloc.ctrlAmount.numberValue < snapshot.data != null) switchOutBloc.addValue();
                          });
                        });
                      },
                      increaseLongPressUp: () => timer.cancel(),
                      decreaseLongPressUp: () => timer.cancel(),
                      );
                    }
                  ),
                ),
                Expanded(
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      decoration: BoxDecoration(
                        color: Pigment.fromString("#f6fbff"),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          StreamBuilder(
                            stream: switchOutBloc.getAmount,
                            builder: (context, AsyncSnapshot<num> snapshot) {
                              return Text("Switching out may cost you ${formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 1), true, true)} of interest. The exact amount depends on when you switch out.", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300, fontSize: (MediaQuery.of(context).size.width / 1080) * 40, wordSpacing: 3, height: 1.5), textAlign: TextAlign.center);
                            }
                          ),
                          RaisedButton(
                            onPressed: (){},
                            color: Colors.white,
                            elevation: 0,
                            child: Text("Know more >", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                    ),
                    back: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      decoration: BoxDecoration(
                        color: Pigment.fromString("#f6fbff"),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("As you try to switch out, you will", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17)),
                          SizedBox(height: 20),
                          StreamBuilder(
                            initialData: 0,
                            stream: switchOutBloc.getAmount,
                            builder: (context, snapshot) {
                              return Table(
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      Text(""),
                                      Text("Week 1", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 10), textAlign: TextAlign.center),
                                      Text("Week 2", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 10), textAlign: TextAlign.center),
                                      Text("Week 3", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 10), textAlign: TextAlign.center),
                                      Text("Week 4", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 10), textAlign: TextAlign.center),
                                      Text("Week 5", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 10), textAlign: TextAlign.center),
                                    ]
                                  ),
                                  TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("Keep", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("100%", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("75%", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("50%", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("25%", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Text("0%", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
                                      ),
                                    ]
                                  ),
                                  TableRow(
                                    children: [
                                      Text("Give Away", style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700)),
                                      Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 1), true, true), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                                      Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.75), true, true), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                                      Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.50), true, true), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                                      Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.25), true, true), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                                      Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0), true, true), textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                                    ]
                                  ),
                                ],                     
                              );
                            }
                          ),
                          SizedBox(height: 20),
                          Text("of you earnings", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: StreamBuilder(
            initialData: 0,
            stream: switchOutBloc.getAmount,
            builder: (context, AsyncSnapshot<num> snapshot) {
              return ButtonBottom(
                title: "Confirm Switch Out",
                onTap: snapshot.data > 0 ? () => switchOutBloc.confirmSwitchOut(context, widget.item.termDepositId):null,
              );
            }
          )
        ),
        StreamBuilder(
          initialData: false,
          stream: switchOutBloc.getLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}