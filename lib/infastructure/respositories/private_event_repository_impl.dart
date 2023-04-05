import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/private_event_user/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/filter/limit_offset_filter/limit_offset_filter.dart';
import 'package:social_media_app_flutter/core/filter/private_event/private_event_user/get_one_private_event_user_filter.dart';
import 'package:social_media_app_flutter/core/response/get-all-private-events-users-and-left-users.reponse.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event/private_event_left_user_model.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event/private_event_model.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event/private_event_user_model.dart';

class PrivateEventRepositoryImpl implements PrivateEventRepository {
  final GraphQlDatasource graphQlDatasource;
  PrivateEventRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
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
              latitude
              longitude
              zip
              city
              country
              street
              housenumber
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
        return Left(GeneralFailure());
      }

      return Right(
        PrivateEventModel.fromJson(response.data!['createPrivateEvent']),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
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
              latitude
              longitude
              zip
              city
              country
              street
              housenumber
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
          "filter": getOnePrivateEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventModel.fromJson(response.data!["findPrivateEvent"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PrivateEventEntity>>> getPrivateEventsViaApi({
    GetPrivateEventsFilter? getPrivateEventsFilter,
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
              latitude
              longitude
            }
            coverImageLink
          }
        }
      """, variables: {
        "filter": getPrivateEventsFilter?.toMap(),
        "limitOffsetInput": limitOffsetFilter.toMap(),
      });

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      final List<PrivateEventEntity> privateEvents = [];
      for (var privateEvent in response.data!["findPrivateEvents"]) {
        privateEvents.add(PrivateEventModel.fromJson(privateEvent));
      }
      return Right(privateEvents);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi({
    required UpdatePrivateEventDto updatePrivateEventDto,
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    try {
      Map<String, dynamic> variables = {
        "findOnePrivateEventInput": getOnePrivateEventFilter.toMap(),
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
        mutation UpdatePrivateEvent(\$findOnePrivateEventInput: FindOnePrivateEventInput!, \$updatePrivateEventInput: UpdatePrivateEventInput, \$updateCoverImage: Upload) {
          updatePrivateEvent(findOnePrivateEventInput: \$findOnePrivateEventInput, updatePrivateEventInput: \$updatePrivateEventInput, updateCoverImage: \$updateCoverImage) {
            _id
            title
            status
            coverImageLink
            description
            eventLocation {
              latitude
              longitude
              zip
              city
              country
              street
              housenumber
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
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventModel.fromJson(response.data!["updatePrivateEvent"]),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deletePrivateEventViaApi({
    required GetOnePrivateEventFilter getOnePrivateEventFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeletePrivateEvent(\$filter: FindOnePrivateEventInput!) {
            deletePrivateEvent(filter: \$filter)
          }
        """,
        variables: {
          "filter": getOnePrivateEventFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }

      return Right(response.data!["deletePrivateEvent"]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation UpdatePrivateEventUser(\$input: UpdatePrivateEventUserInput!, \$findOnePrivateEventUserInput: FindOnePrivateEventUserInput!) {
            updatePrivateEventUser(updatePrivateEventUserInput: \$input, findOnePrivateEventUserInput: \$findOnePrivateEventUserInput) {
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
              organizer
            }
          }
        """,
        variables: {
          "input": updatePrivateEventUserDto.toMap(),
          "findOnePrivateEventUserInput": getOnePrivateEventUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventUserModel.fromJson(
          response.data!["updatePrivateEventUser"],
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventUserEntity>> addUserToPrivateEventViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation AddUserToPrivateEvent(\$input: CreatePrivateEventUserInput!) {
            addUserToPrivateEvent(createPrivateEventUserInput: \$input) {
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
              organizer
            }
          }
        """,
        variables: {"input": createPrivateEventUserDto.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventUserModel.fromJson(
          response.data!["addUserToPrivateEvent"],
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventLeftUserEntity>>
      deleteUserFromPrivateEventViaApi({
    required GetOnePrivateEventUserFilter getOnePrivateEventUserFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation DeleteUserFromPrivateEvent(\$filter: FindOnePrivateEventUserInput!) {
            deleteUserFromPrivateEvent(filter: \$filter) {
              _id
              privateEventTo
              userId
              createdAt
              updatedAt
            }
          }
        """,
        variables: {
          "filter": getOnePrivateEventUserFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventLeftUserModel.fromJson(
          response.data!["deleteUserFromPrivateEvent"],
        ),
      );
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetAllPrivateEventUsersAndLeftUsers>>
      getAllPrivateEventUsersAndLeftUsers({
    required String privateEventId,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
          query GetAllPrivateEventUsersAndLeftUsers(\$privateEventId: String!, \$limitOffsetInput: LimitOffsetInput!) {   
            findPrivateEventLeftUsers(privateEventId: \$privateEventId, limitOffsetInput: \$limitOffsetInput) {
              _id
              privateEventTo
              userId
              createdAt
              updatedAt
            }

            findPrivateEventUsers(privateEventId: \$privateEventId, limitOffsetInput: \$limitOffsetInput) {
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
              organizer
            }
          }
        """,
        variables: {
          "privateEventId": privateEventId,
          "limitOffsetInput": LimitOffsetFilter(limit: 1000, offset: 0).toMap(),
        },
      );

      if (response.hasException) {
        print(response.exception);

        return Left(GeneralFailure());
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
        GetAllPrivateEventUsersAndLeftUsers(
          privateEventUsers: privateEventUsers,
          privateEventLeftUsers: privateEventLeftUsers,
        ),
      );
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
