import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';

abstract class RequestRepository {
  Future<Either<NotificationAlert, List<RequestEntity>>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  });

  Future<Either<NotificationAlert, Unit>> acceptRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });

  Future<Either<NotificationAlert, Unit>> deleteRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });
}
