import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@LazySingleton(as: CoinRepository)
class CoinRepositoryImpl implements CoinRepository {
  @override
  Future<List<CoinModel>> getCoins(int page, int size) async {
    return [
      const CoinModel(name: 'Sui'),
      const CoinModel(name: 'Ripple'),
    ];
  }
}