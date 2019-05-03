import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pigment/pigment.dart';


class ListTileDefault extends StatelessWidget {
  Widget leading;
  Widget child;
  Widget trailing;
  DateTime dateTime;
  double progressBarValue;
  bool isDefault;
  bool isSelected;
  int type;
  int exited;
  GestureTapCallback onTap;

  ListTileDefault({Key key, this.leading, this.child, this.trailing, this.progressBarValue, this.isDefault = false, this.onTap, this.dateTime, this.exited, this.type = 1, this.isSelected = false}):super(key:key);


  // Type
  // 1 = Best Rate
  // 2 = Default
  // 3 = Exit Early Count
  // 4 = Selected

  Widget labelDepositDefault() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Pigment.fromString("FAFAFA")
            ),
            child: Text("${DateFormat('EEEE').format(dateTime)} ${formatDate(dateTime, [dd, ' ', M, ' ', yyyy]).toString()}")
          ),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.star, size: 20, color: Colors.white),
                Text("Best Rate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget labelDeposit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Pigment.fromString("FAFAFA")
            ),
            child: Text("${DateFormat('EEEE').format(dateTime)} ${formatDate(dateTime, [dd, ' ', M, ' ', yyyy]).toString()}")
          ),
          Container(
            height: 30,
            width: 100,
          )
        ],
      ),
    );
  }

  Widget labelDefault(BuildContext context) {
    return Positioned(
      right: (MediaQuery.of(context).size.width / 1080) * 35,
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.check, size: 20, color: Colors.white),
            Text("Default", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    );
  }

  Widget labelExitEarly() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Pigment.fromString("FAFAFA")
            ),
            child: Text("${DateFormat('EEEE').format(dateTime)} ${formatDate(dateTime, [dd, ' ', M, ' ', yyyy]).toString()}")
          ),
          Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(Icons.star, size: 20, color: Colors.white),
                Text("Best Rate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget labelSelected(BuildContext context) {
    return Positioned(
      right: (MediaQuery.of(context).size.width / 1080) * 55,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Center(child: Icon(Icons.check, size: 20, color: Colors.white)),
      ),
    );
  }

  Widget label(BuildContext context, int i) {
    switch (i) {
      case 2:
        return labelDefault(context);
        break;
      case 3:
        return labelExitEarly();
        break;
      case 4:
        return labelSelected(context);
        break;
      case 5:
        return labelDeposit();
        break;
      default:
        return labelDepositDefault();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          height: 105,
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 1,
                width: MediaQuery.of(context).size.width - 40,
                child: GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: isSelected ? Border.all(width: 2.5, color: Theme.of(context).primaryColor) : Border.all(width: 2, color: Colors.black26)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        leading,
                        child,
                        trailing
                      ],
                    )
                  )
                ),
              ),

              isDefault == true ? label(context, type):Container()
            ],
          ),
        ),
      ],
    );
  }
}