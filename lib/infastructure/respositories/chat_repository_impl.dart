import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/create_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/update_groupchat_dto.dart';
import 'package:social_media_app_flutter/core/dto/groupchat/groupchat_user/update_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_messages_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/core/filter/groupchat/get_one_groupchat_user_filter.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/response/get-all-groupchat-users-and-left-users.response.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_left_user_model.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_model.dart';
import 'package:social_media_app_flutter/infastructure/models/groupchat/groupchat_user_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final GraphQlDatasource graphQlDatasource;
  ChatRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, GroupchatEntity>> createGroupchatViaApi(
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
        /* give the users later back again with a diffrent response type 
        users {
          _id
          admin
          userId
          usernameForChat
          groupchatTo
          createdAt
          updatedAt
        }
        leftUsers {
          _id
          userId
          createdAt
          updatedAt
          groupchatTo
        }
        */
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
        return Left(GeneralFailure());
      }
      return Right(GroupchatModel.fromJson(response.data!["createGroupchat"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> getGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    GetMessagesFilter? getMessagesFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchat(\$findOneGroupchatInput: FindOneGroupchatInput!, \$messageInput: FindMessagesInput) {
          findGroupchat(findOneGroupchatInput: \$findOneGroupchatInput, findMessagesInput: \$messageInput) {
            _id
            title
            description
            profileImageLink
            messages {
              _id
              message
              messageToReactTo
              fileLink
              groupchatTo
              createdBy
              createdAt
            }
            createdBy
            createdAt
          }
        }
        """,
        variables: {
          "findOneGroupchatInput": getOneGroupchatFilter.toMap(),
          "messageInput": getMessagesFilter?.toMap()
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(GroupchatModel.fromJson(response.data!["findGroupchat"]));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupchatEntity>>> getGroupchatsViaApi({
    LimitOffsetFilterOptional? messageFilterForEveryGroupchat,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindGroupchats(\$messageFilterForEveryGroupchat: LimitOffsetFilterOptionalInput) {
          findGroupchats(messageFilterForEveryGroupchat: \$messageFilterForEveryGroupchat) {
            _id
            profileImageLink
            title
            messages {
              _id
              message
              messageToReactTo
              fileLink
              groupchatTo
              createdBy
              createdAt
            }
          }
        }
        """,
        variables: {
          "messageFilterForEveryGroupchat":
              messageFilterForEveryGroupchat?.toMap()
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      final List<GroupchatEntity> groupchats = [];
      for (final groupchat in response.data!["findGroupchats"]) {
        groupchats.add(GroupchatModel.fromJson(groupchat));
      }
      return Right(groupchats);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatEntity>> updateGroupchatViaApi({
    required GetOneGroupchatFilter getOneGroupchatFilter,
    required UpdateGroupchatDto updateGroupchatDto,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "updateGroupchatInput": updateGroupchatDto.toMap(),
        "findOneGroupchatInput": getOneGroupchatFilter.toMap(),
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
        mutation UpdateGroupchat(\$updateGroupchatInput: UpdateGroupchatInput, \$findOneGroupchatInput: FindOneGroupchatInput!, \$updateProfileImage: Upload) {
          updateGroupchat(updateGroupchatInput: \$updateGroupchatInput, findOneGroupchatInput: \$findOneGroupchatInput, updateProfileImage: \$updateProfileImage) {
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
        return Left(GeneralFailure());
      }
      return Right(GroupchatModel.fromJson(response.data!["updateGroupchat"]));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatUserEntity>> addUserToGroupchatViaApi({
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
            lastTimeOnline
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
                canInviteFollowedToPrivateEvent
                canInviteFollowedToGroupchat
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
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
            username
          }
        }
        """,
        variables: {
          "input": createGroupchatUserDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(
        GroupchatUserModel.fromJson(response.data!["addUserToGroupchat"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatLeftUserEntity?>>
      deleteUserFromGroupchatViaApi({
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteUserFromGroupchat(\$input: FindOneGroupchatUserInput!) {
          deleteUserFromGroupchat(findOneGroupchatUserInput: \$input) {
            groupchatUserLeftId
            _id
            authId
            leftChatAt
            groupchatTo
            birthdate
            createdAt
            firstname
            lastTimeOnline
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
                canInviteFollowedToPrivateEvent
                canInviteFollowedToGroupchat
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
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
        variables: {"input": getOneGroupchatUserFilter.toMap()},
      );

      if (response.hasException) {
        print(response.exception);

        return Left(GeneralFailure());
      }

      return Right(
        response.data != null
            ? GroupchatLeftUserModel.fromJson(
                response.data!["deleteUserFromGroupchat"],
              )
            : null,
      );
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GroupchatUserEntity>> updateGroupchatUserViaApi({
    required UpdateGroupchatUserDto updateGroupchatUserDto,
    required GetOneGroupchatUserFilter getOneGroupchatUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateGroupchatUser(\$updateGroupchatUserInput: UpdateGroupchatUserInput!, \$findOneGroupchatUserInput: FindOneGroupchatUserInput!) {
          updateGroupchatUser(updateGroupchatUserInput: \$updateGroupchatUserInput, findOneGroupchatUserInput: \$findOneGroupchatUserInput) {
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
            lastTimeOnline
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
                canInviteFollowedToPrivateEvent
                canInviteFollowedToGroupchat
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
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
        variables: {
          "updateGroupchatUserInput": updateGroupchatUserDto.toMap(),
          "findOneGroupchatUserInput": getOneGroupchatUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        print(response.exception);
        return Left(GeneralFailure());
      }

      return Right(
        GroupchatUserModel.fromJson(response.data!["updateGroupchatUser"]),
      );
    } catch (e) {
      print(e);

      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetAllGroupchatUsersAndLeftUsers>>
      getGroupchatUsersAndLeftUsers({
    required String groupchatId,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query GetAllGroupchatUsersAndLeftUsers(\$groupchatId: String!, \$limitOffsetInput: LimitOffsetInput!) {   
            findGroupchatLeftUsers(groupchatId: \$groupchatId, limitOffsetInput: \$limitOffsetInput) {
              groupchatUserLeftId
              _id
              authId
              leftChatAt
              groupchatTo
              birthdate
              createdAt
              firstname
              lastTimeOnline
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
                  canInviteFollowedToPrivateEvent
                  canInviteFollowedToGroupchat
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
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

            findGroupchatUsers(groupchatId: \$groupchatId, limitOffsetInput: \$limitOffsetInput) {
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
              lastTimeOnline
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
                  canInviteFollowedToPrivateEvent
                  canInviteFollowedToGroupchat
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
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
              username
            }
          }
        """,
        variables: {
          "groupchatId": groupchatId,
          "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        },
      );

      if (response.hasException) {
        print(response.exception);
        return Left(GeneralFailure());
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

      return Right(
        GetAllGroupchatUsersAndLeftUsers(
          groupchatLeftUsers: groupchatLeftUsers,
          groupchatUsers: groupchatUsers,
        ),
      );
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
