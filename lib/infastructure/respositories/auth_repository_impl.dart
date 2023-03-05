import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  AuthRepositoryImpl({required this.auth});

  @override
  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
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
        return const Left('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return const Left('Wrong password provided for that user.');
      } else {
        return Left(mapFailureToMessage(GeneralFailure()));
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
      final authUser = await auth.createUserWithEmailAndPassword(
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
  Future<Either<Failure, bool>> sendEmailVerification() async {
    try {
      if (auth.currentUser == null) {
        return Left(GeneralFailure());
      }
      await auth.currentUser!.sendEmailVerification();
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendResetPasswordEmail({
    required String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword({
    required String newPassword,
  }) async {
    try {
      if (auth.currentUser == null) {
        return Left(GeneralFailure());
      }
      await auth.currentUser!.updatePassword(newPassword);
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<void> reloadUser() async {
    return await auth.currentUser?.reload();
  }
}
