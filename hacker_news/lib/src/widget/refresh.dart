import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  const Refresh({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
      child: child,
    );
  }
}
