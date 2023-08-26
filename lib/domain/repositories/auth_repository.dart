import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class AuthRepository {
  Either<NotificationAlert, User> getFirebaseUser();
  Future<Either<NotificationAlert, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<NotificationAlert, UserCredential>>
      registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<NotificationAlert, Unit>> sendEmailVerification();
  Future<Either<NotificationAlert, Unit>> verifyBeforeUpdateEmail({
    required String newEmail,
  }); // https://stackoverflow.com/questions/61535850/how-to-verify-an-email-before-making-it-the-primary-firebase-authentication
  Future<Either<NotificationAlert, Unit>> updatePassword({
    required String newPassword,
  });
  Future<Either<NotificationAlert, Unit>> sendResetPasswordEmail({
    required String email,
  });
  Future<Either<NotificationAlert, Unit>> logout();
  Future<Either<NotificationAlert, User>> refreshUser();
  Future<Either<NotificationAlert, String>> refreshToken();
  Future<Either<NotificationAlert, Unit>> deleteUser();
}
