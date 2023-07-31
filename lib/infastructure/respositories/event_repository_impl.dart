import 'package:chattyevent_app_flutter/infastructure/models/event/event_left_user_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_model.dart';
import 'package:chattyevent_app_flutter/infastructure/models/event/event_user_model.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/create_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_left_user/create_event_left_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/create_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/update_event_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/dto/event/event_user/update_event_user_dto.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/groupchat/find_one_groupchat_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_one_event_to_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/find_events_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/event_left_user/find_event_left_users_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/event_user/find_one_event_user_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/event/event_user/find_event_users_filter.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-date.response.dart';
import 'package:chattyevent_app_flutter/core/response/event/event-users-and-left-users.reponse.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/event_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';

class EventRepositoryImpl implements EventRepository {
  final GraphQlDatasource graphQlDatasource;
  EventRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, EventEntity>> createEventViaApi(
    CreateEventDto createEventDto,
  ) async {
    try {
      final byteData = createEventDto.coverImage.readAsBytesSync();
      final multipartFile = MultipartFile.fromBytes(
        'photo',
        byteData,
        filename: '${createEventDto.title}.jpg',
        contentType: MediaType("image", "jpg"),
      );

      final response = await graphQlDatasource.mutation(
        """
        mutation CreateEvent(\$input: CreateEventInput!, \$coverImage: Upload!) {
          createEvent(createEventInput: \$input, coverImage: \$coverImage) {
            _id
            type
            privateEventData {
              groupchatTo
            }
            title
            description
            status
            coverImageLink
            eventDate
            eventEndDate
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
          "input": createEventDto.toMap(),
          "coverImage": multipartFile,
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Erstellen Event Fehler",
          response: response,
        ));
      }

      return Right(EventModel.fromJson(response.data!['createEvent']));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventEntity>> getEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindEvent(\$filter: FindOneEventInput!) {
          findEvent(filter: \$filter) {
            _id
            title
            type
            privateEventData {
              groupchatTo
            }
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
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "filter": findOneEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Event Fehler",
          response: response,
        ));
      }
      return Right(EventModel.fromJson(response.data!["findEvent"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventDataResponse>> getEventDataViaApi({
    required FindOneEventFilter findOneEventFilter,
    String? groupchatId,
  }) async {
    try {
      final variables = {
        "findEventLeftUsersInput": FindEventUsersFilter(
          eventTo: findOneEventFilter.eventId,
        ).toMap(),
        "findEventUsersInput": FindEventLeftUsersFilter(
          eventTo: findOneEventFilter.eventId,
        ).toMap(),
        "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        "filter": findOneEventFilter.toMap(),
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
        query FindEventData(\$filter: FindOneEventInput!, \$findEventLeftUsersInput: FindEventLeftUsersInput!, \$findEventUsersInput: FindEventUsersInput!, \$limitOffsetInput: LimitOffsetInput!, ${groupchatId == null ? '' : '\$findOneGroupchatInput: FindOneGroupchatInput!'}) {
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
          
          findEvent(filter: \$filter) {
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
            type
            privateEventData {
              groupchatTo
            }
            createdBy
            createdAt
          }

          findEventLeftUsers(filter: \$findEventLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
            eventUserLeftId
            username
            _id
            authId
            leftEventAt
            eventTo
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

          findEventUsers(filter: \$findEventUsersInput, limitOffsetInput: \$limitOffsetInput) {
            eventUserId
            username
            _id
            authId
            status
            role
            joinedEventAt
            eventTo
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
          title: "Finden Event Daten Fehler",
          response: response,
        ));
      }

      final List<EventLeftUserEntity> eventLeftUsers = [];
      for (var eventLeftUser in response.data!["findEventLeftUsers"]) {
        eventLeftUsers.add(
          EventLeftUserModel.fromJson(eventLeftUser),
        );
      }

      final List<EventUserEntity> eventUsers = [];
      for (var eventUser in response.data!["findEventUsers"]) {
        eventUsers.add(EventUserModel.fromJson(eventUser));
      }

      return Right(EventDataResponse(
        event: EventModel.fromJson(response.data!["findEvent"]),
        groupchat: null,
        eventLeftUsers: eventLeftUsers,
        eventUsers: eventUsers,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, List<EventEntity>>> getEventsViaApi({
    FindEventsFilter? findEventsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query("""
        query FindEvents(\$filter: FindEventsInput, \$limitOffsetInput: LimitOffsetInput!) {
          findEvents(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
            _id
            status
            title
            type
            privateEventData {
              groupchatTo
            }
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
        "filter": findEventsFilter?.toMap(),
        "limitOffsetInput": limitOffsetFilter.toMap(),
      });

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Events Fehler",
          response: response,
        ));
      }

