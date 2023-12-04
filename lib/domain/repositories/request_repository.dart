import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';

/// Repository for handling request-related functionality.
abstract class RequestRepository {
  /// Retrieves requests via API.
  /// Returns a [NotificationAlert] in case of an error or a list of [RequestEntity] when successful.
  Future<Either<NotificationAlert, List<RequestEntity>>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  /// Accepts a request via API.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> acceptRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });

  /// Deletes a request via API.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> deleteRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });
}
