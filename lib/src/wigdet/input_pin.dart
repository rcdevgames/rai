import 'package:flutter/material.dart';

class InputPins extends StatefulWidget {
  @override
  _InputPinsState createState() => _InputPinsState();
}

class _InputPinsState extends State<InputPins> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0),
      child:
          NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.height / (MediaQuery.of(context).size.width + 120),
          mainAxisSpacing: 30,
          padding: EdgeInsets.all(8),
          children: <Widget>[
            buildContainerCircle(1),
            buildContainerCircle(2),
            buildContainerCircle(3),
            buildContainerCircle(4),
            buildContainerCircle(5),
            buildContainerCircle(6),
            buildContainerCircle(7),
            buildContainerCircle(8),
            buildContainerCircle(9),
            buildRemoveIcon(Icons.close),
            buildContainerCircle(0),
            buildContainerIcon(Icons.backspace),
          ],
        ),
      ),
    );
  }
}

Widget buildContainerCircle(int number) {
    return InkResponse(
      highlightColor: Colors.grey,
      onTap: () {
        // _onCodeClick(number);
      },
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildRemoveIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 20,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Center(
          child: Text("forgot pin?"),
        ),
      )
    );
  }

  Widget buildContainerIcon(IconData icon) {
    return InkResponse(
      onTap: () {
        // if (0 < _currentCodeLength) {
        //   setState(() {
        //     circleColor = Colors.grey.shade300;
        //   });
        //   Future.delayed(Duration(milliseconds: 200)).then((func) {
        //     setState(() {
        //       circleColor = Colors.white;
        //     });
        //   });
        // }
        // _deleteCode();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            // color: circleColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }