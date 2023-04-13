import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/user/create_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';

abstract class UserRepository {
  Future<Either<NotificationAlert, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  });
  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required GetUsersFilter getUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  });
  Future<Either<NotificationAlert, bool>> deleteUserViaApi();
}
