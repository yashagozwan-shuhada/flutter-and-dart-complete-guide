import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/presentation/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter_testing/presentation/features/onboarding/onboarding_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ent-to-end test', () {
    setUpAll(() async {
      await configureDependencies(Environment.test);
    });

    testWidgets('go to onboarding screen', (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => getIt<OnboardingCubit>(),
            child: const OnboardingScreen(),
          ),
        ),
      );

      await widgetTester.pump(const Duration(milliseconds: 1000));
      final homeText = find.text('Onboarding');
      expect(homeText, findsOneWidget);
      final button = find.byKey(const ValueKey('__home__'));
      await widgetTester.tap(button);
    });
  });
}
