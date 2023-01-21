part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String title;
  final String message;
  AuthError({required this.message, required this.title});
}

class AuthLoaded extends AuthState {
  final String token;
  AuthLoaded({required this.token});
}
