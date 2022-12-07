part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateError extends UserState {
  final String message;
  UserStateError({required this.message});
}

class UserStateLoaded extends UserState {
  final List<UserEntity> users;
  final String? errorMessage;

  UserStateLoaded({required this.users, this.errorMessage});
}
