import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pics/src/http/custom_client.dart';
import 'package:pics/src/http/custom_http.dart';
import 'package:pics/src/model/image_model.dart';
import 'package:pics/src/widgets/image_list.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  final client = CustomHttp(
    client: CustomClient(client: Client()),
    baseUrl: 'https://jsonplaceholder.typicode.com',
  );

  void fetchImage() async {
    counter++;
    final response = await client.get("/photos/$counter");
    final imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images: images),
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
