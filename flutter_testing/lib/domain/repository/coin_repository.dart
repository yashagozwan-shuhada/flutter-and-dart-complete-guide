import 'package:flutter_testing/domain/model/coin_model.dart';

abstract class CoinRepository {
  Future<List<CoinModel>> getCoins(
    int page,
    int size,
  );
}
