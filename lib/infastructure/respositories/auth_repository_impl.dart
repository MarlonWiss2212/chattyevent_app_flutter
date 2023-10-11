import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/persist_hive_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  final PersistHiveDatasource persistHiveDatasource;
  AuthRepositoryImpl({
    required this.auth,
    required this.persistHiveDatasource,
  });

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
  Future<Either<NotificationAlert, Unit>> sendEmailVerification() async {
    try {
      if (auth.currentUser == null) {
        return Left(NotificationAlert(
          title: "E-Mail sende Fehler",
          message:
              "Konnte keine E-Mail an den gerade eingeloggten User versenden",
        ));
      }
      await auth.currentUser!.sendEmailVerification();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> updatePassword({
    required String newPassword,
  }) async {
    try {
      await auth.currentUser?.updatePassword(newPassword);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> logout() async {
    try {
      await auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, User>> refreshUser() async {
    try {
      await auth.currentUser?.reload();
      if (auth.currentUser == null) {
        return Left(
          NotificationAlert(
            title: "Fehler User Neu Laden",
            message: "Fehler beim Identifizierens des gerdigen Users",
          ),
        );
      }
      return Right(auth.currentUser!);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> deleteUser() async {
    try {
      await auth.currentUser?.delete();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, String>> refreshToken({bool? force}) async {
    try {
      final token = await auth.currentUser?.getIdToken(force ?? false);
      if (token == null) {
        return Left(
          NotificationAlert(
            title: "Fehler Refresh Token",
            message: "Fehler beim erneuern der Auth Daten",
          ),
        );
      }
      return Right(token);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, User> getFirebaseUser() {
    try {
      if (auth.currentUser == null) {
        return Left(
          NotificationAlert(
            title: "Fehler User",
            message: "Fehler beim holen des Auth Users",
          ),
        );
      }
      return Right(auth.currentUser!);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> verifyBeforeUpdateEmail({
    required String newEmail,
  }) async {
    try {
      await auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  }) async {
    try {
      await auth.setLanguageCode(languageCode);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, AuthState> getAuthStateFromStorage() {
    try {
      final AuthState state = persistHiveDatasource.get<AuthState>(
        key: "authState",
      );
      return Right(state);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> saveAuthStateToStorage({
    required AuthState state,
  }) async {
    try {
      await persistHiveDatasource.put<AuthState>(
        key: "authState",
        value: state,
      );
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
