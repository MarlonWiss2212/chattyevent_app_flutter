import 'package:social_media_app_flutter/core/filter/user_relation/target_user_id_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/user_relation_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/user/user_model.dart';
import 'package:social_media_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class UserRelationRepositoryImpl extends UserRelationRepository {
  final GraphQlDatasource graphQlDatasource;
  UserRelationRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, UserRelationEntity>> createUserRelationViaApi({
    required CreateUserRelationDto createUserRelationDto,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation CreateUserRelation(\$input: CreateUserRelationInput!) {
          createUserRelation(createUserRelationInput: \$input) {
            _id
            createdAt
            updatedAt
            targetUserId
            requesterUserId
            statusOnRelatedUser
            followData {
              canInviteFollowedToPrivateEvent
              canInviteFollowedToGroupchat
              followedUserAt
            }
          }
        }
        """,
        variables: {"input": createUserRelationDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        UserRelationModel.fromJson(response.data!["createUserRelation"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserRelationEntity>> getUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindUserRelation(\$input: FindOneUserRelation!) {
          findUserRelation(findOneUserRelation: \$input) {
            _id
            createdAt
            updatedAt
            targetUserId
            requesterUserId
            statusOnRelatedUser
            followData {
              canInviteFollowedToPrivateEvent
              canInviteFollowedToGroupchat
              followedUserAt
            }
          }
        }
        """,
        variables: {"input": findOneUserRelationFilter.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        UserRelationModel.fromJson(response.data!["findUserRelation"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFollowersViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required TargetUserIdFilter targetUserIdFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowers(\$limitOffsetFilter: LimitOffsetInput!, \$targetUserIdInput: TargetUserIdInput!) {
          findFollowers(limitOffsetInput: \$limitOffsetFilter, targetUserIdInput: \$targetUserIdInput) {
            _id
            authId
            username
            profileImageLink
            myUserRelationToOtherUser {
              _id
              statusOnRelatedUser
            }
            otherUserRelationToMyUser {
              _id
              statusOnRelatedUser
            }
          }
        }
        """,
        variables: {
          "targetUserIdInput": targetUserIdFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowers"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowRequests(\$limitOffsetFilter: LimitOffsetInput!) {
          findFollowRequests(LimitOffsetInput: \$limitOffsetFilter) {
            _id
            authId
            username
            profileImageLink
            myUserRelationToOtherUser {
              _id
              statusOnRelatedUser
            }
            otherUserRelationToMyUser {
              _id
              statusOnRelatedUser
            }
          }
        }
        """,
        variables: {
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowRequests"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowed(\$requestUserIdInput: RequestUserIdInput!, \$limitOffsetFilter: LimitOffsetInput!) {
          findFollowed(requestUserIdInput: \$requestUserIdInput, LimitOffsetInput: \$limitOffsetFilter) {
            _id
            authId
            username
            profileImageLink
            myUserRelationToOtherUser {
              _id
              statusOnRelatedUser
            }
            otherUserRelationToMyUser {
              _id
              statusOnRelatedUser
            }
          }
        }
        """,
        variables: {
          "requestUserIdInput": requestUserIdFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowed"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserRelationEntity>> acceptFollowRequestViaApi({
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation AcceptFollowRequest(\$input: RequestUserIdInput!) {
          acceptFollowRequest(requestUserIdInput: \$input) {
            _id
            createdAt
            updatedAt
            targetUserId
            requesterUserId
            statusOnRelatedUser
            followData {
              canInviteFollowedToPrivateEvent
              canInviteFollowedToGroupchat
              followedUserAt
            }
          }
        }
        """,
        variables: {"input": requestUserIdFilter.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        UserRelationModel.fromJson(response.data!["acceptFollowRequest"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation DeleteUserRelation(\$input: FindOneUserRelationInput!) {
          deleteUserRelation(findOneUserRelationInput: \$input)
        }
        """,
        variables: {"input": findOneUserRelationFilter.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(response.data!["deleteUserRelation"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
