import 'package:RAI/src/models/deposit_match.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/util/session.dart';
import 'package:RAI/src/views/deposit/bank_list.dart';
import 'package:RAI/src/wigdet/bloc_widget.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:RAI/src/wigdet/separator.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class DetailPurchasePage extends StatefulWidget {
  DepositMatch depositMatch;
  DetailPurchasePage(this.depositMatch);

  @override
  _DetailPurchasePageState createState() => _DetailPurchasePageState();
}

class _DetailPurchasePageState extends State<DetailPurchasePage> {
  final _key = GlobalKey<ScaffoldState>();
  DateTime businessDate = new DateTime.now();

  @override
  void initState() {
    sessions.load('businessDate').then((date) => businessDate = DateTime.parse(date));
    print(widget.depositMatch.toJson());
    super.initState();
  }

  @override
  void dispose() {
    print('Detail dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
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
            Text("You are depositing", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25)),
                SizedBox(width: 5),
                Text(formatMoney.format(widget.depositMatch.amount), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
              ],
            ),
            SizedBox(height: 20),
            Text("@ ${(widget.depositMatch.rate/100).toStringAsFixed(2)}% gross interest per year", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text("maturing in ${(widget.depositMatch.maturityDate.difference(businessDate).inDays/30).toStringAsFixed(0)} month time", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 20),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.green
                  ),
                  child: Icon(Savewise.arrow_down, color: Colors.white, size: 35),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6.5,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: DotSeparator(color: Colors.grey)
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("On ${formatDate(widget.depositMatch.maturityDate, [dd,' ',M,' ',yyyy]).toString()}, you will get back", style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25)),
                SizedBox(width: 5),
                Text(formatMoney.format(widget.depositMatch.amount + widget.depositMatch.interest), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.width / 5,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Pigment.fromString("F6FBFF"),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Expected Interest"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25)),
                      SizedBox(width: 5),
                      Text(formatMoney.format(widget.depositMatch.interest), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Ink(
              height: MediaQuery.of(context).size.width / 8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.info_outline),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Text("Don/'t sweat it! Get back your principle at anytime, if you need your money back urgently.")
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Pigment.fromString("FAFAFA")
          ),
          child: RaisedButton.icon(
            // onPressed: () {
            //   Navigator.popUntil(context, ModalRoute.withName('/main'));
            // },
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => BankListPage(widget.depositMatch)
            )),
            color: Theme.of(context).primaryColor,
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text("Choose Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
            ),
            label: Icon(Icons.arrow_forward_ios, color: Colors.white),
          ),
        )
      ),
    );
  }
}