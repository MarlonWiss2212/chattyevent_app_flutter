import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_and_token_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import './../../injection.dart' as di;

class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases({required this.authRepository});

  Future<Either<Failure, UserAndTokenEntity>> login(
    String email,
    String password,
  ) async {
    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authRepository.login(email, password);

    await authOrFailure.fold(
      (error) => null,
      (userAndToken) async {
        await authRepository.saveAuthTokenInStorage(userAndToken.accessToken);
      },
    );
    return authOrFailure;
  }

  Future<Either<Failure, UserAndTokenEntity>> register(
    CreateUserDto createUserDto,
  ) async {
    final Either<Failure, UserAndTokenEntity> authOrFailure =
        await authRepository.register(createUserDto);

    await authOrFailure.fold(
      (error) => null,
      (userAndToken) async {
        await authRepository.saveAuthTokenInStorage(userAndToken.accessToken);
      },
    );
    return authOrFailure;
  }

  Future<Either<Failure, String>> getAuthTokenFromStorage() async {
    final Either<Failure, String> authOrFailure =
        await authRepository.getAuthTokenFromStorage();
    return authOrFailure;
  }

  Future<void> logout() async {
    await di.serviceLocator.reset();
    await di.init();
    await authRepository.logout();
  }
}
