import 'package:social_media_app_flutter/domain/dto/create_private_event_dto.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_private_event_filter.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event_model.dart';

class PrivateEventRepositoryImpl implements PrivateEventRepository {
  final GraphQlDatasource graphQlDatasource;
  PrivateEventRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi(
      CreatePrivateEventDto createPrivateEventDto) async {
    try {
      final response = await graphQlDatasource.mutation("""
        mutation CreatePrivatEvent(\$input: CreatePrivateEventInput!) {
          createPrivateEvent(createPrivateEventInput: \$input) {
            _id
            title
            coverImageLink
            usersThatWillBeThere
            usersThatWillNotBeThere
            eventDate
            connectedGroupchat
            createdBy
            createdAt
          }
        }
      """, variables: {'input': createPrivateEventDto.toMap()});

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
        query FindPrivateEvent(\$input: FindOnePrivateEventInput!) {
          findPrivateEvent(filter: \$input) {
            _id
            title
            coverImageLink
            usersThatWillBeThere
            usersThatWillNotBeThere
            eventDate
            connectedGroupchat
            createdBy
            createdAt
          }
        }
      """,
        variables: {"input": getOnePrivateEventFilter.toMap()},
      );

      if (response.hasException) {
        return Left(GeneralFailure());
      }
      return Right(
        PrivateEventModel.fromJson(response.data!["findPrivateEvent"]),
      );
    } catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PrivateEventEntity>>>
      getPrivateEventsViaApi() async {
    try {
      final response = await graphQlDatasource.query("""
        query FindPrivateEvents {
          findPrivateEvents {
            _id
            title
            connectedGroupchat
            eventDate
          }
        }
      """);

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
}
