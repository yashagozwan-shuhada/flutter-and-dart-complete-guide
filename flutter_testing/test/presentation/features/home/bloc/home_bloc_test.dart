import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/constants/app_status.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/model/failure_model.dart';
import 'package:flutter_testing/domain/model/success_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:flutter_testing/presentation/features/home/bloc/home_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinRepository>()])
import 'home_bloc_test.mocks.dart';

void main() {
  configureDependencies(Environment.test);
  group('HomeBloc', () {
    late final HomeBloc bloc;
    setUpAll(() {
      bloc = getIt<HomeBloc>();
    });

    blocTest<HomeBloc, HomeState>(
      'initial',
      build: () => bloc,
      act: (bloc) {
        bloc.add(HomeEvent.initial());
      },
      expect: () => [
        isA<HomeState>()
            .having((state) => state.status, 'Loading', AppStatus.loading)
            .having((state) => state.coins, 'Coin', isEmpty)
            .having((state) => state.message, 'Message', isNull),
        isA<HomeState>()
            .having((state) => state.status, 'Success', AppStatus.success)
            .having((state) => state.coins, 'Coin', isA<List<CoinModel>>())
            .having((state) => state.message, 'Message', isNull),
      ],
    );
  });

  group('HomeBloc with MockCoinRepository', () {
    provideDummy(
      Either<FailureModel, SuccessModel<List<CoinModel>>>.left(
        const FailureModel('something wrong'),
      ),
    );

    late final MockCoinRepository coinRepository;

    setUpAll(() {
      coinRepository = MockCoinRepository();
    });

    blocTest<HomeBloc, HomeState>(
      'Initial Positive Case',
      build: () => HomeBloc(coinRepository),
      setUp: () {
        when(coinRepository.getCoins(1, 10)).thenAnswer(
          (realInvocation) async => Either.right(
            const SuccessModel(
              [CoinModel(name: 'Sui')],
            ),
          ),
        );
      },
      act: (bloc) {
        bloc.add(HomeEvent.initial());
      },
      expect: () => [
        isA<HomeState>()
            .having((state) => state.status, 'message', AppStatus.loading)
            .having((state) => state.coins, 'cons', isEmpty)
            .having((state) => state.message, 'message', isNull),
        isA<HomeState>()
            .having((state) => state.status, 'status', AppStatus.success)
            .having((state) => state.coins, 'coins', isA<List<CoinModel>>())
            .having((state) => state.coins, 'coins', isNotEmpty)
            .having(
              (state) => state.coins.first.name,
              'then coin name is Sui',
              'Sui',
            )
            .having((state) => state.message, 'message', isNull),
      ],
    );
  });
}
