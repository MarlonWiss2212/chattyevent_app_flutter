import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_all_follower_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';

abstract class UserRelationRepository {
  Future<Either<Failure, UserRelationEntity>> createUserRelationViaApi({
    required CreateUserRelationDto createUserRelationDto,
  });
  Future<Either<Failure, UserRelationEntity>> getUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
  Future<Either<Failure, List<UserRelationEntity>>>
      getFollowerUserRelationsViaApi({
    required FindAllFollowerUserRelationFilter
        findAllFollowerUserRelationFilter,
  });
  Future<Either<Failure, UserRelationEntity>> acceptUserRelationViaApi({
    required RequestUserIdFilter requestUserIdFilter,
  });
  Future<Either<Failure, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  });
}
