import 'package:flutter/material.dart';

class InputPin extends StatefulWidget {
  final Function onBackPressed, onPressedKey;
  final VoidCallback onForgotPassword;
  final TextStyle textStyle;
  InputPin({
    this.onBackPressed,
    this.onPressedKey,
    this.onForgotPassword,
    this.textStyle,
  });

  InputPinState createState() => InputPinState();
}

class InputPinState extends State<InputPin> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "1",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("1"),
                child: Text("1", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("2"),
                child: Text("2", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "3",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("3"),
                child: Text("3", style: widget.textStyle),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "4",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("4"),
                child: Text("4", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "5",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("5"),
                child: Text("5", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "6",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("6"),
                child: Text("6", style: widget.textStyle),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "7",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("7"),
                child: Text("7", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "8",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("8"),
                child: Text("8", style: widget.textStyle),
              ),
              FloatingActionButton(
                heroTag: "9",
                backgroundColor: Colors.transparent,
                elevation: 0,
                onPressed: () => widget.onPressedKey("9"),
                child: Text("9", style: widget.textStyle),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: SizedBox(
                  width: 120,
                  height: 30,
                  child: RaisedButton(
                    color: Colors.grey,
                    onPressed: widget.onForgotPassword,
                    child: Text("forgot pin?", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: FloatingActionButton(
                  heroTag: "0",
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () => widget.onPressedKey("0"),
                  child: Text("0", style: widget.textStyle),
                ),
              ),
              Expanded(
                child: FloatingActionButton(
                  heroTag: "backSpace",
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: widget.onBackPressed,
                  child: Icon(
                    Icons.backspace,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}