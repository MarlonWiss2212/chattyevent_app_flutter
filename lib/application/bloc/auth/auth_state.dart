part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  error,
  success,
}

class AuthState {
  final ErrorWithTitleAndMessage? error;
  final AuthStateStatus status;

  final String? token;
  final UserEntity currentUser;

  final bool sendedResetPasswordEmail;
  final bool sendedVerificationEmail;

  AuthState({
    required this.currentUser,
    this.error,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.sendedVerificationEmail = false,
  });
}
