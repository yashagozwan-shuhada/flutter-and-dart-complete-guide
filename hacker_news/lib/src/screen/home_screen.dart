import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tops News'),
      ),
      body: _newsList(),
    );
  }

  Widget _newsList() {
    return const Text('News List');
  }
}
