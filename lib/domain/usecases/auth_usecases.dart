import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<String, UserCredential>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Either<String, UserCredential>> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredOrFailureString =
        await authRepository.registerWithEmailAndPassword(
      email: email,
      password: password,
    );

    await userCredOrFailureString.fold((l) => null, (userCredential) async {
      if (userCredential.user != null) {
        await authRepository.sendEmailVerification(
          authUser: userCredential.user!,
        );
      }
    });
    return userCredOrFailureString;
  }

  Future<void> sendEmailVerification({required User authUser}) async {
    return await authRepository.sendEmailVerification(authUser: authUser);
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
