import 'package:flutter/material.dart';


class InputDeposit extends StatelessWidget {
  double width;
  double height;
  TextEditingController inputController;
  Function increaseValue;
  Function decreaseValue;
  Function increaseLongPress;
  Function decreaseLongPress;
  Function increaseLongPressUp;
  Function decreaseLongPressUp;
  ValueChanged<String> onValueChange;
  InputDeposit({Key key, @required this.inputController, @required this.increaseValue, @required this.decreaseValue, @required this.onValueChange, this.width, this.height, this.decreaseLongPress, this.increaseLongPress, this.increaseLongPressUp, this.decreaseLongPressUp}) : super(key: key);

  // var timer;

  @override
  Widget build(BuildContext context) {
    // print(timer);
    return Container(
      width: width == null ? MediaQuery.of(context).size.width / 1.3 : width.toDouble(),
      height: height == null ? 60 : height.toDouble(),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 1, color: Theme.of(context).primaryColor.withOpacity(0.3))
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onLongPress: decreaseLongPress,
              // () {
              //   timer = new Timer(const Duration(milliseconds: 10), () {
              //     timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
              //       if(decrease != null) decreaseValue();
              //     });
              //   });
              // },
              onLongPressUp: decreaseLongPressUp,
              // () {
              //   timer.cancel();
              // },
              onTap: decreaseValue != null ? () => decreaseValue():null,
              child: Icon(Icons.remove_circle, size: 25, color: decreaseValue != null ? Theme.of(context).primaryColor:Colors.grey),
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
                // prefixText: "£",
                // prefixStyle: TextStyle(fontSize: 25),
                border: InputBorder.none
              ),
              style: TextStyle(fontSize: 28),
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
              onLongPress: increaseLongPress,
              // () {
              //   timer = new Timer(const Duration(milliseconds: 10), () {
              //     timer = new Timer.periodic(const Duration(milliseconds: 250), (i) {
              //       if(increaseValue != null) increaseValue();
              //     });
              //   });
              // },
              onLongPressUp: increaseLongPressUp,
              // () {
              //   timer.cancel();
              // },
              onTap: increaseValue != null ? () => increaseValue():null,
              child: Icon(Icons.add_circle, size: 25, color: increaseValue != null ? Theme.of(context).primaryColor:Colors.grey),
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