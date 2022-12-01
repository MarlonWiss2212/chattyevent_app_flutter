import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserViaApi(
      {String? userId, String? email});
  Future<Either<Failure, List<UserEntity>>> getUsersViaApi(String? search);
  Future<Either<Failure, UserEntity>> updateUserViaApi();
  Future<Either<Failure, UserEntity>> deleteUserViaApi();
}
