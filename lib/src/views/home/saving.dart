import 'package:RAI/src/models/savings.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/savings/exit_early.dart';
import 'package:RAI/src/views/savings/saving_detail.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/dialog.dart';
import 'package:RAI/src/wigdet/error_page.dart';
import 'package:RAI/src/wigdet/list_tile.dart';
import 'package:RAI/src/wigdet/loading.dart';
import 'package:RAI/src/wigdet/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class SavingPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final savingBloc = BlocProvider.of(context).savingBloc;
    savingBloc.fetchSaving(context, false);

    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height / 1080) * 150,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Table(
                  children: <TableRow>[
                    TableRow(children: <Widget>[
                      Center(
                          child: Text("Total Deposits",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                      Center(
                          child: Text("Total Interest Due",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                    ]),
                    TableRow(children: <Widget>[
                      Center(
                        child: StreamBuilder(
                            stream: savingBloc.getTotalSavings,
                            builder: (context, AsyncSnapshot<num> snapshot) {
                              return Text(snapshot.hasData ? formatMoney.format(snapshot.data, true) : "£ 0",
                                  style: TextStyle(color: Colors.white, fontSize: 30));
                            }),
                      ),
                      Center(
                        child: StreamBuilder(
                            stream: savingBloc.getTotalInterest,
                            builder: (context, AsyncSnapshot<num> snapshot) {
                              return Text(snapshot.hasData ? formatMoney.format(snapshot.data, true, true) : "£ 0.00",
                                  style: TextStyle(color: Colors.white, fontSize: 30));
                            }),
                      )
                    ])
                  ],
                ),
              ],
            )),
        Expanded(
          child: StreamBuilder(
              stream: savingBloc.getListSavings,
              builder: (context, AsyncSnapshot<List<Savings>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return LiquidPullToRefresh(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    key: _refreshIndicatorKey,
                    onRefresh: () => savingBloc.fetchSaving(context, true),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (ctx, i) {
                        return Column(
                          children: <Widget>[
                            SizedBox(height: i == 0 ? 20 : 0),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Slidable(
                                  actionExtentRatio: 0.25,
                                  delegate: new SlidableDrawerDelegate(),
                                  secondaryActions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 13, left: 5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: ItemsAction(
                                          caption: 'Explore Switch Out Options',
                                          color: Theme.of(context).primaryColor,
                                          onTap: () async {
                                            await Navigator.of(context).push(MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ExitEarlyPage(snapshot.data[i], savingBloc.businessDate)));
                                            var session = await sessions.flashMessage("switchout");
                                            print("session : $session");
                                            if (session != null) {
                                              savingBloc.updateListSavings(null);
                                              savingBloc.fetchSaving(context, true);
                                              dialogs.promptWithIcon(context, session, Icons.check_circle_outline,
                                                  () async {
                                                const url = 'mailto:smith@example.org?subject=News&body=New%20plugin';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  dialogs.alert(context, "", "Could not launch $url");
                                                }
                                              }, cancel: "Not Now", confirm: "Invite");
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                  child: ListTileDefault(
                                    leading: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/img/logo-scb.color.png",
                                          scale: 15,
                                        ),
                                        SizedBox(width: 5),
                                        Text(formatMoney.format(snapshot.data[i].quantity, true),
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                    child: Text("${(snapshot.data[i].rate / 100).toStringAsFixed(2)}%",
                                        style: TextStyle(fontSize: 18)),
                                    trailing: Text(formatMoney.format(snapshot.data[i].accruedInterest, true, true),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Theme.of(context).primaryColor)),
                                    isDefault: true,
                                    type: 3,
                                    progressBarValue: savingBloc.countPercentage(savingBloc.businessDate,
                                        snapshot.data[i].maturityDate, snapshot.data[i].startDate),
                                    dateTime: snapshot.data[i].maturityDate,
                                    exited: snapshot.data[i].exitEarlyRequests != null
                                        ? snapshot.data[i].exitEarlyRequests
                                            .where((v) => v.status == "Active")
                                            .toList()
                                            .length
                                        : 0,
                                    onTap: () async {
                                      var data = await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SavingDetailPage(snapshot.data[i], savingBloc.businessDate)));
                                      var session = await sessions.flashMessage("switchout");
                                      print("session : $session");
                                      print("Nav : $data");
                                      if (data == true) {
                                        savingBloc.updateListSavings(null);
                                        savingBloc.fetchSaving(context, true);
                                      } else if (session != null) {
                                        savingBloc.updateListSavings(null);
                                        savingBloc.fetchSaving(context, true);
                                        dialogs.promptWithIcon(context, session, Icons.check_circle_outline, () async {
                                          const url = 'mailto:smith@example.org?subject=News&body=New%20plugin';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            dialogs.alert(context, "", "Could not launch $url");
                                          }
                                        }, cancel: "Not Now", confirm: "Invite");
                                      }
                                    },
                                  ),
                                ))
                          ],
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data.length < 1) {
                  return LiquidPullToRefresh(
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                    key: _refreshIndicatorKey,
                    onRefresh: () {
                      savingBloc.updateListSavings(null);
                      savingBloc.fetchSaving(context, true);
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text("Your deposits will show here",
                                style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor)),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: ErrorPage(
                      message: snapshot.error,
                      buttonText: "Try Again",
                      onPressed: () {
                        savingBloc.updateListSavings(null);
                        savingBloc.fetchSaving(context, true);
                      },
                    ),
                  );
                }
                return LoadingBlock(Theme.of(context).primaryColor);
              }),
        )
      ],
    );
  }
}
