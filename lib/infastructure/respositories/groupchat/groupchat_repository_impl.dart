import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_left_user/create_groupchat_left_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:chattyevent_app_flutter/core/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/find_one_groupchat_to_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_left_user/find_groupchat_left_users_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_user/find_groupchat_users_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/groupchat/groupchat_user/find_one_groupchat_user_filter.dart';
import 'package:chattyevent_app_flutter/core/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-data.response.dart';
import 'package:chattyevent_app_flutter/core/response/groupchat/groupchat-users-and-left-users.response.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/groupchat/groupchat_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_left_user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/groupchat/groupchat_user_model.dart';

class GroupchatRepositoryImpl implements GroupchatRepository {
  final GraphQlDatasource graphQlDatasource;
  GroupchatRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, GroupchatEntity>> createGroupchatViaApi(
    CreateGroupchatDto createGroupchatDto,
  ) async {
    try {
      Map<String, dynamic> variables = {
        "input": createGroupchatDto.toMap(),
      };
      if (createGroupchatDto.profileImage != null) {
        final byteData = createGroupchatDto.profileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${createGroupchatDto.title}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'profileImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation CreateGroupchat(\$input: CreateGroupchatInput!, \$profileImage: Upload) {
          createGroupchat(createGroupchatInput: \$input, profileImage: \$profileImage) {
            _id
            title
            description
            profileImageLink
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Chat Fehler",
          response: response,
        ));
      }
      return Right(GroupchatModel.fromJson(response.data!["createGroupchat"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatEntity>> getGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchat(\$filter: FindOneGroupchatInput!) {
          findGroupchat(filter: \$filter) {
            _id
            title
            description
            profileImageLink
            createdBy
            createdAt
          }
        }
        """,
        variables: {"filter": findOneGroupchatFilter.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Chat Fehler",
          response: response,
        ));
      }

      return Right(GroupchatModel.fromJson(response.data!["findGroupchat"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatAndGroupchatUsersResponse>>
      getGroupchatDataViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query GetGroupchatData(\$findGroupchatLeftUsersInput: FindGroupchatLeftUsersInput!, \$findGroupchatUsersInput: FindGroupchatUsersInput!, \$limitOffsetInput: LimitOffsetInput!, \$findOneGroupchatInput: FindOneGroupchatInput!) {   
            findGroupchat(filter: \$findOneGroupchatInput) {
              _id
              title
              description
              profileImageLink
              createdBy
              createdAt
            }

            findGroupchatLeftUsers(filter: \$findGroupchatLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
              groupchatUserLeftId
              _id
              authId
              leftChatAt
              groupchatTo
              birthdate
              createdAt
              firstname
              lastname
              profileImageLink
              updatedAt
              username
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

            findGroupchatUsers(filter: \$findGroupchatUsersInput, limitOffsetInput: \$limitOffsetInput) {
              groupchatUserId
              _id
              authId
              admin
              joinedChatAt
              groupchatTo
              usernameForChat
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
              username
            }
          }
        """,
        variables: {
          "findOneGroupchatInput": findOneGroupchatFilter.toMap(),
          "findGroupchatUsersInput": FindGroupchatUsersFilter(
            groupchatTo: findOneGroupchatFilter.groupchatId,
          ).toMap(),
          "findGroupchatLeftUsersInput": FindGroupchatLeftUsersFilter(
            groupchatTo: findOneGroupchatFilter.groupchatId,
          ).toMap(),
          "limitOffsetInput": LimitOffsetFilter(
            limit: 1000,
            offset: 0,
          ).toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden von Chat Daten Fehler",
          response: response,
        ));
      }

      final List<GroupchatUserEntity> groupchatUsers = [];
      for (var groupchatUser in response.data!["findGroupchatUsers"]) {
        groupchatUsers.add(GroupchatUserModel.fromJson(groupchatUser));
      }

      final List<GroupchatLeftUserEntity> groupchatLeftUsers = [];
      for (var groupchatLeftUser in response.data!["findGroupchatLeftUsers"]) {
        groupchatLeftUsers.add(
          GroupchatLeftUserModel.fromJson(groupchatLeftUser),
        );
      }

      return Right(GroupchatAndGroupchatUsersResponse(
        groupchatLeftUsers: groupchatLeftUsers,
        groupchatUsers: groupchatUsers,
        groupchat: GroupchatModel.fromJson(response.data!["findGroupchat"]),
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<GroupchatEntity>>>
      getGroupchatsViaApi() async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchats {
          findGroupchats {
            _id
            profileImageLink
            title
            latestMessage {
              _id
              message
              messageToReactTo
              fileLinks
              groupchatTo
              createdBy
              createdAt
            }
          }
        }
        """,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Chats Fehler",
          response: response,
        ));
      }

      final List<GroupchatEntity> groupchats = [];
      for (final groupchat in response.data!["findGroupchats"]) {
        groupchats.add(GroupchatModel.fromJson(groupchat));
      }
      return Right(groupchats);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatEntity>> updateGroupchatViaApi({
    required FindOneGroupchatFilter findOneGroupchatFilter,
    required UpdateGroupchatDto updateGroupchatDto,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "updateGroupchatInput": updateGroupchatDto.toMap(),
        "filter": findOneGroupchatFilter.toMap(),
      };
      if (updateGroupchatDto.updateProfileImage != null) {
        final byteData =
            updateGroupchatDto.updateProfileImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${updateGroupchatDto.title}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'updateProfileImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateGroupchat(\$updateGroupchatInput: UpdateGroupchatInput, \$filter: FindOneGroupchatInput!, \$updateProfileImage: Upload) {
          updateGroupchat(updateGroupchatInput: \$updateGroupchatInput, filter: \$filter, updateProfileImage: \$updateProfileImage) {
            _id
            title
            description
            profileImageLink
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Chat Fehler",
          response: response,
        ));
      }
      return Right(GroupchatModel.fromJson(response.data!["updateGroupchat"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatUserEntity>>
      addUserToGroupchatViaApi({
    required CreateGroupchatUserDto createGroupchatUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation AddUserToGroupchat(\$input: CreateGroupchatUserInput!) {
          addUserToGroupchat(createGroupchatUserInput: \$input) {
            groupchatUserId
            _id
            authId
            admin
            joinedChatAt
            groupchatTo
            usernameForChat
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
            username
          }
        }
        """,
        variables: {
          "input": createGroupchatUserDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User zum Chat Hinzufügen Fehler",
          response: response,
        ));
      }

      return Right(
        GroupchatUserModel.fromJson(response.data!["addUserToGroupchat"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required CreateGroupchatLeftUserDto createGroupchatLeftUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteUserFromGroupchat(\$input: CreateGroupchatLeftUserInput!) {
          deleteUserFromGroupchat(createGroupchatLeftUserInput: \$input) {
            groupchatUserLeftId
            _id
            authId
            leftChatAt
            groupchatTo
            birthdate
            createdAt
            firstname
            lastname
            profileImageLink
            updatedAt
            username
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
        variables: {"input": createGroupchatLeftUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User vom Chat entfernen Fehler",
          response: response,
        ));
      }

      return Right(
        response.data!["deleteUserFromGroupchat"] != null
            ? GroupchatLeftUserModel.fromJson(
                response.data!["deleteUserFromGroupchat"],
              )
            : null,
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatUserEntity>>
      updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required FindOneGroupchatUserFilter findOneGroupchatUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateGroupchatUser(\$updateGroupchatUserInput: UpdateGroupchatUserInput!, \$filter: FindOneGroupchatUserInput!) {
          updateGroupchatUser(updateGroupchatUserInput: \$updateGroupchatUserInput, filter: \$filter) {
            groupchatUserId
            usernameForChat
            admin
            _id
            authId
            joinedChatAt
            groupchatTo
            birthdate
            createdAt
            firstname
            lastname
            profileImageLink
            updatedAt
            username
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
        variables: {
          "updateGroupchatUserInput": updateGroupchatUserDto.toMap(),
          "filter": findOneGroupchatUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten vom Chat user Fehler",
          response: response,
        ));
      }

      return Right(
        GroupchatUserModel.fromJson(response.data!["updateGroupchatUser"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, GroupchatUsersAndLeftUsersResponse>>
      getGroupchatUsersAndLeftUsers({
    required FindOneGroupchatToFilter findOneGroupchatToFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query GetAllGroupchatUsersAndLeftUsers(\$findGroupchatLeftUsersInput: FindGroupchatLeftUsersInput!, \$findGroupchatUsersInput: FindGroupchatUsersInput!, \$limitOffsetInput: LimitOffsetInput!) {   
            findGroupchatLeftUsers(filter: \$findGroupchatLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
              groupchatUserLeftId
              _id
              authId
              leftChatAt
              groupchatTo
              birthdate
              createdAt
              firstname
              lastname
              profileImageLink
              updatedAt
              username
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

            findGroupchatUsers(filter: \$findGroupchatUsersInput, limitOffsetInput: \$limitOffsetInput) {
              groupchatUserId
              _id
              authId
              admin
              joinedChatAt
              groupchatTo
              usernameForChat
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
              username
            }
          }
        """,
        variables: {
          "findGroupchatUsersInput": FindGroupchatUsersFilter(
            groupchatTo: findOneGroupchatToFilter.groupchatTo,
          ).toMap(),
          "findGroupchatLeftUsersInput": FindGroupchatLeftUsersFilter(
            groupchatTo: findOneGroupchatToFilter.groupchatTo,
          ).toMap(),
          "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden von Chat Usern Fehler",
          response: response,
        ));
      }

      final List<GroupchatUserEntity> groupchatUsers = [];
      for (var groupchatUser in response.data!["findGroupchatUsers"]) {
        groupchatUsers.add(GroupchatUserModel.fromJson(groupchatUser));
      }

      final List<GroupchatLeftUserEntity> groupchatLeftUsers = [];
      for (var groupchatLeftUser in response.data!["findGroupchatLeftUsers"]) {
        groupchatLeftUsers.add(
          GroupchatLeftUserModel.fromJson(groupchatLeftUser),
        );
      }

      return Right(GroupchatUsersAndLeftUsersResponse(
        groupchatLeftUsers: groupchatLeftUsers,
        groupchatUsers: groupchatUsers,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
