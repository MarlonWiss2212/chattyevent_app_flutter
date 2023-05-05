import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/user_relation/update_user_relation_follow_data_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_followed_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_followers_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/user-relation/user_relation_entity.dart';
import 'package:chattyevent_app_flutter/core/filter/user_relation/find_one_user_relation_filter.dart';
import 'package:chattyevent_app_flutter/core/dto/user_relation/create_user_relation_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_relation_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user_relation/user_relation_model.dart';

class UserRelationRepositoryImpl extends UserRelationRepository {
  final GraphQlDatasource graphQlDatasource;
  UserRelationRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, UserRelationEntity>>
      createUserRelationViaApi({
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
              followedToPrivateEventPermission
              followedToGroupchatPermission
              followedUserAt
            }
          }
        }
        """,
        variables: {"input": createUserRelationDto.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Anfrage Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        UserRelationModel.fromJson(response.data!["createUserRelation"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserRelationEntity>> getUserRelationViaApi({
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
              followedToPrivateEventPermission
              followedToGroupchatPermission
              followedUserAt
            }
          }
        }
        """,
        variables: {"input": findOneUserRelationFilter.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden User Relation Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        UserRelationModel.fromJson(response.data!["findUserRelation"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowersViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required FindFollowersFilter findFollowersFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowers(\$limitOffsetFilter: LimitOffsetInput!, \$filter: FindFollowersInput!) {
          findFollowers(limitOffsetInput: \$limitOffsetFilter, filter: \$filter) {
            username
            _id
            authId
            birthdate
            createdAt
            firstname
            lastname
            profileImageLink
            updatedAt
            userRelationCounts {
              followerCount
              followedCount
              followRequestCount
            }
            myUserRelationToOtherUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
          }
        }
        """,
        variables: {
          "filter": findFollowersFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Followers Fehler",
          exception: response.exception!,
        ));
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowers"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<UserEntity>>>
      getFollowerRequestsViaApi({
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowRequests(\$limitOffsetFilter: LimitOffsetInput!) {
          findFollowRequests(limitOffsetInput: \$limitOffsetFilter) {
            username
            _id
            authId
            birthdate
            createdAt
            firstname
            lastname
            profileImageLink
            updatedAt
            userRelationCounts {
              followerCount
              followedCount
              followRequestCount
            }
            myUserRelationToOtherUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
          }
        }
        """,
        variables: {
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Follow Requests Fehler",
          exception: response.exception!,
        ));
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowRequests"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<UserEntity>>> getFollowedViaApi({
    required LimitOffsetFilter limitOffsetFilter,
    required FindFollowedFilter findFollowedFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindFollowed(\$filter: FindFollowedInput!, \$limitOffsetFilter: LimitOffsetInput!) {
          findFollowed(filter: \$filter, limitOffsetInput: \$limitOffsetFilter) {
            username
            _id
            authId
            birthdate
            createdAt
            firstname
            lastname
            profileImageLink
            updatedAt
            userRelationCounts {
              followerCount
              followedCount
              followRequestCount
            }
            myUserRelationToOtherUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedToPrivateEventPermission
                followedToGroupchatPermission
                followedUserAt
              }
            }
          }
        }
        """,
        variables: {
          "filter": findFollowedFilter.toMap(),
          "limitOffsetFilter": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Followed Fehler",
          exception: response.exception!,
        ));
      }
      final List<UserEntity> users = [];
      for (var user in response.data!["findFollowed"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserRelationEntity>>
      acceptFollowRequestViaApi({
    required String requesterUserId,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation AcceptFollowRequest(\$input: String!) {
          acceptFollowRequest(requesterUserId: \$input) {  
            _id
            createdAt
            updatedAt            
            statusOnRelatedUser
            followData {
              followedToPrivateEventPermission
              followedToGroupchatPermission
              followedUserAt
            }                
          }
        }
        """,
        variables: {"input": requesterUserId},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Akzeptieren Anfrage Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        UserRelationModel.fromJson(response.data!["acceptFollowRequest"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserRelationEntity>> updateFollowData({
    required UpdateUserRelationFollowDataDto updateUserRelationFollowDataDto,
    required String requesterUserId,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation UpdateFollowData(\$requesterUserId: String!, \$updateUserRelationFollowDataInput: UpdateUserRelationFollowDataInput!) {
          updateFollowData(requesterUserId: \$requesterUserId, updateUserRelationFollowDataInput: \$updateUserRelationFollowDataInput) {
            _id
            createdAt
            updatedAt            
            statusOnRelatedUser
            followData {
              followedToPrivateEventPermission
              followedToGroupchatPermission
              followedUserAt
            } 
          }
        }
        """,
        variables: {
          "requesterUserId": requesterUserId,
          "updateUserRelationFollowDataInput":
              updateUserRelationFollowDataDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten User Relation Fehler",
          exception: response.exception!,
        ));
      }

      return Right(
        UserRelationModel.fromJson(response.data!["updateFollowData"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteUserRelationViaApi({
    required FindOneUserRelationFilter findOneUserRelationFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        mutation DeleteUserRelation(\$filter: FindOneUserRelationInput!) {
          deleteUserRelation(filter: \$filter)
        }
        """,
        variables: {"filter": findOneUserRelationFilter.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen User Relation Fehler",
          exception: response.exception!,
        ));
      }

      return Right(response.data!["deleteUserRelation"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
