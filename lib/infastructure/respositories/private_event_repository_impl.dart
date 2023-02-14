import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/filter/get_private_events_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
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
            coverImageLink
            users {
              isInvitedIndependetFromGroupchat
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
            }
            eventDate
            connectedGroupchat
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
        //coverImageLink
        """
        query FindPrivateEvent(\$input: FindOnePrivateEventInput!) {
          findPrivateEvent(filter: \$input) {
            _id
            title
            users {
              isInvitedIndependetFromGroupchat
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
            }
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
            connectedGroupchat
            createdBy
            createdAt
          }
        }
      """,
        variables: {
          "input": getOnePrivateEventFilter.toMap(),
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
  }) async {
    try {
      final response = await graphQlDatasource.query("""
        query FindPrivateEvents(\$input: FindPrivateEventsInput) {
          findPrivateEvents(filter: \$input) {
            _id
            title
            connectedGroupchat
            eventDate
            eventLocation {
              latitude
              longitude
            }
            coverImageLink
          }
        }
      """, variables: {
        "input": getPrivateEventsFilter?.toMap(),
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
  Future<Either<Failure, PrivateEventEntity>> updatePrivateEventViaApi() {
    // TODO: implement updatePrivateEventViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePrivateEventViaApi() {
    // TODO: implement deletePrivateEventViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
    required String privateEventId,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation UpdatePrivateEventUser(\$privateEventId: String!, \$input: UpdatePrivateEventUserInput!) {
            updatePrivateEventUser(privateEventId: \$privateEventId, updatePrivateEventUserInput: \$input) {
              isInvitedIndependetFromGroupchat
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
            }
          }
        """,
        variables: {
          "privateEventId": privateEventId,
          "input": updatePrivateEventUserDto.toMap()
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
}
