import 'package:flutter/material.dart';
import 'package:flutter_stream/src/screens/home_screen_with_stream.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreenWithStream(),
    );
  }
}
