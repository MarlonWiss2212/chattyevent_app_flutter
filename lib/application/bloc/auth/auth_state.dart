part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  success,
  logout,
}

class AuthState {
  final AuthStateStatus status;

  final String? token;
  final UserEntity currentUser;

  final bool sendedResetPasswordEmail;
  final bool sendedVerificationEmail;
  final bool goOnCreateUserPage;
  final bool updatedPasswordSuccessfully;

  AuthState({
    required this.currentUser,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.updatedPasswordSuccessfully = false,
    this.sendedVerificationEmail = false,
    this.goOnCreateUserPage = false,
  });
}
