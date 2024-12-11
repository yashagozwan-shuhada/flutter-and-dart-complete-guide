import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/presentation/features/home/bloc/home_bloc.dart';
import 'package:flutter_testing/presentation/features/home/home_screen.dart';
import 'package:injectable/injectable.dart';

void main() {
  group('HomeScreen', () {
    setUpAll(() {
      configureDependencies(Environment.test);
    });

    testWidgets('initial', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => getIt<HomeBloc>(),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 1000));

      final homeText = find.text('Home');
      expect(homeText, findsOneWidget);
    });
  });
}
