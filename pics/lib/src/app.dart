import 'package:flutter/material.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  int counter = 0;

  void fetchImage() async {
    counter++;

    final response =
        await get(Uri.parse("https://jsonplaceholder.typicode.com/photos/1"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Text("$counter"),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            fetchImage();
          },
        ),
        appBar: AppBar(
          title: const Text("Let's see some images!"),
        ),
      ),
    );
  }
}
