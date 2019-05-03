import 'dart:async';

import 'package:flutter/material.dart';


class InputDeposit extends StatelessWidget {
  TextEditingController inputController;
  Function increaseValue;
  Function decreaseValue;
  ValueChanged<String> onValueChange;
  InputDeposit({Key key, @required this.inputController, @required this.increaseValue, @required this.decreaseValue, @required this.onValueChange}) : super(key: key);

  var timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onLongPress: () {
                timer = new Timer(const Duration(milliseconds: 10), () {
                  timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                    decreaseValue();
                  });
                });
              },
              onLongPressUp: () {
                timer.cancel();
              },
              onTap: () => decreaseValue(),
              child: Icon(Icons.remove_circle, size: 35, color: Theme.of(context).primaryColor),
            ),
          ),
          // IconButton(
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () => decreaseValue(),
          //   iconSize: 35,
          //   icon: Icon(Icons.remove_circle),
          // ),
          Expanded(
            child: TextField(
              controller: inputController,
              decoration: InputDecoration(
                prefixText: "£",
                prefixStyle: TextStyle(fontSize: 25),
                border: InputBorder.none
              ),
              style: TextStyle(fontSize: 35),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: onValueChange,
              onEditingComplete: () {
                print('Complete');
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onLongPress: () {
                timer = new Timer(const Duration(milliseconds: 10), () {
                  timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
                    increaseValue();
                  });
                });
              },
              onLongPressUp: () {
                timer.cancel();
              },
              onTap: () => increaseValue(),
              child: Icon(Icons.add_circle, size: 35, color: Theme.of(context).primaryColor),
            ),
          ),
          // IconButton(
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () => increaseValue(),
          //   iconSize: 35,
          //   icon: Icon(Icons.add_circle),
          // ),
        ],
      ),
    );
  }
}