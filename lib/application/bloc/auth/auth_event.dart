part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent({required this.email, required this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final CreateUserDto createUserDto;
  AuthRegisterEvent({required this.createUserDto});
}

class AuthGetTokenEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
