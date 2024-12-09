import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/widget/comment_widget.dart';

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
          builder: (context, itemSnapshot) {
            if (!snapshot.hasData) {
              return const Text('Item Loading...');
            }

            if (itemSnapshot.data != null && snapshot.data != null) {
              return buildList(
                itemSnapshot.data!,
                snapshot.data!,
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget buildList(
    ItemModel item,
    Map<int, Future<ItemModel>> itemMap,
  ) {
    if (item.kids == null) return const SizedBox.shrink();

    final comments = item.kids!
        .map(
          (kidId) => CommentWidget(
            itemId: kidId,
            itemMap: itemMap,
            depth: 0,
          ),
        )
        .toList();

    return ListView(
      children: [
        buildTitle(item),
        ...comments,
      ],
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(20),
      child: Text(
        '${item.title}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
