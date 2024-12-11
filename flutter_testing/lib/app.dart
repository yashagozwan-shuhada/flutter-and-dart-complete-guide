import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_testing/presentation/features/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const FlavorBanner(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
