import 'package:social_media_app_flutter/domain/failures/failures.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/models/private_event_model.dart';

class PrivateEventRepositoryImpl implements PrivateEventRepository {
  final GraphQlDatasource graphQlDatasource;
  PrivateEventRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<Failure, PrivateEventEntity>> createPrivateEventViaApi() {
    // TODO: implement createPrivateEventViaApi
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PrivateEventEntity>> getPrivateEventViaApi() {
    // TODO: implement getPrivateEventViaApi
    throw UnimplementedError();
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
