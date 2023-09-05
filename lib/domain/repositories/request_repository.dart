import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';

abstract class RequestRepository {
  Future<Either<NotificationAlert, List<RequestEntity>>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
  });

  Future<Either<NotificationAlert, Unit>> acceptRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });

  Future<Either<NotificationAlert, Unit>> deleteRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  });
}
