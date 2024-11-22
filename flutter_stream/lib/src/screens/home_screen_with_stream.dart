import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreenWithStream extends StatefulWidget {
  const HomeScreenWithStream({super.key});

  @override
  State<HomeScreenWithStream> createState() => _HomeScreenWithStreamState();
}

class _HomeScreenWithStreamState extends State<HomeScreenWithStream> {
  late StreamController<String> controller;

  Stream<String> get stream => controller.stream.timeout(
        const Duration(milliseconds: 1000),
        onTimeout: (sink) => sink.addError('you lose'),
      );

  void _reload() {
    controller.close();
    controller = StreamController<String>();
  }

  @override
  void initState() {
    controller = StreamController<String>();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _reload();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<String>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                if (snapshot.data != null) {
                  return Text('${snapshot.data}');
                }
                return const SizedBox.shrink();
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.sink.add('You Clicking...');
              },
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
