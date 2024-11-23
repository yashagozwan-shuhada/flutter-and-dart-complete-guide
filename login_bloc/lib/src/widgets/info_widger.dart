import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/provider.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of(context).streamEmail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data}');
        }

        return const SizedBox.shrink();
      },
    );
  }
}
