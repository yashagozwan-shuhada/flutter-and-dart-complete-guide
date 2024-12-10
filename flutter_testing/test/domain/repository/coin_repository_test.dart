import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/data/repository/prod/coin_repository_impl.dart';
import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinRepository>()])
import 'coin_repository_test.mocks.dart';

void main() {
  group('CoinRepository', () {
    late final MockCoinRepository repository;

    setUpAll(() {
      repository = MockCoinRepository();
    });

    test('should return list of CoinModel when getCoins called', () async {
      when(repository.getCoins(1, 10)).thenAnswer(
        (_) async => [
          const CoinModel(name: 'Bitcoin'),
          const CoinModel(name: 'Stellar'),
        ],
      );

      final coins = await repository.getCoins(1, 10);

      expect(coins, isA<List<CoinModel>>());
      expect(coins, isNotEmpty);
      expect(coins.firstOrNull?.name, 'Bitcoin');
    });
  });

  group('FakeCoinRepository', () {
    late final CoinRepository coinRepository;

    setUpAll(() {
      configureDependencies(Environment.test);
      coinRepository = getIt();
    });

    test('should return list of coinModel when getCoins called', () async {
      final coins = await coinRepository.getCoins(1, 10);
      expect(coins, isNotEmpty);
      expect(coins, isA<List<CoinModel>>());
      expect(coins.firstOrNull?.name, 'Bitcoin');
    });
  });
}
