import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/target_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/user_relation_repository.dart';

class UserRelationUseCases {
  final UserRelationRepository userRelationRepository;
  UserRelationUseCases({required this.userRelationRepository});

  Future<Either<NotificationAlert, UserRelationEntity>>
      createUserRelationViaApi({
    required CreateUserRelationDto createUserRelationDto,
  }) async {
    return await userRelationRepository.createUserRelationViaApi(
      createUserRelationDto: createUserRelationDto,
    );
  }

  Future<Either<NotificationAlert, UserRelationEntity>> getUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  }) async {
    return await userRelationRepository.getUserRelationViaApi(
      findOneUserRelationFilter: findOneUserRelationFilter,
    );
  }

  Future<Either<NotificationAlert, List<UserEntity>>> getFollowersViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required TargetUserIdFilter targetUserIdFilter,
  }) async {
    return await userRelationRepository.getFollowersViaApi(
      limitOffsetFilter: limitOffsetFilter,
      targetUserIdFilter: targetUserIdFilter,
    );
  }

  Future<Either<NotificationAlert, List<UserEntity>>>
      getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await userRelationRepository.getFollowerRequestsViaApi(
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    return await userRelationRepository.getFollowedViaApi(
      limitOffsetFilter: limitOffsetFilter,
      requestUserIdFilter: requestUserIdFilter,
    );
  }

  Future<Either<NotificationAlert, UserRelationEntity>>
      acceptFollowRequestViaApi({
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    return await userRelationRepository.acceptFollowRequestViaApi(
      requestUserIdFilter: requestUserIdFilter,
    );
  }

  Future<Either<NotificationAlert, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  }) async {
    return await userRelationRepository.deleteUserRelationViaApi(
      findOneUserRelationFilter: findOneUserRelationFilter,
    );
  }

  Future<Either<NotificationAlert, Either<UserRelationEntity, bool>>>
      followOrUnfollowUserViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
    required UserRelationEntity? myUserRelationToOtherUser,
  }) async {
    if (myUserRelationToOtherUser?.statusOnRelatedUser != "follower" &&
        myUserRelationToOtherUser?.statusOnRelatedUser != "requestToFollow") {
      final userRelationOrNotificationAlert =
          await userRelationRepository.createUserRelationViaApi(
              createUserRelationDto: CreateUserRelationDto(
        targetUserId: findOneUserRelationFilter.targetUserId,
      ));
      return userRelationOrNotificationAlert.fold(
        (error) => Left(error),
        (userRelation) => Right(Left(userRelation)),
      );
    } else {
      final booleanOrNotificationAlert =
          await userRelationRepository.deleteUserRelationViaApi(
        findOneUserRelationFilter: findOneUserRelationFilter,
      );

      return booleanOrNotificationAlert.fold(
        (error) => Left(error),
        (boolean) => Right(Right(boolean)),
      );
    }
  }
}
