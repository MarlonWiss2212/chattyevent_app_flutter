import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<Failure, String>> login(String email, String password) async {
    return await authRepository.login(email, password);
  }

  Future<Either<Failure, String>> register(
      String email, String password) async {
    return await authRepository.register(email, password);
  }

  Future<Either<Failure, String>> getAuthTokenFromStorage() async {
    return await authRepository.getAuthTokenFromStorage();
  }
}
