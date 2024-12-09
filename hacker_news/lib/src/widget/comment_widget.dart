import 'package:flutter/material.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/widget/loading_container.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    required this.itemId,
    required this.itemMap,
    required this.depth,
    super.key,
  });

  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        var widgets = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(
              left: (depth + 1) * 16,
              right: 16,
            ),
            title: () {
              if (snapshot.data == null) return const SizedBox.shrink();
              return buildText(snapshot.data!);
            }(),
            subtitle: () {
              if (snapshot.data?.by == null) {
                return const SizedBox.shrink();
              }

              if (snapshot.data!.by!.isEmpty) {
                return const Text('Deleted');
              }

              return Text('${snapshot.data?.by}');
            }(),
          ),
          const Divider(),
        ];

        if (snapshot.data?.kids != null) {
          widgets = [
            ...widgets,
            ...snapshot.data!.kids!.map(
              (e) => CommentWidget(
                itemId: e,
                itemMap: itemMap,
                depth: depth + 1,
              ),
            ),
          ];
        }

        return Column(
          children: widgets,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    if (item.text == null) return const SizedBox.shrink();
    final text = item.text!
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');

    return Text(text);
  }
}
