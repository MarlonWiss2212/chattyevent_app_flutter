part of 'profile_page_cubit.dart';

enum ProfilePageStateStatus { initial, loading, success, error }

class ProfilePageState {
  final UserEntity user;
  final ProfilePageStateStatus status;
  final ErrorWithTitleAndMessage? error;

  const ProfilePageState({
    required this.user,
    this.error,
    this.status = ProfilePageStateStatus.initial,
  });
}
