import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user_relation/create_user_relation_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_followers_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

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
    required FindFollowersFilter findFollowersFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>>
      getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  });
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required FindFollowedFilter findFollowedFilter,
  });
  Future<Either<NotificationAlert, UserRelationEntity>>
      acceptFollowRequestViaApi({
    required String requesterUserId,
  });
  Future<Either<NotificationAlert, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
}
