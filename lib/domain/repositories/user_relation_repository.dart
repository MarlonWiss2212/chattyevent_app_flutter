import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/target_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';

abstract class UserRelationRepository {
  Future<Either<NotificationAlert, UserRelationEntity>>
      createUserRelationViaApi({
    required CreateUserRelationDto createUserRelationDto,
  });
  Future<Either<NotificationAlert, UserRelationEntity>> getUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowersViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required TargetUserIdFilter targetUserIdFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>>
      getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required RequestUserIdFilter requestUserIdFilter,
  });
  Future<Either<NotificationAlert, UserRelationEntity>>
      acceptFollowRequestViaApi({
    required RequestUserIdFilter requestUserIdFilter,
  });
  Future<Either<NotificationAlert, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
}
