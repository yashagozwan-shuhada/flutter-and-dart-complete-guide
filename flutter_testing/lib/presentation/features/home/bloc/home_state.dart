part of 'home_bloc.dart';

@Freezed(
  fromJson: false,
  toJson: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  unionValueCase: FreezedUnionCase.none,
)
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(AppStatus.initial) AppStatus status,
    @Default([]) List<CoinModel> coins,
    String? message,
  }) = _HomeState;

  const HomeState._();
}
