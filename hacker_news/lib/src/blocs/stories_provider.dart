import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  const StoriesProvider({
    required super.child,
    required this.bloc,
    super.key,
  });

  final StoriesBloc bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBloc of(BuildContext context) {
    final bloc =
        context.dependOnInheritedWidgetOfExactType<StoriesProvider>()?.bloc;

    assert(bloc != null, 'No StoriesBloc found in context');

    return bloc!;
  }
}
