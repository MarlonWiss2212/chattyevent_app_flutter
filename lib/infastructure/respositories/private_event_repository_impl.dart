import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/create_private_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_left_user/create_private_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/update_private_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_one_private_event_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_one_private_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/find_private_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/private_event_left_user/find_private_event_left_users_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/private_event_user/find_one_private_event_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/private_event/private_event_user/find_private_event_users_filter.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/private-event/private-events-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_left_user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/private_event/private_event_user_model.dart';

class PrivateEventRepositoryImpl implements PrivateEventRepository {
  final GraphQlDatasource graphQlDatasource;
  PrivateEventRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, PrivateEventEntity>>
      createPrivateEventViaApi(
    CreatePrivateEventDto createPrivateEventDto,
  ) async {
    try {
      final byteData = createPrivateEventDto.coverImage.readAsBytesSync();
      final multipartFile = MultipartFile.fromBytes(
        'photo',
        byteData,
        filename: '${createPrivateEventDto.title}.jpg',
        contentType: MediaType("image", "jpg"),
      );

      final response = await graphQlDatasource.mutation(
        """
        mutation CreatePrivatEvent(\$input: CreatePrivateEventInput!, \$coverImage: Upload!) {
          createPrivateEvent(createPrivateEventInput: \$input, coverImage: \$coverImage) {
            _id
            title
            description
            status
            coverImageLink
            eventDate
            eventEndDate
            groupchatTo
            eventLocation {
              geoJson {
                type
                coordinates
              }
              address {
                zip
                city
                country
                street
                housenumber
              }
            }
            permissions {
              changeTitle
              changeDescription
              changeCoverImage
              changeAddress
              changeDate
              changeStatus
              addUsers
              addShoppingListItem
              updateShoppingListItem
              deleteShoppingListItem
            }
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "input": createPrivateEventDto.toMap(),
          "coverImage": multipartFile,
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Privates Event Fehler",
          response: response,
        ));
      }

      return Right(
        PrivateEventModel.fromJson(response.data!['createPrivateEvent']),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventEntity>> getPrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindPrivateEvent(\$filter: FindOnePrivateEventInput!) {
          findPrivateEvent(filter: \$filter) {
            _id
            title
            status
            coverImageLink
            description
            eventLocation {
              geoJson {
                type
                coordinates
              }
              address {
                zip
                city
                country
                street
                housenumber
              }
            }
            permissions {
              changeTitle
              changeDescription
              changeCoverImage
              changeAddress
              changeDate
              changeStatus
              addUsers
              addShoppingListItem
              updateShoppingListItem
              deleteShoppingListItem
            }
            eventDate
            eventEndDate
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "filter": findOnePrivateEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Privates Event Fehler",
          response: response,
        ));
      }
      return Right(
        PrivateEventModel.fromJson(response.data!["findPrivateEvent"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventDataResponse>>
      getPrivateEventDataViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
    String? groupchatId,
  }) async {
    try {
      final variables = {
        "findPrivateEventLeftUsersInput": FindPrivateEventUsersFilter(
          privateEventTo: findOnePrivateEventFilter.privateEventId,
        ).toMap(),
        "findPrivateEventUsersInput": FindPrivateEventLeftUsersFilter(
          privateEventTo: findOnePrivateEventFilter.privateEventId,
        ).toMap(),
        "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        "filter": findOnePrivateEventFilter.toMap(),
      };

      if (groupchatId != null) {
        variables.addAll({
          "findOneGroupchatInput": FindOneGroupchatFilter(
            groupchatId: groupchatId,
          ).toMap(),
        });
      }
      final response = await graphQlDatasource.query(
        """
        query FindPrivateEventData(\$filter: FindOnePrivateEventInput!, \$findPrivateEventLeftUsersInput: FindPrivateEventLeftUsersInput!, \$findPrivateEventUsersInput: FindPrivateEventUsersInput!, \$limitOffsetInput: LimitOffsetInput!, ${groupchatId == null ? '' : '\$findOneGroupchatInput: FindOneGroupchatInput!'}) {
          ${groupchatId == null ? '' : '''
          findGroupchat(filter: \$findOneGroupchatInput) {
            _id
            title
            description
            profileImageLink
            createdBy
            createdAt
          }
          '''}
          
          findPrivateEvent(filter: \$filter) {
            _id
            title
            status
            coverImageLink
            description
            eventLocation {
              geoJson {
                type
                coordinates
              }
              address {
                zip
                city
                country
                street
                housenumber
              }
            }
            permissions {
              changeTitle
              changeDescription
              changeCoverImage
              changeAddress
              changeDate
              changeStatus
              addUsers
              addShoppingListItem
              updateShoppingListItem
              deleteShoppingListItem
            }
            eventDate
            eventEndDate
            groupchatTo
            createdBy
            createdAt
          }

          findPrivateEventLeftUsers(filter: \$findPrivateEventLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
            privateEventUserLeftId
            username
            _id
            authId
            leftEventAt
            privateEventTo
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
              status
              followData {
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              status
              followData {
                followedUserAt
              }
            } 
          }

          findPrivateEventUsers(filter: \$findPrivateEventUsersInput, limitOffsetInput: \$limitOffsetInput) {
            privateEventUserId
            username
            _id
            authId
            status
            role
            joinedEventAt
            privateEventTo
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
              status
              followData {
                followedUserAt
              }
            }
            otherUserRelationToMyUser {
              _id
              createdAt
              updatedAt
              status
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
          title: "Finden Privates Event Daten Fehler",
          response: response,
        ));
      }

      final List<PrivateEventLeftUserEntity> privateEventLeftUsers = [];
      for (var privateEventLeftUser
          in response.data!["findPrivateEventLeftUsers"]) {
        privateEventLeftUsers.add(
          PrivateEventLeftUserModel.fromJson(privateEventLeftUser),
        );
      }

      final List<PrivateEventUserEntity> privateEventUsers = [];
      for (var privateEventUser in response.data!["findPrivateEventUsers"]) {
        privateEventUsers.add(PrivateEventUserModel.fromJson(privateEventUser));
      }

      return Right(PrivateEventDataResponse(
        privateEvent: PrivateEventModel.fromJson(
          response.data!["findPrivateEvent"],
        ),
        groupchat: null,
        privateEventLeftUsers: privateEventLeftUsers,
        privateEventUsers: privateEventUsers,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<PrivateEventEntity>>>
      getPrivateEventsViaApi({
    FindPrivateEventsFilter? findPrivateEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query("""
        query FindPrivateEvents(\$filter: FindPrivateEventsInput, \$limitOffsetInput: LimitOffsetInput!) {
          findPrivateEvents(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
            _id
            status
            title
            groupchatTo
            eventDate
            eventEndDate
            eventLocation {
              geoJson {
                type
                coordinates
              }
            }
            coverImageLink
          }
        }
      """, variables: {
        "filter": findPrivateEventsFilter?.toMap(),
        "limitOffsetInput": limitOffsetFilter.toMap(),
      });

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Private Events Fehler",
          response: response,
        ));
      }

      final List<PrivateEventEntity> privateEvents = [];
      for (var privateEvent in response.data!["findPrivateEvents"]) {
        privateEvents.add(PrivateEventModel.fromJson(privateEvent));
      }
      return Right(privateEvents);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventEntity>>
      updatePrivateEventViaApi({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "filter": findOnePrivateEventFilter.toMap(),
        "updatePrivateEventInput": updatePrivateEventDto.toMap(),
      };
      if (updatePrivateEventDto.updateCoverImage != null) {
        final byteData =
            updatePrivateEventDto.updateCoverImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${updatePrivateEventDto.title}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'updateCoverImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation UpdatePrivateEvent(\$filter: FindOnePrivateEventInput!, \$updatePrivateEventInput: UpdatePrivateEventInput, \$updateCoverImage: Upload) {
          updatePrivateEvent(filter: \$filter, updatePrivateEventInput: \$updatePrivateEventInput, updateCoverImage: \$updateCoverImage) {
            _id
            title
            status
            coverImageLink
            description
            eventLocation {
              geoJson {
                type
                coordinates
              }
              address {
                zip
                city
                country
                street
                housenumber
              }
            }
            permissions {
              changeTitle
              changeDescription
              changeCoverImage
              changeAddress
              changeDate
              changeStatus
              addUsers
              addShoppingListItem
              updateShoppingListItem
              deleteShoppingListItem
            }
            eventDate
            eventEndDate
            groupchatTo
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Privates Event Fehler",
          response: response,
        ));
      }
      return Right(
        PrivateEventModel.fromJson(response.data!["updatePrivateEvent"]),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deletePrivateEventViaApi({
    required FindOnePrivateEventFilter findOnePrivateEventFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeletePrivateEvent(\$filter: FindOnePrivateEventInput!) {
            deletePrivateEvent(filter: \$filter)
          }
        """,
        variables: {
          "filter": findOnePrivateEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen Privates Event Fehler",
          response: response,
        ));
      }

      return Right(response.data!["deletePrivateEvent"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required FindOnePrivateEventUserFilter findOnePrivateEventUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation UpdatePrivateEventUser(\$input: UpdatePrivateEventUserInput!, \$filter: FindOnePrivateEventUserInput!) {
            updatePrivateEventUser(updatePrivateEventUserInput: \$input, filter: \$filter) {
              privateEventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              privateEventTo
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
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
            }
          }
        """,
        variables: {
          "input": updatePrivateEventUserDto.toMap(),
          "filter": findOnePrivateEventUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Privates Event User Fehler",
          response: response,
        ));
      }
      return Right(
        PrivateEventUserModel.fromJson(
          response.data!["updatePrivateEventUser"],
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventUserEntity>>
      addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation AddUserToPrivateEvent(\$input: CreatePrivateEventUserInput!) {
            addUserToPrivateEvent(createPrivateEventUserInput: \$input) {
              privateEventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              privateEventTo
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
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
            }
          }
        """,
        variables: {"input": createPrivateEventUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User zum Privaten Event hinzufügen Fehler",
          response: response,
        ));
      }
      return Right(
        PrivateEventUserModel.fromJson(
          response.data!["addUserToPrivateEvent"],
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required CreatePrivateEventLeftUserDto createPrivateEventLeftUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteUserFromPrivateEvent(\$createPrivateEventLeftUserInput: CreatePrivateEventLeftUserInput!) {
            deleteUserFromPrivateEvent(createPrivateEventLeftUserInput: \$createPrivateEventLeftUserInput) {
              privateEventUserLeftId
              username
              _id
              authId
              leftEventAt
              privateEventTo
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
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
            }
          }
        """,
        variables: {
          "createPrivateEventLeftUserInput":
              createPrivateEventLeftUserDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User vom Privaten Event löschen Fehler",
          response: response,
        ));
      }
      return Right(
        PrivateEventLeftUserModel.fromJson(
          response.data!["deleteUserFromPrivateEvent"],
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, PrivateEventUsersAndLeftUsersResponse>>
      getPrivateEventUsersAndLeftUsers({
    required FindOnePrivateEventToFilter findOnePrivateEventToFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query PrivateEventUsersAndLeftUsersResponse(\$findPrivateEventLeftUsersInput: FindPrivateEventLeftUsersInput!, \$findPrivateEventUsersInput: FindPrivateEventUsersInput!, \$limitOffsetInput: LimitOffsetInput!) {   
            findPrivateEventLeftUsers(filter: \$findPrivateEventLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
              privateEventUserLeftId
              username
              _id
              authId
              leftEventAt
              privateEventTo
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
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              } 
            }

            findPrivateEventUsers(filter: \$findPrivateEventUsersInput, limitOffsetInput: \$limitOffsetInput) {
              privateEventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              privateEventTo
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
                status
                followData {
                  followedUserAt
                }
              }
              otherUserRelationToMyUser {
                _id
                createdAt
                updatedAt
                status
                followData {
                  followedUserAt
                }
              }
            }
          }
        """,
        variables: {
          "findPrivateEventLeftUsersInput": FindPrivateEventUsersFilter(
            privateEventTo: findOnePrivateEventToFilter.privateEventTo,
          ).toMap(),
          "findPrivateEventUsersInput": FindPrivateEventLeftUsersFilter(
            privateEventTo: findOnePrivateEventToFilter.privateEventTo,
          ).toMap(),
          "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Privates Event User Fehler",
          response: response,
        ));
      }

      final List<PrivateEventLeftUserEntity> privateEventLeftUsers = [];
      for (var privateEventLeftUser
          in response.data!["findPrivateEventLeftUsers"]) {
        privateEventLeftUsers.add(
          PrivateEventLeftUserModel.fromJson(privateEventLeftUser),
        );
      }

      final List<PrivateEventUserEntity> privateEventUsers = [];
      for (var privateEventUser in response.data!["findPrivateEventUsers"]) {
        privateEventUsers.add(PrivateEventUserModel.fromJson(privateEventUser));
      }

      return Right(
        PrivateEventUsersAndLeftUsersResponse(
          privateEventUsers: privateEventUsers,
          privateEventLeftUsers: privateEventLeftUsers,
        ),
      );
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
