import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/presentation/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter_testing/presentation/features/onboarding/onboarding_screen.dart';
import 'package:injectable/injectable.dart';

void main() {
  group('Onboarding', () {
    setUpAll(() async {
      await configureDependencies(Environment.test);
    });

    testWidgets('initial', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => getIt<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 1000));
      final title = find.text('Onboarding');
      expect(title, findsOneWidget);
    });
  });
}
