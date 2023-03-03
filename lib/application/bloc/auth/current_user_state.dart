part of 'current_user_cubit.dart';

enum CurrentUserStateStatus { initial, loading, success, error }

class CurrentUserState {
  final UserEntity user;
  final ErrorWithTitleAndMessage? error;
  final CurrentUserStateStatus status;

  const CurrentUserState({
    required this.user,
    this.status = CurrentUserStateStatus.initial,
    this.error,
  });
}
