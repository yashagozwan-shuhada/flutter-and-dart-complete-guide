import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  const CommentsProvider({
    required super.child,
    required this.bloc,
    super.key,
  });

  final CommentsBloc bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static CommentsBloc of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<CommentsProvider>();

    assert(provider != null, 'CommentsBloc not registered');

    return provider!.bloc;
  }
}
