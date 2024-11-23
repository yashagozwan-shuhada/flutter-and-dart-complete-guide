import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';

class Provider extends InheritedWidget {
  Provider({
    required super.child,
    super.key,
  });

  final LoginBloc bloc = LoginBloc();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    final bloc = context.dependOnInheritedWidgetOfExactType<Provider>()?.bloc;
    assert(bloc != null, 'Bloc null');
    return bloc!;
  }
}
