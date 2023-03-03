import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/create_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';

class UserUseCases {
  final UserRepository userRepository;
  UserUseCases({required this.userRepository});

  Future<Either<Failure, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  }) async {
    return await userRepository.createUserViaApi(
      createUserDto: createUserDto,
    );
  }

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
