part of 'user_search_bloc.dart';

@immutable
abstract class UserSearchState {}

class UserSearchInitial extends UserSearchState {}

class UserSearchStateLoading extends UserSearchState {}

class UserSearchStateError extends UserSearchState {
  final String message;
  UserSearchStateError({required this.message});
}

class UserSearchStateLoaded extends UserSearchState {
  final List<UserEntity> users;
  UserSearchStateLoaded({required this.users});
}
