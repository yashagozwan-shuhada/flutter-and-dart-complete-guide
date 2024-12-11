import 'package:flutter/cupertino.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> push<T extends Object?>(Widget screen) {
    return Navigator.push(
      this,
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
