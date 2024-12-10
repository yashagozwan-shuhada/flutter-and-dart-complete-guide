import 'dart:ffi';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/core/constants/app_status.dart';
import 'package:flutter_testing/domain/model/coin_model.dart';
import 'package:flutter_testing/domain/repository/coin_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._coinRepository) : super(const HomeState()) {
    on<_HomeInitial>(_initial);
  }

  final CoinRepository _coinRepository;

  Future<void> _initial(_HomeInitial event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));

    final either = await _coinRepository.getCoins(1, 10);

    emit(
      either.fold(
        (error) => state.copyWith(
          status: AppStatus.failure,
          message: error.message,
        ),
        (success) => state.copyWith(
          status: AppStatus.success,
          coins: success.data,
        ),
      ),
    );
  }
}
