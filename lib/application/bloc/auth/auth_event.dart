part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLoginEvent({required this.email, required this.password});
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  AuthRegisterEvent({required this.email, required this.password});
}

class AuthGetTokenEvent extends AuthEvent {}
