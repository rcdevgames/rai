import 'package:RAI/src/blocs/saving/detail_bloc.dart';
import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/views/savings/exit_early.dart';
import 'package:RAI/src/wigdet/button.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pigment/pigment.dart';

class SavingDetailPage extends StatefulWidget {
  Savings item;
  DateTime businessDate;
  SavingDetailPage(this.item, this.businessDate);

  @override
  _SavingDetailPageState createState() => _SavingDetailPageState();
}

class _SavingDetailPageState extends State<SavingDetailPage> {
  final _key = GlobalKey<ScaffoldState>();
  DetailSavingBloc detailSavingBloc;
  List<ExitEarlyRequest> mySwitchOut = [];

  @override
  void initState() {
    detailSavingBloc = new DetailSavingBloc();
    resort();
    super.initState();
  }

  @override
  void dispose() {
    detailSavingBloc?.dispose();
    super.dispose();
  }

  resort() async {
    List<ExitEarlyRequest> active = [], deactive = [];
    if (widget.item.exitEarlyRequests != null && widget.item.exitEarlyRequests.length > 0) {
      widget.item.exitEarlyRequests.forEach((v) {
        if(v.status == "Active") {
          active.add(v);
        }else{
          deactive.add(v);
        }
      });
    }
    mySwitchOut.addAll(active);
    mySwitchOut.addAll(deactive);
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> contents = {
      0: ListView.builder(
        itemCount: widget.item.history.length,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Text(formatDate(widget.item.history[i].eventTime, [dd,' ',M,' ',yyyy]), style: TextStyle(fontSize: 13))
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(widget.item.history[i].description, style: TextStyle(fontSize: 13)),
                  )
                ],
              ),
            ),
          );
        },
      ),
      1: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: Text("Amount", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor))
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text("Give Away", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor))
              ),
              Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor)))
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: mySwitchOut.length > 0 ? ListView.builder(
                itemCount: mySwitchOut.length,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                              child: Text(formatMoney.format(mySwitchOut[i].quantity, true))
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Text(formatMoney.format(mySwitchOut[i].transferredInterest, true, true))
                            ),
                            Expanded(child: Text(mySwitchOut[i].status == 'Active' ? "${mySwitchOut[i].status} (${mySwitchOut[i].expiredDate.difference(widget.businessDate).inDays} Days Left)":"${mySwitchOut[i].status}", style: TextStyle(fontWeight: FontWeight.w700, color: mySwitchOut[i].status == 'Active' ? Pigment.fromString("##69be28") : Theme.of(context).primaryColor)))
                          ],
                        ),
                        mySwitchOut[i].status == 'Active' ? RaisedButton(
                          onPressed: () => detailSavingBloc.exitEarly(context, mySwitchOut[i].requestId),
                          elevation: 0,
                          color: Pigment.fromString("#FAFAFA"),
                          child: Text("Cancel Switch Out"),
                        ):Container()
                      ],
                    ),
                  );
                },
              ):Column(
                children: <Widget>[
                  Text("Data not found")
                ],
              ),
            ),
          )
        ],
      )
    };

    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text("Savings Detail", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/help'),
                icon: Icon(Icons.help_outline, color: Colors.white),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(13, 20, 13, 10),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Image.asset("assets/img/logo-scb.color.png")
                        ),
                        SizedBox(width: 5),
                        Text("Standard Chartered Bank", style: TextStyle(fontSize: 13))
                      ],
                    ),
                    Table(
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Text("Deposit", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(left: BorderSide(), right: BorderSide())
                              ),
                              child: Text("Interest", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center)
                            ),
                            Text("Earned", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                          ]
                        ),
                        TableRow(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 5),
                              child: Text(formatMoney.format(widget.item.quantity, true), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 5),
                              decoration: BoxDecoration(
                                border: Border(left: BorderSide(), right: BorderSide())
                              ),
                              child: Text("${(widget.item.rate/100).toStringAsFixed(2)}%", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 5),
                              child: Text(formatMoney.format(widget.item.accruedInterest, true, true), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColor), textAlign: TextAlign.center),
                            )
                          ]
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FittedBox(
                        child: LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width,
                          lineHeight: 27,
                          percent: detailSavingBloc.countPercentage(widget.businessDate, widget.item.maturityDate) > 0 ? detailSavingBloc.countPercentage(widget.businessDate, widget.item.maturityDate):1.0,
                          progressColor: Pigment.fromString("#69be28"),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Text("${widget.item.maturityDate.difference(widget.businessDate).inDays} days left till maturity on ${formatDate(widget.item.maturityDate, [dd, ' ', M, ' ', yyyy])}", style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
              StreamBuilder(
                initialData: 0,
                stream: detailSavingBloc.getIndex,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return CupertinoSegmentedControl(
                    pressedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderColor: Colors.transparent,
                    unselectedColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    onValueChanged: (v) => detailSavingBloc.updateIndex(v),
                    groupValue: snapshot.data,
                    children: {
                      0: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: snapshot.data == 0 ? Theme.of(context).primaryColor:Colors.grey),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))
                        ),
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("HISTORY", style: TextStyle(color: snapshot.data == 0 ? Theme.of(context).primaryColor:Colors.grey, fontWeight: FontWeight.w700)))
                      ),
                      1: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: snapshot.data == 1 ? Theme.of(context).primaryColor:Colors.grey),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                        ),
                        height: 44,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("MY SWITCH OUT", style: TextStyle(color: snapshot.data == 1 ? Theme.of(context).primaryColor:Colors.grey, fontWeight: FontWeight.w700)))
                      )
                    },
                  );
                }
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(13, 10, 13, 0),
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor.withOpacity(0.05)
                  ),
                  child: StreamBuilder(
                    initialData: 0,
                    stream: detailSavingBloc.getIndex,
                    builder: (context, AsyncSnapshot<int> snapshot) {
                      return contents[snapshot.data];
                    }
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: ButtonBottom(
            icon: null,
            title: "EXPLORE SWITCH OUT OPTIONS",
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => ExitEarlyPage(widget.item, widget.businessDate)
            )),
          ),
        ),
        StreamBuilder(
          initialData: false,
          stream: detailSavingBloc.getLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}