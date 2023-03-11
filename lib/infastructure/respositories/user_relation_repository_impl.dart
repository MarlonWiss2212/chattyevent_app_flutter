import 'package:social_media_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/request_user_id_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/filter/user_relation/find_all_follower_user_relation_filter.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/user_relation_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
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
          createUserRelation(createUserRelationDto: \$input) {
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
  Future<Either<Failure, List<UserRelationEntity>>>
      getFollowerUserRelationsViaApi({
    required FindAllFollowerUserRelationFilter
        findAllFollowerUserRelationFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowerUserRelations(\$input: FindAllFollowerUserRelationInput!) {
          findFollowerUserRelations(findAllFollowerUserRelationInput: \$input) {
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
        variables: {"input": findAllFollowerUserRelationFilter.toMap()},
      );

      if (response.hasException) {
        print(response.exception);
        return Left(GeneralFailure());
      }
      print(response.data);

      final List<UserRelationEntity> userRelations = [];
      for (var userRelation in response.data!["findFollowerUserRelations"]) {
        userRelations.add(UserRelationModel.fromJson(userRelation));
      }

      return Right(userRelations);
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserRelationEntity>> acceptUserRelationViaApi({
    required RequestUserIdFilter requestUserIdFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation AcceptUserRelation(\$input: RequestUserIdInput!) {
          acceptUserRelation(requestUserIdInput: \$input) {
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
        UserRelationModel.fromJson(response.data!["createUserRelation"]),
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
