import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, String>> register(CreateUserDto createUserDto);
  Future<Either<Failure, String>> getAuthTokenFromStorage();
  Future<void> saveAuthTokenInStorage(String token);
  Future<void> logout();
}
