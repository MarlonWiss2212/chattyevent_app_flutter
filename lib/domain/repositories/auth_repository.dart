import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<String, UserCredential>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> reloadUser();
  Future<Either<Failure, bool>> sendEmailVerification();
  Future<Either<Failure, bool>> updatePassword({required String newPassword});
  Future<Either<Failure, bool>> sendResetPasswordEmail({
    required String email,
  });
  Future<void> logout();
}
