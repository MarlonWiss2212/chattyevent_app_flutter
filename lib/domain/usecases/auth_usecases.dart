import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<NotificationAlert, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Either<NotificationAlert, UserCredential>>
      registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredOrNotificationAlertString =
        await authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredOrNotificationAlertString.fold((l) => null,
        (userCredential) async {
      if (userCredential.user != null) {
        await authRepository.sendEmailVerification();
      }
    });
    return userCredOrNotificationAlertString;
  }

  Future<Either<NotificationAlert, bool>> sendEmailVerification() async {
    return await authRepository.sendEmailVerification();
  }

  Future<Either<NotificationAlert, bool>> sendResetPasswordEmail({
    required String email,
  }) async {
    return await authRepository.sendResetPasswordEmail(email: email);
  }

  Future<Either<NotificationAlert, bool>> updatePassword({
    required String password,
    required String verfiyPassword,
  }) async {
    if (password != verfiyPassword) {
      return Left(NotificationAlert(
        title: "Unterschiedliches Passwort",
        message: "Die Passwörter stimmen nicht überein",
      ));
    }
    return await authRepository.updatePassword(newPassword: password);
  }

  Future<Either<NotificationAlert, Unit>> refreshUser() async {
    return await authRepository.refreshUser();
  }

  Future<void> logout() async {
    await authRepository.logout();
  }

  Future<Either<NotificationAlert, Unit>> deleteUser() async {
    return await authRepository.deleteUser();
  }
}
