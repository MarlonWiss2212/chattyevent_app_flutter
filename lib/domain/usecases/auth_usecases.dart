import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Either<String, UserCredential>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredOrFailureString =
        await authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredOrFailureString.fold((l) => null, (userCredential) async {
      if (userCredential.user != null) {
        await authRepository.sendEmailVerification();
      }
    });
    return userCredOrFailureString;
  }

  Future<Either<Failure, bool>> sendEmailVerification() async {
    return await authRepository.sendEmailVerification();
  }

  Future<Either<Failure, bool>> sendResetPasswordEmail({
    required String email,
  }) async {
    return await authRepository.sendResetPasswordEmail(email: email);
  }

  Future<Either<Failure, bool>> updatePassword({
    required String password,
    required String verfiyPassword,
  }) async {
    if (password != verfiyPassword) {
      return Left(NotTheSamePasswordFailure());
    }
    return await authRepository.updatePassword(newPassword: password);
  }

  Future<void> reloadUser() async {
    return await authRepository.reloadUser();
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
