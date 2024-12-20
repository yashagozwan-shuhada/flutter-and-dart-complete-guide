import 'package:flutter/material.dart';
import 'package:flutter_animation/src/screens/animation_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AnimationScreen(),
    );
  }
}
