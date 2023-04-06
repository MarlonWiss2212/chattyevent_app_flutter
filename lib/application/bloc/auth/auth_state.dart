part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  success,
  createUserPage,
}

class AuthState {
  final AuthStateStatus status;

  final String? token;
  final UserEntity currentUser;

  final bool sendedResetPasswordEmail;
  final bool sendedVerificationEmail;

  AuthState({
    required this.currentUser,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.sendedVerificationEmail = false,
  });
}
