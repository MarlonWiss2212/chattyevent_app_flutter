import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/core/dto/user/create_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/user/update_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/utils/failure_helper.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_users_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final GraphQlDatasource graphQlDatasource;
  UserRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, UserEntity>> getUserViaApi({
    required GetOneUserFilter getOneUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindUser(\$input: FindOneUserInput!) {
          findUser(filter: \$input) {
            _id
            firstname
            authId
            lastname
            username
            profileImageLink
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
                canInviteFollowedToPrivateEvent
                canInviteFollowedToGroupchat
                followedUserAt
              }
            }
          }
        }
        """,
        variables: {"input": getOneUserFilter.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden User Fehler",
          exception: response.exception!,
        ));
      }

      return Right(UserModel.fromJson(response.data!["findUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<UserEntity>>> getUsersViaApi({
    required GetUsersFilter getUsersFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindUsers(\$input: FindUsersInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findUsers(filter: \$input, limitOffsetInput: \$limitOffsetInput) {
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
          "input": getUsersFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );
      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Users Fehler",
          exception: response.exception!,
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
        """
        mutation UpdateUser(\$updateUserInput: UpdateUserInput, \$updateProfileImage: Upload) {
          updateUser(updateUserInput: \$updateUserInput, updateProfileImage: \$updateProfileImage) {
            _id
            firstname
            authId
            lastname
            username
            profileImageLink
          }
        }
        """,
        variables: variables,
      );
      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten User Fehler",
          exception: response.exception!,
        ));
      }
      return Right(UserModel.fromJson(response.data!["updateUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteUserViaApi() {
    // TODO: implement deleteUserViaApi
    throw UnimplementedError();
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
            _id
            firstname
            authId
            lastname
            username
            profileImageLink
          }
        }
        """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen User Fehler",
          exception: response.exception!,
        ));
      }

      return Right(UserModel.fromJson(response.data!["createUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
