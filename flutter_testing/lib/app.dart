import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/presentation/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter_testing/presentation/features/onboarding/onboarding_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => getIt<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
      ),
    );
  }
}
