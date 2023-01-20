part of 'user_search_cubit.dart';

@immutable
abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchStateLoading extends UserSearchState {}

class UserSearchStateError extends UserSearchState {
  final String title;
  final String message;
  UserSearchStateError({required this.title, required this.message});
}

class UserSearchStateLoaded extends UserSearchState {
  final List<UserEntity> users;
  UserSearchStateLoaded({required this.users});
}
