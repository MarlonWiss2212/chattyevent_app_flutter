import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class AuthRepository {
  Future<Either<NotificationAlert, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<NotificationAlert, UserCredential>>
      registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<NotificationAlert, bool>> sendEmailVerification();
  Future<Either<NotificationAlert, bool>> updatePassword({
    required String newPassword,
  });
  Future<Either<NotificationAlert, bool>> sendResetPasswordEmail({
    required String email,
  });
  Future<void> logout();
  Future<Either<NotificationAlert, User>> refreshUser();
  Future<Either<NotificationAlert, String>> refreshToken();
  Future<Either<NotificationAlert, Unit>> deleteUser();
}
