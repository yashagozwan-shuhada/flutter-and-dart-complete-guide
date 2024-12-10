import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/model/failure_model.dart';
import 'package:flutter_testing/domain/model/success_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@test
@LazySingleton(as: CoinRepository)
class FakeCoinRepository implements CoinRepository {
  @override
  Future<Either<FailureModel, SuccessModel<List<CoinModel>>>> getCoins(
    int page,
    int size,
  ) async {
    return Either.right(
      const SuccessModel(
        [
          CoinModel(name: 'Bitcoin'),
          CoinModel(name: 'Stellar'),
        ],
      ),
    );
  }
}
