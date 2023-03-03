import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<String, UserCredential>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> sendEmailVerification({required User authUser});
  Future<void> logout();
}
