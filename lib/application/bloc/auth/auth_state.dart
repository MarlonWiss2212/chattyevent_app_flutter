part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final bool tokenError;
  final String title;
  final String message;
  AuthError({
    required this.message,
    required this.title,
    required this.tokenError,
  });
}

class AuthLoaded extends AuthState {
  final String token;

  // only for login and register for efficiency
  final UserEntity? userResponse;
  AuthLoaded({required this.token, this.userResponse});
}
