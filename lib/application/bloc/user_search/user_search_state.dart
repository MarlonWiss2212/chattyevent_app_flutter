part of 'user_search_cubit.dart';

enum UserSearchStateStatus { initial, loading, success, loadingMore }

class UserSearchState {
  final List<UserEntity> users;
  final UserSearchStateStatus status;

  UserSearchState({
    required this.users,
    this.status = UserSearchStateStatus.initial,
  });
}
