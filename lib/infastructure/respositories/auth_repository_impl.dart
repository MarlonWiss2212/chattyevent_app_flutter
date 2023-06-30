import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  AuthRepositoryImpl({required this.auth});

  @override
  Future<Either<NotificationAlert, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUser = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(authUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(NotificationAlert(
          title: "Login Fehler",
          message: 'Keinen User mit der Email gefunden',
        ));
      } else if (e.code == 'wrong-password') {
        return Left(NotificationAlert(
          title: "Login Fehler",
          message: 'Falches Passwort',
        ));
      } else {
        return Left(
            FailureHelper.catchFailureToNotificationAlert(exception: e));
      }
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserCredential>>
      registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUser = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(authUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Left(NotificationAlert(
          title: "Schwaches Passwort",
          message: 'Das mitgegebene passwort is zu schwach',
        ));
      } else if (e.code == 'email-already-in-use') {
        return Left(NotificationAlert(
          title: "Email bereits verwendet",
          message:
              'Die E-Mail addresse wird bereits von einem anderen Konto verwendet',
        ));
      } else {
        return Left(
            FailureHelper.catchFailureToNotificationAlert(exception: e));
      }
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> sendEmailVerification() async {
    try {
      if (auth.currentUser == null) {
        return Left(NotificationAlert(
          title: "E-Mail sende Fehler",
          message:
              "Konnte keine E-Mail an den gerade eingeloggten User versenden",
        ));
      }
      await auth.currentUser!.sendEmailVerification();
      return const Right(true);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> updatePassword({
    required String newPassword,
  }) async {
    try {
      if (auth.currentUser == null) {
        return Left(NotificationAlert(
          title: "Passwort Update Fehler",
          message: "Konnte das Passwort nicht updaten",
        ));
      }
      await auth.currentUser!.updatePassword(newPassword);
      return const Right(true);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<Either<NotificationAlert, Unit>> refreshUser() async {
    if (auth.currentUser == null) {
      return Left(
        NotificationAlert(
          title: "Fehler User Neu Laden",
          message: "Fehler beim Identifizierens des gerdigen Users",
        ),
      );
    }
    await auth.currentUser!.reload();
    return const Right(unit);
  }

  @override
  Future<Either<NotificationAlert, Unit>> deleteUser() async {
    if (auth.currentUser == null) {
      return Left(
        NotificationAlert(
          title: "Fehler User Löschen",
          message: "Fehler beim Identifizierens des gerdigen Users",
        ),
      );
    }
    try {
      await auth.currentUser!.delete();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
