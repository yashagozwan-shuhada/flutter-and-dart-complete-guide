import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/model/item_model.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({
    required this.id,
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stories Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Loading...');
        }

        final itemFuture = snapshot.data![id];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Item Loading...');
            }

            return buildTitle(snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Text('${item.title}');
  }
}
