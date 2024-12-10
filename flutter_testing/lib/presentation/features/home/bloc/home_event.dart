part of 'home_bloc.dart';

@Freezed(
  fromJson: false,
  toJson: false,
  copyWith: false,
  equal: false,
  toStringOverride: false,
  genericArgumentFactories: false,
  addImplicitFinal: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions.none,
  unionValueCase: FreezedUnionCase.none,
)
abstract class HomeEvent with _$HomeEvent {
  const HomeEvent._();

  factory HomeEvent.initial() = _HomeInitial;
}
