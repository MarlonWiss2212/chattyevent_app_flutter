part of 'auth_cubit.dart';

enum AuthStateStatus { initial, loading, success, error }

class AuthState {
  final ErrorWithTitleAndMessage? error;
  final AuthStateStatus status;
  final User? user;
  final String? token;

  AuthState({
    this.error,
    this.status = AuthStateStatus.initial,
    this.user,
    this.token,
  });
}
