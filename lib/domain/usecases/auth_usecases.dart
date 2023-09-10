import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  final OneSignalRepository oneSignalRepository;
  AuthUseCases({
    required this.authRepository,
    required this.oneSignalRepository,
  });

  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  }) {
    return authRepository.setLanguageCode(languageCode: languageCode);
  }

  Either<NotificationAlert, User> getFirebaseUser() {
    return authRepository.getFirebaseUser();
  }

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

  Future<Either<NotificationAlert, Unit>> sendEmailVerification() async {
    return await authRepository.sendEmailVerification();
  }

  Future<Either<NotificationAlert, String>> sendResetPasswordEmail({
    String? email,
  }) async {
    if (email == null) {
      final userOrFailure = await authRepository.getFirebaseUser();
      return await userOrFailure.fold(
        (alert) => Left(alert),
        (user) async {
          if (user.email == null) {
            return Left(
              NotificationAlert(
                title: "Fehler Passwort zurücksetzen E-Mail",
                message:
                    "Konnte keine Email senden da keine E-Mail providet wurde",
              ),
            );
          } else {
            return (await authRepository.sendResetPasswordEmail(
              email: user.email!,
            ))
                .fold(
              (l) => Left(l),
              (r) => Right(user.email!),
            );
          }
        },
      );
    } else {
      return (await authRepository.sendResetPasswordEmail(email: email)).fold(
        (l) => Left(l),
        (r) => Right(email),
      );
    }
  }

  Future<Either<NotificationAlert, Unit>> updatePassword({
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

  Future<Either<NotificationAlert, Unit>> verifyBeforeUpdateEmail({
    required String email,
    required String verifyEmail,
  }) async {
    if (email != verifyEmail) {
      return Left(NotificationAlert(
        title: "Unterschiedliches E-Mails",
        message: "Die E-Mails stimmen nicht überein",
      ));
    }
    return await authRepository.verifyBeforeUpdateEmail(newEmail: email);
  }

  Future<Either<NotificationAlert, User>> refreshUser() async {
    return await authRepository.refreshUser();
  }

  Future<Either<NotificationAlert, String>> refreshToken({bool? force}) async {
    return await authRepository.refreshToken(force: force);
  }

  Future<List<Either<NotificationAlert, Unit>>> logout() async {
    return await Future.wait([
      oneSignalRepository.logout(),
      authRepository.logout(),
    ]);
  }

  Future<Either<NotificationAlert, Unit>> deleteUser() async {
    return await authRepository.deleteUser();
  }

  Future<bool> isEmailVerified() async {
    final currentAuthUser = await authRepository.refreshUser();
    return currentAuthUser.fold(
      (alert) => false,
      (user) => user.emailVerified,
    );
  }
}
