part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  success,
  sendedResetPasswordEmail,
  sendedVerificationEmail,
  error
}

class AuthState {
  final ErrorWithTitleAndMessage? error;
  final AuthStateStatus status;
  final String? token;

  AuthState({
    this.error,
    this.status = AuthStateStatus.initial,
    this.token,
  });
}
