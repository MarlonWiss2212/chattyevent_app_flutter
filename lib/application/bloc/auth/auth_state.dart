part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadingUserData extends AuthState {}

class AuthError extends AuthState {
  final String title;
  final String message;
  AuthError({required this.message, required this.title});
}

class AuthErrorUserData extends AuthState {
  final String token;
  final String title;
  final String message;
  AuthErrorUserData({
    required this.message,
    required this.title,
    required this.token,
  });
}

class AuthLoaded extends AuthState {
  final UserAndTokenEntity userAndToken;
  AuthLoaded({required this.userAndToken});
}
