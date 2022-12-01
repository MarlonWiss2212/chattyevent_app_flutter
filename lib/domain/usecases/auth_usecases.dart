import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<Failure, String>> login(String email, String password) async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.login(email, password);

    await tokenOrFailure.fold(
      (error) => null,
      (token) async => await authRepository.saveAuthTokenInStorage(token),
    );

    return tokenOrFailure;
  }

  Future<Either<Failure, String>> register(
      String email, String password) async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.register(email, password);

    await tokenOrFailure.fold(
      (error) => null,
      (token) async => await authRepository.saveAuthTokenInStorage(token),
    );
    return tokenOrFailure;
  }

  Future<Either<Failure, String>> getAuthTokenFromStorage() async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.getAuthTokenFromStorage();

    await tokenOrFailure.fold((error) => null,
        (token) async => await authRepository.saveAuthTokenInStorage(token));
    return tokenOrFailure;
  }
}
