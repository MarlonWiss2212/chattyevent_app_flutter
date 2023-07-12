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
  final bool updatedPasswordSuccessfully;

  final OperationException? userException;

  bool isUserCode404() {
    if (userException == null) {
      return false;
    }
    for (final error in userException!.graphqlErrors) {
      if (error.extensions?["code"] == "404") {
        return true;
      }
    }
    return false;
  }

  AuthState({
    required this.currentUser,
    // but dont merge in emitState
    this.dataprotectionCheckbox = false,
    this.token,
    this.status = AuthStateStatus.initial,
    this.sendedResetPasswordEmail = false,
    this.updatedPasswordSuccessfully = false,
    this.sendedVerificationEmail = false,
    this.userException,
  });
}
