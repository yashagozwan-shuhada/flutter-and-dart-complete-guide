import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/widget/loading_container.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({
    required this.id,
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data![id],
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingContainer();
            }

            return _buildTile(context, snapshot.data!);
          },
        );
      },
    );
  }

  Widget _buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text('${item.title}'),
          subtitle: Text('${item.score} Votes'),
          trailing: Column(
            children: [
              const Icon(Icons.comment),
              Text('${item.descendants ?? 0}'),
            ],
          ),
        ),
        const Divider(height: 8),
      ],
    );
  }
}
