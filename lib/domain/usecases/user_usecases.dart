import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';

class UserUseCases {
  final UserRepository userRepository;
  UserUseCases({required this.userRepository});

  Future<Either<Failure, UserEntity>> getUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    return await userRepository.getUserViaApi(
      getOneUserFilter: getOneUserFilter,
    );
  }

  Future<Either<Failure, List<UserEntity>>> getUsersViaApi({
    required GetUsersFilter getUsersFilter,
  }) async {
    return await userRepository.getUsersViaApi(
      getUsersFilter: getUsersFilter,
    );
  }
}
