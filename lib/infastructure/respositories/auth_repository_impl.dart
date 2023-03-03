import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(authUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else {
        return Left(mapFailureToMessage(ServerFailure()));
      }
    } catch (e) {
      return Left(mapFailureToMessage(ServerFailure()));
    }
  }

  @override
  Future<Either<String, UserCredential>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(authUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return const Left('The account already exists for that email.');
      } else {
        return Left(mapFailureToMessage(ServerFailure()));
      }
    } catch (e) {
      return Left(mapFailureToMessage(ServerFailure()));
    }
  }

  @override
  Future<void> sendEmailVerification({required User authUser}) async {
    await authUser.sendEmailVerification();
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
