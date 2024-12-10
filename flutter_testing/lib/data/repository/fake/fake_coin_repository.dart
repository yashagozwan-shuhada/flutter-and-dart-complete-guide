import 'dart:developer';

import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:injectable/injectable.dart';

@test
@LazySingleton(as: CoinRepository)
class FakeCoinRepository implements CoinRepository {
  @override
  Future<List<CoinModel>> getCoins(int page, int size) async {
    log('FakeCoinRepository', name: 'FakeCoinRepository');

    return [
      const CoinModel(name: 'Bitcoin'),
      const CoinModel(name: 'Stellar'),
    ];
  }
}
