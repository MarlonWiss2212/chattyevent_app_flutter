import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/gql.dart';
import './../../injection.dart' as di;

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<Failure, String>> login(String email, String password) async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.login(email, password);

    String token = "";
    tokenOrFailure.fold(
      (error) => null,
      (resToken) {
        token = resToken;
      },
    );

    await authRepository.saveAuthTokenInStorage(token);
    await resetDiWithNewGraphQlLink(token);
    return tokenOrFailure;
  }

  Future<Either<Failure, String>> register(CreateUserDto createUserDto) async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.register(createUserDto);

    String token = "";
    tokenOrFailure.fold(
      (error) => null,
      (resToken) {
        token = resToken;
      },
    );

    await authRepository.saveAuthTokenInStorage(token);
    await resetDiWithNewGraphQlLink(token);
    return tokenOrFailure;
  }

  Future<Either<Failure, String>> getAuthTokenFromStorage() async {
    final Either<Failure, String> tokenOrFailure =
        await authRepository.getAuthTokenFromStorage();

    String token = "";
    tokenOrFailure.fold(
      (error) => null,
      (resToken) {
        token = resToken;
      },
    );
    await resetDiWithNewGraphQlLink(token);
    return tokenOrFailure;
  }

  Future<void> logout() async {
    // to reset auth token
    await di.serviceLocator.reset();
    await di.init();

    await authRepository.logout();
  }
}
