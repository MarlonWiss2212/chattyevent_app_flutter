part of 'user_cubit.dart';

@immutable
abstract class UserState {
  final List<UserEntity> users;

  const UserState({required this.users});
}

class UserInitial extends UserState {
  UserInitial() : super(users: []);
}

class UserStateLoading extends UserState {
  const UserStateLoading({required super.users});
}

class UserStateError extends UserState {
  final String title;
  final String message;
  const UserStateError({
    required super.users,
    required this.title,
    required this.message,
  });
}

class UserStateLoaded extends UserState {
  const UserStateLoaded({required super.users});
}
