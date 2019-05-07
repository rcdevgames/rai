import 'package:RAI/src/models/bank.dart';
import 'package:RAI/src/util/format_money.dart';
import 'package:RAI/src/wigdet/keyboard_pin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pigment/pigment.dart';

class TransactionModal {

  purchaseModal(BuildContext context, Bank bankData, num amount) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2.7,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("BANK TRANSFER", style: TextStyle(fontWeight: FontWeight.w600)),
                    FlatButton(
                      child: Text("Cancel", style: TextStyle(color: Colors.blue)),
                    )
                  ],
                ),
              ),
              Divider(color: Theme.of(context).primaryColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("From ${bankData.bankName}"),
                        Text("Account ${bankData.bankAcctNo}"),
                      ],
                    ),
                    Text(formatMoney.format(amount, true), style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.asset("assets/img/touchid.png"),
                ),
              ),
              Text("CONFIRM WITH TOUCH ID"),
              SizedBox(height: 10)
            ],
          )
        );
      }
    );
  }

  confirmPIN(GlobalKey<ScaffoldState> key) {
    Widget smallCircle = new Container(
      width: 12.0,
      height: 12.0,
      decoration: new BoxDecoration(
        color: Pigment.fromString("a2dbef"),
        shape: BoxShape.circle,
      ),
    );

    Widget bigCircle = new Container(
      width: 17.0,
      height: 17.0,
      decoration: new BoxDecoration(
        color: Pigment.fromString("002244"),
        shape: BoxShape.circle,
      ),
    );

    key.currentState.showBottomSheet((context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height + 221,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 50),
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset('assets/svg/savewise-logo.svg'),
              ),
            ),
            SizedBox(height: 20),
            Text("OneUp.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
            SizedBox(height: 50),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width / 2.2,
              child: StreamBuilder(
                initialData: "",
                stream: null,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      snapshot.data.length > 0 ? bigCircle : smallCircle,
                      snapshot.data.length > 1 ? bigCircle : smallCircle,
                      snapshot.data.length > 2 ? bigCircle : smallCircle,
                      snapshot.data.length > 3 ? bigCircle : smallCircle,
                      snapshot.data.length > 4 ? bigCircle : smallCircle,
                      snapshot.data.length > 5 ? bigCircle : smallCircle,
                    ],
                  );
                }
              ),
            ),
            Expanded(
              child: InputPin(
                textStyle: TextStyle(color: Colors.black, fontSize: 45.0, fontWeight: FontWeight.w500),
                onBackPressed: () {},
                onPressedKey: (String code) => print(code),
                onForgotPassword: () {},
              ),
            )
          ],
        ),
      );
    });
  }
}
final transactionModal = new TransactionModal();