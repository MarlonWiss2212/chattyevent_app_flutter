part of 'user_search_cubit.dart';

enum UserSearchStateStatus { initial, loading, error, success }

class UserSearchState {
  final List<UserEntity> users;
  final UserSearchStateStatus status;
  final ErrorWithTitleAndMessage? error;

  UserSearchState({
    required this.users,
    this.error,
    this.status = UserSearchStateStatus.initial,
  });
}
