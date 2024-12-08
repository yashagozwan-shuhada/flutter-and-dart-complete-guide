import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_bloc.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/widget/news_list_tile.dart';
import 'package:hacker_news/src/widget/refresh.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    unawaited(bloc.fetchTopIds());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tops News'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder<List<int>>(
      stream: bloc.topIds,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemBuilder: (context, index) {
              bloc.getItem(snapshot.data![index]);

              return NewsListTile(id: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          ),
        );
      },
    );
  }

  Future<String> getFuture() async {
    return Future.delayed(
      const Duration(milliseconds: 2000),
      () => 'Hi, There!',
    );
  }
}
