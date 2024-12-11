part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(AppStatus.initial) AppStatus status,
  }) = _OnboardingState;
}
