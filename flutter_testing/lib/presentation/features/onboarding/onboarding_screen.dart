import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/core/extensions/navigator_extension.dart';
import 'package:flutter_testing/presentation/features/home/bloc/home_bloc.dart';
import 'package:flutter_testing/presentation/features/home/home_screen.dart';
import 'package:flutter_testing/presentation/features/onboarding/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OnboardingCubit>(context)..initial();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
      ),
      body: Center(
        child: FilledButton(
          key: const ValueKey('__home__'),
          onPressed: () {
            context.push(
              BlocProvider(
                create: (_) => getIt<HomeBloc>(),
                child: const HomeScreen(),
              ),
            );
          },
          child: const Text('Home'),
        ),
      ),
    );
  }
}
