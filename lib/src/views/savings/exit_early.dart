import 'dart:async';

import 'package:RAI/src/blocs/saving/switchout_bloc.dart';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/wigdet/appbar.dart';
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
            appBar: OneupBar("Switch Out", true),
            body: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "How much would you like back from?",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    height: MediaQuery.of(context).size.height / 6.3,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(6)),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: 22, height: 22, child: Image.asset("assets/img/logo-scb.color.png")),
                            SizedBox(width: 5),
                            Text("Standard Chartered Bank", style: TextStyle(fontSize: 13))
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: Table(
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Text("Deposit",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.center),
                                Container(
                                    decoration: BoxDecoration(border: Border(left: BorderSide(), right: BorderSide())),
                                    child: Text("Interest",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).primaryColor),
                                        textAlign: TextAlign.center)),
                                Text("Earned",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.center),
                              ]),
                              TableRow(children: <Widget>[
                                StreamBuilder(
                                    initialData: 0,
                                    stream: switchOutBloc.getOldAmount,
                                    builder: (context, AsyncSnapshot<num> snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                                        child: Text(formatMoney.format(!snapshot.hasError ? snapshot.data : 0, true),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).primaryColor),
                                            textAlign: TextAlign.center),
                                      );
                                    }),
                                Container(
                                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                                    decoration: BoxDecoration(border: Border(left: BorderSide(), right: BorderSide())),
                                    child: Text("${(widget.item.rate / 100).toStringAsFixed(2)}%",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Theme.of(context).primaryColor),
                                        textAlign: TextAlign.center)),
                                StreamBuilder(
                                    initialData: 0,
                                    stream: switchOutBloc.getOldAmount,
                                    builder: (context, AsyncSnapshot<num> snapshot) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                                        child: Text(
                                            formatMoney.format(
                                                switchOutBloc.earning(widget.item.accruedInterest, 1, snapshot.data),
                                                true,
                                                true),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context).primaryColor),
                                            textAlign: TextAlign.center),
                                      );
                                    })
                              ])
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
                                increaseValue:
                                    (snapshot.hasData && snapshot.data > switchOutBloc.ctrlAmount.numberValue)
                                        ? () {
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            switchOutBloc.addValue();
                                          }
                                        : null,
                                decreaseValue: switchOutBloc.ctrlAmount.numberValue > 100
                                    ? () {
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        switchOutBloc.removeValue();
                                      }
                                    : null,
                                onValueChange: switchOutBloc.onChange,
                                decreaseLongPress: () {
                                  timer = new Timer(const Duration(milliseconds: 10), () {
                                    timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                                      if (switchOutBloc.ctrlAmount.numberValue > 100) switchOutBloc.removeValue();
                                    });
                                  });
                                },
                                increaseLongPress: () {
                                  timer = new Timer(const Duration(milliseconds: 10), () {
                                    timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                                      if (snapshot.hasData &&
                                          switchOutBloc.ctrlAmount.numberValue < snapshot.data != null)
                                        switchOutBloc.addValue();
                                    });
                                  });
                                },
                                increaseLongPressUp: () => timer.cancel(),
                                decreaseLongPressUp: () => timer.cancel(),
                              );
                            }),
                  ),
                  Expanded(
                    child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      front: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                            color: Pigment.fromString("#f6fbff"), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StreamBuilder(
                                stream: switchOutBloc.getAmount,
                                builder: (context, AsyncSnapshot<num> snapshot) {
                                  // DefaultTextStyle.of(context).style,
                                  return RichText(
                                    text: TextSpan(
                                      text: 'Switching Out may cost you up to',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w300,
                                          fontSize: (MediaQuery.of(context).size.width / 1080) * 40,
                                          wordSpacing: 3,
                                          height: 1.5),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: formatMoney.format(
                                              switchOutBloc.earning(widget.item.accruedInterest, 1), true, true),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text:
                                                ' of your accrued interest. The exact amount you give up depends on when your Switch Out completes.'),
                                      ],
                                    ),
                                  );
                                }),
                            RaisedButton(
                              onPressed: () {},
                              color: Colors.white,
                              elevation: 0,
                              child: Text("Know more >",
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      ),
                      back: Container(
                        padding: EdgeInsets.all(16),
//                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                            color: Pigment.fromString("#f6fbff"), borderRadius: BorderRadius.circular(10)),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Amount of time after Switch Out confirmation that new customer takes on your deposit. Percentage of accrued interest you are entitled to",
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13)),
                              SizedBox(height: 10),
                              StreamBuilder(
                                  initialData: 0,
                                  stream: switchOutBloc.getAmount,
                                  builder: (context, snapshot) {
                                    return Table(
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: <TableRow>[
                                        TableRow(
                                          children: [
                                            Text("Within 1 Week",
                                                style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            Padding(
                                                padding: const EdgeInsets.only(bottom: 4),
                                                child: Text(">95%\n(the Week 1 entitlement)",
                                                    style: TextStyle(fontSize: 12), textAlign: TextAlign.left)),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text("Within 2 Weeks",
                                                style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Text("70-75%\n(the Week 2 entitlement)",
                                                  style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text("Within 3 Weeks",
                                                style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Text("45-50%\n(the Week 3 entitlement)",
                                                  style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text("Within 4 Weeks",
                                                style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              child: Text("20-25%\n(the Week 4 entitlement)",
                                                  style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                            ),
                                          ],
                                        ),
                                        TableRow(children: [
                                          Text("No acceptance after\n30 days",
                                              style: TextStyle(fontSize: 12), textAlign: TextAlign.left),
                                          Text(
                                              "The amount you would have received on your deposit at the High Street Interest Rate",
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.left),
                                        ]),
                                      ],
                                    );
                                  }),
                            ],
                          ),
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
                    onTap: snapshot.data > 0 && switchOutBloc.ctrlAmount.numberValue > 0
                        ? () => switchOutBloc.confirmSwitchOut(context, widget.item.termDepositId)
                        : null,
                  );
                })),
        StreamBuilder(
            initialData: false,
            stream: switchOutBloc.getLoading,
            builder: (context, snapshot) {
              return Loading(snapshot.data);
            })
      ],
    );
  }
}
