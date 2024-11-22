import 'dart:async';

import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;

  String? title;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() => title = "You Loser !");
    });
    super.initState();
  }

  void onClick() {
    setState(() {
      title = null;
    });

    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(milliseconds: 1000), () {
      setState(() => title = "You Loser !");
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) Text("$title"),
            FilledButton(
              onPressed: () {
                onClick();
              },
              child: const Text("Click Me"),
            ),
          ],
        ),
      ),
    );
  }
}
