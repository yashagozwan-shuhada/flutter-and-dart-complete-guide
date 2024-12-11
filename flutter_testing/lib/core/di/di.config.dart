// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_testing/data/repository/fake/fake_coin_repository.dart'
    as _i557;
import 'package:flutter_testing/data/repository/prod/coin_repository_impl.dart'
    as _i485;
import 'package:flutter_testing/domain/repository/coin_repository.dart'
    as _i794;
import 'package:flutter_testing/presentation/features/home/bloc/home_bloc.dart'
    as _i283;
import 'package:flutter_testing/presentation/features/onboarding/cubit/onboarding_cubit.dart'
    as _i575;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _test = 'test';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i575.OnboardingCubit>(() => _i575.OnboardingCubit());
    gh.lazySingleton<_i794.CoinRepository>(
      () => _i557.FakeCoinRepository(),
      registerFor: {_test},
    );
    gh.lazySingleton<_i794.CoinRepository>(
      () => _i485.CoinRepositoryImpl(),
      registerFor: {_prod},
    );
    gh.factory<_i283.HomeBloc>(
        () => _i283.HomeBloc(gh<_i794.CoinRepository>()));
    return this;
  }
}
