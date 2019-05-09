import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  bool show = false;

  Loading(this.show);

  @override
  Widget build(BuildContext context) {
    return Positioned(
    child: show
    ? Container(
        child: Center(
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: new BorderRadius.all(
                new Radius.circular(15.0)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Text("Processing...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.0))
              ],
            ),
          ),
        ),
        color: Colors.white.withOpacity(0.8),
      )
    : Container());
  }
}

class LoadingBlock extends StatelessWidget {
  Color colors;
  LoadingBlock(this.colors);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(colors),
      ),
    );
  }
}