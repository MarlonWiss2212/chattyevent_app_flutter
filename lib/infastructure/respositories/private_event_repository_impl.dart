import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/create_private_event_user_dto.dart';
import 'package:social_media_app_flutter/core/dto/private_event/update_private_event_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/core/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/core/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/core/filter/get_private_events_filter.dart';
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
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
              organizer
            }
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
        print(response.exception);
        return Left(GeneralFailure());
      }

      return Right(
        PrivateEventModel.fromJson(response.data!['createPrivateEvent']),
      );
    } catch (e) {
      print(e);

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
              _id
              privateEventTo
              userId
              status
              createdAt
              updatedAt
              organizer
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
            eventEndDate
            groupchatTo
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
  Future<Either<Failure, PrivateEventUserEntity>> createPrivateEventUserViaApi({
    required CreatePrivateEventUserDto createPrivateEventUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation CreatePrivateEventUser(\$input: CreatePrivateEventUserInput!) {
            createPrivateEventUser(createPrivateEventUserInput: \$input) {
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
        print(response.exception);
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventUserModel.fromJson(
          response.data!["createPrivateEventUser"],
        ),
      );
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PrivateEventUserEntity>> updatePrivateEventUser({
    required UpdatePrivateEventUserDto updatePrivateEventUserDto,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation UpdatePrivateEventUser(\$input: UpdatePrivateEventUserInput!) {
            updatePrivateEventUser(updatePrivateEventUserInput: \$input) {
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
        variables: {"input": updatePrivateEventUserDto.toMap()},
      );

      if (response.hasException) {
        print(response.exception);
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
  Future<Either<Failure, void>> deletePrivateEventViaApi() {
    // TODO: implement deletePrivateEventViaApi
    throw UnimplementedError();
  }
}
