import 'package:flutter/material.dart';
import 'package:hacker_news/src/blocs/comments_bloc.dart';
import 'package:hacker_news/src/blocs/comments_provider.dart';
import 'package:hacker_news/src/blocs/stories_bloc.dart';
import 'package:hacker_news/src/blocs/stories_provider.dart';
import 'package:hacker_news/src/screen/news_detail_screen.dart';
import 'package:hacker_news/src/screen/news_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      bloc: CommentsBloc(),
      child: StoriesProvider(
        bloc: StoriesBloc(),
        child: MaterialApp(
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route<MaterialPageRoute<dynamic>> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return const NewsScreen();
        },
      );
    }

    return MaterialPageRoute(
      builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final id = settings.name?.replaceFirst('/', '');

        assert(id != null, 'id not found');

        commentsBloc.fetchItemWithComments(int.parse(id!));
        return NewsDetailScreen(id: int.parse(id));
      },
    );
  }
}
