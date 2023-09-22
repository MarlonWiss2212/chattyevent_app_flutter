part of 'auth_cubit.dart';

enum AuthStateStatus {
  initial,
  loading,
  loggedIn,
  logout,
}

class AuthState {
  final AuthStateStatus status;

  final String? token;
  final UserEntity currentUser;

  final bool dataprotectionCheckbox;

  final bool sendedResetPasswordEmail;
  final bool sendedVerificationEmail;

  final OperationException? userException;

  AuthState({
    required this.currentUser,
    // but dont merge in emitState
    this.dataprotectionCheckbox = false,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.sendedVerificationEmail = false,
    this.userException,
  });
}
