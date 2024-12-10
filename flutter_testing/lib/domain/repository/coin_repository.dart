import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/model/failure_model.dart';
import 'package:flutter_testing/domain/model/success_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class CoinRepository {
  Future<Either<FailureModel, SuccessModel<List<CoinModel>>>> getCoins(
    int page,
    int size,
  );
}
