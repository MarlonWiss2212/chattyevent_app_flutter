import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/user/create_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

/// Repository for handling user-related functionality.
abstract class UserRepository {
  /// Creates a user via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserEntity] when successful.
  Future<Either<NotificationAlert, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  });

  /// Retrieves a user via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserEntity] when successful.
  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required FindOneUserFilter findOneUserFilter,
    required bool currentUser,
  });

  /// Retrieves users via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [UserEntity] when successful.
  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required FindUsersFilter findUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Updates a user via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserEntity] when successful.
  Future<Either<NotificationAlert, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  });

  /// Deletes the current user via API.
  /// Returns a [NotificationAlert] in case of an error or a [boolean] indicating success.
  Future<Either<NotificationAlert, bool>> deleteUserViaApi();
}