      final List<EventEntity> events = [];
      for (var event in response.data!["findEvents"]) {
        events.add(EventModel.fromJson(event));
      }
      return Right(events);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventEntity>> updateEventViaApi({
    required UpdateEventDto updateEventDto,
    required FindOneEventFilter findOneEventFilter,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "filter": findOneEventFilter.toMap(),
        "updateEventInput": updateEventDto.toMap(),
      };
      if (updateEventDto.updateCoverImage != null) {
        final byteData = updateEventDto.updateCoverImage!.readAsBytesSync();
        final multipartFile = MultipartFile.fromBytes(
          'photo',
          byteData,
          filename: '${updateEventDto.title}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        variables.addAll({'updateCoverImage': multipartFile});
      }

      final response = await graphQlDatasource.mutation(
        """
        mutation UpdateEvent(\$filter: FindOneEventInput!, \$updateEventInput: UpdateEventInput, \$updateCoverImage: Upload) {
          updateEvent(filter: \$filter, updateEventInput: \$updateEventInput, updateCoverImage: \$updateCoverImage) {
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
            type
            privateEventData {
              groupchatTo
            }
            createdBy
            createdAt
          }
        }
      """,
        variables: variables,
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Event Fehler",
          response: response,
        ));
      }
      return Right(EventModel.fromJson(response.data!["updateEvent"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, bool>> deleteEventViaApi({
    required FindOneEventFilter findOneEventFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteEvent(\$filter: FindOneEventInput!) {
            deleteEvent(filter: \$filter)
          }
        """,
        variables: {
          "filter": findOneEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Löschen Event Fehler",
          response: response,
        ));
      }

      return Right(response.data!["deleteEvent"]);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventUserEntity>> updateEventUser({
    required UpdateEventUserDto updateEventUserDto,
    required FindOneEventUserFilter findOneEventUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation UpdateEventUser(\$input: UpdateEventUserInput!, \$filter: FindOneEventUserInput!) {
            updateUser(updateEventUserInput: \$input, filter: \$filter) {
              eventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              eventTo
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
          "input": updateEventUserDto.toMap(),
          "filter": findOneEventUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Updaten Event User Fehler",
          response: response,
        ));
      }
      return Right(EventUserModel.fromJson(response.data!["updateEventUser"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventUserEntity>> addUserToEventViaApi({
    required CreateEventUserDto createEventUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation AddUserToEvent(\$input: CreateEventUserInput!) {
            addUserToEvent(createEventUserInput: \$input) {
              eventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              eventTo
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
        variables: {"input": createEventUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User zum Event hinzufügen Fehler",
          response: response,
        ));
      }
      return Right(EventUserModel.fromJson(response.data!["addUserToEvent"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventLeftUserEntity>>
      deleteUserFromEventViaApi({
    required CreateEventLeftUserDto createEventLeftUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteUserFromEvent(\$createEventLeftUserInput: CreateEventLeftUserInput!) {
            deleteUserFromEvent(createEventLeftUserInput: \$createEventLeftUserInput) {
              eventUserLeftId
              username
              _id
              authId
              leftEventAt
              eventTo
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
          "createEventLeftUserInput": createEventLeftUserDto.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "User vom Event löschen Fehler",
          response: response,
        ));
      }
      return Right(
          EventLeftUserModel.fromJson(response.data!["deleteUserFromEvent"]));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, EventUsersAndLeftUsersResponse>>
      getEventUsersAndLeftUsers({
    required FindOneEventToFilter findOneEventToFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query EventUsersAndLeftUsersResponse(\$findEventLeftUsersInput: FindEventLeftUsersInput!, \$findEventUsersInput: FindEventUsersInput!, \$limitOffsetInput: LimitOffsetInput!) {   
            findEventLeftUsers(filter: \$findEventLeftUsersInput, limitOffsetInput: \$limitOffsetInput) {
              eventUserLeftId
              username
              _id
              authId
              leftEventAt
              eventTo
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

            findEventUsers(filter: \$findEventUsersInput, limitOffsetInput: \$limitOffsetInput) {
              eventUserId
              username
              _id
              authId
              status
              role
              joinedEventAt
              eventTo
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
          "findEventLeftUsersInput": FindEventUsersFilter(
            eventTo: findOneEventToFilter.eventTo,
          ).toMap(),
          "findEventUsersInput": FindEventLeftUsersFilter(
            eventTo: findOneEventToFilter.eventTo,
          ).toMap(),
          "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Finden Event User Fehler",
          response: response,
        ));
      }

      final List<EventLeftUserEntity> eventLeftUsers = [];
      for (var eventLeftUser in response.data!["findEventLeftUsers"]) {
        eventLeftUsers.add(EventLeftUserModel.fromJson(eventLeftUser));
      }

      final List<EventUserEntity> eventUsers = [];
      for (var eventUser in response.data!["findEventUsers"]) {
        eventUsers.add(EventUserModel.fromJson(eventUser));
      }

      return Right(EventUsersAndLeftUsersResponse(
        eventUsers: eventUsers,
        eventLeftUsers: eventLeftUsers,
      ));
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
