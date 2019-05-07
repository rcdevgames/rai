import 'package:RAI/src/blocs/saving/switchout_bloc.dart';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
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
            title: Text("Saving Detail"),
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
                  child: Text("How much would you like back from?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Theme.of(context).primaryColor), textAlign: TextAlign.center,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(25, 20, 25, 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  height: MediaQuery.of(context).size.height / 5.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.asset("assets/img/logo-scb.color.png")
                          ),
                          SizedBox(width: 10),
                          Text("Standard Chartered Bank", style: TextStyle(fontSize: 16))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: StreamBuilder(
                          initialData: 0,
                          stream: switchOutBloc.getAmount,
                          builder: (context, AsyncSnapshot<num> snapshot) {
                            return Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("Deposit", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                                    Text(formatMoney.format(!snapshot.hasError ? snapshot.data:0, true), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor))
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width / 1080) * 40),
                                    decoration: BoxDecoration(
                                      border: Border(left: BorderSide(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)), right: BorderSide(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Rate", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                                        Text("${(widget.item.rate/100).toStringAsFixed(2)} %", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text("Interest Due", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                                    Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 1), true), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)),
                                  ],
                                )
                              ],
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                InputDeposit(
                  inputController: switchOutBloc.ctrlAmount,
                  increaseValue: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    switchOutBloc.addValue();
                  },
                  decreaseValue: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    switchOutBloc.removeValue();
                  },
                  onValueChange: switchOutBloc.onChange,
                ),
                Expanded(
                  child: FlipCard(
                    direction: FlipDirection.VERTICAL,
                    front: Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Switching out may reduce the amount of interest you receive. The exact amount depends on when you switch out.", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: (MediaQuery.of(context).size.width / 1080) * 55, wordSpacing: 3), textAlign: TextAlign.center),
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
                      margin: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("As you try to switch out, you will", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17)),
                          SizedBox(height: 20),
                          Expanded(
                            child: StreamBuilder(
                              initialData: 0,
                              stream: switchOutBloc.getAmount,
                              builder: (context, snapshot) {
                                return Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(
                                      children: [
                                        Text(""),
                                        Text("Week 1", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                        Text("Week 2", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                        Text("Week 3", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                        Text("Week 4", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                        Text("Week 5", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("Keep"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("100%", textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("75%", textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("50%", textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("25%", textAlign: TextAlign.center),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: Text("0%", textAlign: TextAlign.center),
                                        ),
                                      ]
                                    ),
                                    TableRow(
                                      children: [
                                        Text("Give Away"),
                                        Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 1), true), textAlign: TextAlign.center),
                                        Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.75), true), textAlign: TextAlign.center),
                                        Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.50), true), textAlign: TextAlign.center),
                                        Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0.25), true), textAlign: TextAlign.center),
                                        Text(formatMoney.format(switchOutBloc.earning(widget.item.accruedInterest, 0), true), textAlign: TextAlign.center),
                                      ]
                                    ),
                                  ],                     
                                );
                              }
                            ),
                          ),
                          Text("of you earnings", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 17)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Pigment.fromString("FAFAFA")
              ),
              child: StreamBuilder(
                initialData: 0,
                stream: switchOutBloc.getAmount,
                builder: (context, AsyncSnapshot<num> snapshot) {
                  return RaisedButton.icon(
                    onPressed: snapshot.data > 0 ? () => switchOutBloc.confirmSwitchOut(context, widget.item.termDepositId):null,
                    color: Theme.of(context).primaryColor,
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Text("Confirm Switch Out", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                    ),
                    label: Icon(Icons.arrow_forward_ios, color: Colors.white),
                  );
                }
              ),
            )
          ),
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