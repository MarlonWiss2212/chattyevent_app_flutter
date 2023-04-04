import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/user/create_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
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
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await userRepository.getUsersViaApi(
      getUsersFilter: getUsersFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<Failure, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  }) async {
    return await userRepository.updateUserViaApi(
      updateUserDto: updateUserDto,
    );
  }

  Future<Either<Failure, bool>> deleteUserViaApi() async {
    return await userRepository.deleteUserViaApi();
  }
}
