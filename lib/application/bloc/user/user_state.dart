part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateError extends UserState {
  final String title;
  final String message;
  UserStateError({required this.title, required this.message});
}

class UserStateLoaded extends UserState {
  final List<UserEntity> users;
  final String? errorMessage;

  UserStateLoaded({required this.users, this.errorMessage});
}
