import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';

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
  Future<void> reloadUser();
  Future<Either<NotificationAlert, bool>> sendEmailVerification();
  Future<Either<NotificationAlert, bool>> updatePassword(
      {required String newPassword});
  Future<Either<NotificationAlert, bool>> sendResetPasswordEmail({
    required String email,
  });
  Future<void> logout();
}
