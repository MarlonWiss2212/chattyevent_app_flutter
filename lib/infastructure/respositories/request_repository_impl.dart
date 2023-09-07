import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/request_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/models/request/request_model.dart';
import 'package:dartz/dartz.dart';

class RequestRepositoryImpl implements RequestRepository {
  final GraphQlDatasource graphQlDatasource;

  RequestRepositoryImpl({required this.graphQlDatasource});

  @override
  Future<Either<NotificationAlert, List<RequestEntity>>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    try {
      final response = await graphQlDatasource.query(
        """
        query FindRequests(\$filter: FindRequestsInput!, \$limitOffsetInput: LimitOffsetInput!) {
          findRequests(filter: \$filter, limitOffsetInput: \$limitOffsetInput) {
            ${RequestModel.requestFullQuery()}
          }
        }
      """,
        variables: {
          "filter": findRequestsFilter.toMap(),
          "limitOffsetInput": limitOffsetFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Get Request Fehler",
          response: response,
        ));
      }

      List<RequestEntity> requests = [];
      for (final request in response.data!["findRequests"]) {
        requests.add(RequestModel.fromJson(request));
      }
      return Right(requests);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> acceptRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
          mutation AcceptRequest(\$filter: FindOneRequestInput!) {
            acceptRequest(filter: \$filter)
          }
        """,
        variables: {
          "filter": findOneRequestFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Accept Request Fehler",
          response: response,
        ));
      }
      if (response.data!["acceptRequest"] == false) {
        throw Exception("Interner Server fehler beim akzeptieren der Request");
      }
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> deleteRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  }) async {
    try {
      final response = await graphQlDatasource.mutation(
        """
        mutation DeleteRequest(\$filter: FindOneRequestInput!) {
          deleteRequest(filter: \$filter)
        }
      """,
        variables: {
          "filter": findOneRequestFilter.toMap(),
        },
      );

      if (response.hasException) {
        return Left(FailureHelper.graphqlFailureToNotificationAlert(
          title: "Delete Request Fehler",
          response: response,
        ));
      }
      if (response.data!["deleteRequest"] == false) {
        throw Exception("Interner Server fehler beim löschen der Request");
      }
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
