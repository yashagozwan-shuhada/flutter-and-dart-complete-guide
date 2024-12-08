import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: _buildContainer(),
          subtitle: _buildContainer(),
        ),
        Divider(height: 8),
      ],
    );
  }

  Widget _buildContainer() {
    return Container(
      height: 24,
      width: 150,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      color: Colors.grey[200],
    );
  }
}
