import 'package:chattyevent_app_flutter/infrastructure/dto/user_relation/update_user_relation_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user_relation/target_user_id_filter.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/user_relation/create_user_relation_dto.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user_relation/find_followers_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

/// Repository for handling user relation-related functionality.
abstract class UserRelationRepository {
  /// Creates a user relation via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserRelationEntity] when successful.
  Future<Either<NotificationAlert, UserRelationEntity>>
      createUserRelationViaApi({
    required CreateUserRelationDto createUserRelationDto,
  });

  /// Retrieves a user relation via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserRelationEntity] when successful.
  Future<Either<NotificationAlert, UserRelationEntity>> getUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });

  /// Retrieves followers via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [UserEntity] when successful.
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowersViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required FindFollowersFilter findFollowersFilter,
  });

  /// Retrieves follower requests via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [UserEntity] when successful.
  Future<Either<NotificationAlert, List<UserEntity>>>
      getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Retrieves followed users via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [UserEntity] when successful.
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required FindFollowedFilter findFollowedFilter,
  });

  /// Updates a user relation via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserRelationEntity] when successful.
  Future<Either<NotificationAlert, UserRelationEntity>>
      updateUserRelationViaApi({
    required UpdateUserRelationDto updateUserRelationDto,
    required TargetUserIdFilter targetUserIdFilter,
  });

  /// Accepts a follow request via API.
  /// Returns a [NotificationAlert] in case of an error or a [UserRelationEntity] when successful.
  Future<Either<NotificationAlert, UserRelationEntity>>
      acceptFollowRequestViaApi({
    required String requesterUserId,
  });

  /// Deletes a user relation via API.
  /// Returns a [NotificationAlert] in case of an error or a [bool] indicating success.
  Future<Either<NotificationAlert, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
}
