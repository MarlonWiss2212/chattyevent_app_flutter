import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  });
  Future<Either<Failure, List<UserEntity>>> getUsersViaApi(String? search);
  Future<Either<Failure, UserEntity>> updateUserViaApi();
  Future<Either<Failure, UserEntity>> deleteUserViaApi();
}
