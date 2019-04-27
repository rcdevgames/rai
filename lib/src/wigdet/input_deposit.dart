import 'package:flutter/material.dart';


class InputDeposit extends StatelessWidget {
  TextEditingController inputController;
  Function increaseValue;
  Function decreaseValue;
  ValueChanged<String> onValueChange;
  InputDeposit({Key key, @required this.inputController, @required this.increaseValue, @required this.decreaseValue, @required this.onValueChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => decreaseValue(),
            iconSize: 35,
            icon: Icon(Icons.remove_circle),
          ),
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
          IconButton(
            onPressed: () => increaseValue(),
            iconSize: 35,
            icon: Icon(Icons.add_circle),
          ),
        ],
      ),
    );
  }
}