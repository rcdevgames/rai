import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/deposit/bank_list.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/button.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:RAI/src/wigdet/separator.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class DetailPurchasePage extends StatefulWidget {
  num amount;
  DepositMatch depositMatch;
  DetailPurchasePage(this.depositMatch, this.amount);

  @override
  _DetailPurchasePageState createState() => _DetailPurchasePageState();
}

class _DetailPurchasePageState extends State<DetailPurchasePage> {
  final _key = GlobalKey<ScaffoldState>();
  DateTime businessDate = new DateTime.now();

  @override
  void initState() {
    sessions.load('businessDate').then((date) => businessDate = DateTime.parse(date));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/img/logo-scb.color.png", scale: 15),
                SizedBox(width: 5),
                Text("Standard Chartered Bank")
              ],
            ),
            SizedBox(height: 10),
            Text("You are depositing", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 23)),
                ),
                SizedBox(width: 5),
                Text(formatMoney.format(widget.amount), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
              ],
            ),
            SizedBox(height: 20),
            Text("@ ${(widget.depositMatch.rate/100).toStringAsFixed(2)}% gross interest per year", style: TextStyle(fontSize: 14), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text("maturing in ${(widget.depositMatch.maturityDate.difference(businessDate).inDays/30).toStringAsFixed(0)} months", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.green
                  ),
                  child: Center(child: Icon(Savewise.arrow_down, color: Colors.white, size: 22)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: DotSeparator(color: Colors.grey)
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("On ${formatDate(widget.depositMatch.maturityDate, [dd,' ',M,' ',yyyy]).toString()}, you will get back", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 23)),
                ),
                SizedBox(width: 5),
                Text(formatMoney.format(widget.amount + widget.depositMatch.interest, null, true), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35), textAlign: TextAlign.center),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.width / 4,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Pigment.fromString("F6FBFF"),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Including gross interest of", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16), textAlign: TextAlign.center),
                  SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 23)),
                      ),
                      SizedBox(width: 5),
                      Text(formatMoney.format(widget.depositMatch.interest, null, true), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.width / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.info_outline),
                  SizedBox(width: 5),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.45,
                    child: Text("Need some money back early? Explore out Switch Out options.", style: TextStyle(fontSize: 10))
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonBottom(
        title: "CONFIRM DEPOSIT",
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => BankListPage(widget.depositMatch)
        )),
      )
    );
  }
}