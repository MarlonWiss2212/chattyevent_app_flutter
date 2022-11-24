part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String message;
  AuthStateError({required this.message});
}

class AuthStateLoaded extends AuthState {
  final String token;
  AuthStateLoaded({required this.token});
}
