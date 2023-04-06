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

class UserStateLoaded extends UserState {
  const UserStateLoaded({required super.users});
}
