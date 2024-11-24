import 'package:flutter/material.dart';

class CatWidget extends StatelessWidget {
  const CatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/QwhZRyL.png',
    );
  }
}
