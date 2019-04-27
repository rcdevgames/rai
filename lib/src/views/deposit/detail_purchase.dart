import 'package:RAI/src/views/deposit/bank_list.dart';
import 'package:RAI/src/wigdet/savewise_icons.dart';
import 'package:RAI/src/wigdet/separator.dart';
import 'package:flutter/material.dart';
import 'package:pigment/pigment.dart';

class DetailPurchasePage extends StatefulWidget {
  @override
  _DetailPurchasePageState createState() => _DetailPurchasePageState();
}

class _DetailPurchasePageState extends State<DetailPurchasePage> {
final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Make Deposit"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.help_outline, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
            Text("You are depositing", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25)),
                SizedBox(width: 5),
                Text("12.000", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
              ],
            ),
            SizedBox(height: 20),
            Text("@ 1.2% interest", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("starting 14 June 2019", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("maturing in 6 month time", style: TextStyle(fontSize: 16)),
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
            Text("On 14 Dec 2019, you will expect to get back", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("£", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25)),
                SizedBox(width: 5),
                Text("12.255", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.width / 3.3,
              width: MediaQuery.of(context).size.width / 2.3,
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
                      Text("12.255", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35))
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => BankListPage()
              )),
              title: Text("Choose Account", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ),
        )
      ),
    );
  }
}