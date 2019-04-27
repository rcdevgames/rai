import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const bool _kCloseOnTap = true;
class ItemsAction extends ClosableSlideAction {
  const ItemsAction({
    Key key,
    this.caption,
    Color color,
    this.foregroundColor,
    VoidCallback onTap,
    bool closeOnTap = _kCloseOnTap,
  })  : color = color ?? Colors.white,
        super(
          key: key,
          onTap: onTap,
          closeOnTap: closeOnTap,
        );

  final String caption;
  final Color color;
  final Color foregroundColor;

  @override
  Widget buildAction(BuildContext context) {
    final Color estimatedColor =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light
            ? Colors.black
            : Colors.white;
    return Container(
      color: color,
      child: Center(
        child: Text(
          caption ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .primaryTextTheme
              .caption
              .copyWith(color: foregroundColor ?? estimatedColor),
        ),
      ),
    );
  }
}