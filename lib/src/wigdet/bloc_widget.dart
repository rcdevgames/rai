import 'package:RAI/src/blocs/home/main_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final MainBloc bloc;

  BlocProvider({Key key, this.bloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bloc;
}