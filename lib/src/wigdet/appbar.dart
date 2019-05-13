import 'package:flutter/material.dart';

class OneupBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool withHelp;
  OneupBar(this.title, [this.withHelp = false]);

  final preferredSize = new Size.fromHeight(55.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      leading: IconButton(
        icon: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 15)),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Theme.of(context).primaryColor)),
      actions: <Widget>[
        withHelp ? IconButton(
          onPressed: () => Navigator.of(context).pushNamed('/help'),
          icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor),
        ):null,
      ].where((v) => v != null).toList(),
    );
  }
}