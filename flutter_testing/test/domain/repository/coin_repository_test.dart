import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/core/di/di.dart';
import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/model/failure_model.dart';
import 'package:flutter_testing/domain/model/success_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart' show Environment;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<CoinRepository>()])
import 'coin_repository_test.mocks.dart';

void main() {
  provideDummy(
    Either<FailureModel, SuccessModel<List<CoinModel>>>.right(
      const SuccessModel([]),
    ),
  );

  group('CoinRepository', () {
    late final MockCoinRepository repository;

    setUpAll(() {
      repository = MockCoinRepository();
    });

    test('should return list of CoinModel when getCoins called', () async {
      when(repository.getCoins(1, 10)).thenAnswer(
        (_) async => Either<FailureModel, SuccessModel<List<CoinModel>>>.right(
          const SuccessModel(
            [CoinModel(name: 'Bitcoin')],
          ),
        ),
      );

      final either = await repository.getCoins(1, 10);

      either.fold(
        (error) => expect(error.message, 'Empty'),
        (success) {
          expect(success.data, isA<List<CoinModel>>());
          expect(success.data, isNotEmpty);
          expect(success.data.firstOrNull?.name, 'Bitcoin');
        },
      );
    });

    test('should return error message when getCoins failed', () async {
      when(repository.getCoins(1, 10)).thenAnswer(
        (_) async => Either<FailureModel, SuccessModel<List<CoinModel>>>.left(
          const FailureModel('Something wrong'),
        ),
      );

      final either = await repository.getCoins(1, 10);

      either.fold(
        (error) => expect(error.message, 'Something wrong'),
        (success) {
          expect(success.data, isA<List<CoinModel>>());
          expect(success.data, isNotEmpty);
          expect(success.data.firstOrNull?.name, 'Bitcoin');
        },
      );
    });
  });

  group('FakeCoinRepository', () {
    late final CoinRepository coinRepository;

    setUpAll(() {
      configureDependencies(Environment.test);
      coinRepository = getIt();
    });

    test('should return list of coinModel when getCoins called', () async {
      final either = await coinRepository.getCoins(1, 10);

      either.fold(
        (error) => expect(error, 'Empty'),
        (success) {
          expect(success.data, isA<List<CoinModel>>());
          expect(success.data, isNotEmpty);
          expect(success.data.firstOrNull?.name, 'Bitcoin');
        },
      );
    });
  });
}
