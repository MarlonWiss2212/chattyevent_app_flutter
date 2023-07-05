import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/create_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/user/update_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_one_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/user/find_users_filter.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final GraphQlDatasource graphQlDatasource;
  UserRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required FindOneUserFilter findOneUserFilter,
    required bool currentUser,
  }) async {
    try {
      // TODO new perrmission schema
      // firstname
      // lastname
      // birthdate
      final response = await graphQlDatasource.query(
        """
        query FindUser(\$filter: FindOneUserInput!) {
          findUser(filter: \$filter) {
            username
            _id
            authId
            createdAt      
            profileImageLink
            updatedAt
            userRelationCounts {
              followerCount
              followedCount
              followRequestCount
            }
            ${currentUser == true ? """
            permissions {
              groupchatAddMe {
                permission
                exceptUserIds
                selectedUserIds
              }
              privateEventAddMe {
                permission
                exceptUserIds
                selectedUserIds
              }
              calendarWatchIHaveTime
            }
            """ : """
            myUserRelationToOtherUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedUserAt
              }
            }
            """}
          }
        }
        """,
        variables: {"filter": findOneUserFilter.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden User Fehler",
          response: response,
        ));
      }

      return Right(UserModel.fromJson(response.data!["findUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required FindUsersFilter findUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindUsers(\$filter: FindUsersInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findUsers(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
            _id
            authId
            username
            profileImageLink
            myUserRelationToOtherUser {
              _id
              statusOnRelatedUser
            }
          }
        }
        """,
        variables: {
          "filter": findUsersFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );
      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Users Fehler",
          response: response,
        ));
      }
      final List<UserEntity> users = [];
      for (final user in response.data!["findUsers"]) {
        users.add(UserModel.fromJson(user));
      }

      return Right(users);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserEntity>> updateUserViaApi({
    required UpdateUserDto updateUserDto,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "updateUserInput": updateUserDto.toMap(),
      };
      if (updateUserDto.updateProfileImage != null) {
        final byteData = updateUserDto.updateProfileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${updateUserDto.username}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'updateProfileImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        // firstname
        // lastname
        // birthdate
        """
        mutation UpdateUser(\$updateUserInput: UpdateUserInput, \$updateProfileImage: Upload) {
          updateUser(updateUserInput: \$updateUserInput, updateProfileImage: \$updateProfileImage) {
            username
            _id
            authId
            createdAt
            profileImageLink
            updatedAt
            permissions {
              groupchatAddMe {
                permission
                exceptUserIds
                selectedUserIds
              }
              privateEventAddMe {
                permission
                exceptUserIds
                selectedUserIds
              }
              calendarWatchIHaveTime
            }
          }
        }
        """,
        variables: variables,
      );
      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten User Fehler",
          response: response,
        ));
      }
      return Right(UserModel.fromJson(response.data!["updateUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteUserViaApi() async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteUser {
          deleteUser
        }
        """,
      );
      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Delete User Fehler",
          response: response,
        ));
      }
      return Right(response.data!["updateUser"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, UserEntity>> createUserViaApi({
    required CreateUserDto createUserDto,
  }) async {
    try {
      Map<String, dynamic> variables = {"input": createUserDto.toMap()};

      if (createUserDto.profileImage != null) {
        final byteData = createUserDto.profileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${createUserDto.username}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({"profileImage": multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation CreateUser(\$input: CreateUserInput!,\$profileImage: Upload) {
          createUser(createUserInput: \$input, profileImage: \$profileImage) {
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
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              statusOnRelatedUser
              followData {
                followedUserAt
              }
            }
          }
        }
        """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen User Fehler",
          response: response,
        ));
      }

      return Right(UserModel.fromJson(response.data!["createUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
