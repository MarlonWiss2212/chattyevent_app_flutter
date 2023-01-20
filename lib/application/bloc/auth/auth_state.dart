part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateLoadingToken extends AuthState {}

class AuthStateLoadingCurrentUser extends AuthState {}

class AuthStateError extends AuthState {
  final String title;
  final String message;
  AuthStateError({required this.message, required this.title});
}

class AuthStateLoaded extends AuthState {
  final UserAndTokenEntity userAndToken;
  AuthStateLoaded({required this.userAndToken});
}
