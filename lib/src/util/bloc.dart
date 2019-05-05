import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProviders<T extends BlocBase> extends StatefulWidget {
  BlocProviders({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProvidersState<T> createState() => _BlocProvidersState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<BlocProviders<T>>();
    BlocProviders<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProvidersState<T> extends State<BlocProviders<BlocBase>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
