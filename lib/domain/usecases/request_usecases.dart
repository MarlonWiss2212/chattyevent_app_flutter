import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/request_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/limit_offset_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infrastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';

class RequestUseCases {
  final RequestRepository requestRepository;
  RequestUseCases({required this.requestRepository});

  Future<Either<NotificationAlert, List<RequestEntity>>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
    required LimitOffsetFilter limitOffsetFilter,
  }) async {
    return await requestRepository.getRequestsViaApi(
      findRequestsFilter: findRequestsFilter,
      limitOffsetFilter: limitOffsetFilter,
    );
  }

  Future<Either<NotificationAlert, Unit>> acceptRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  }) async {
    return await requestRepository.acceptRequestViaApi(
      findOneRequestFilter: findOneRequestFilter,
    );
  }

  Future<Either<NotificationAlert, Unit>> deleteRequestViaApi({
    required FindOneRequestFilter findOneRequestFilter,
  }) async {
    return await requestRepository.deleteRequestViaApi(
      findOneRequestFilter: findOneRequestFilter,
    );
  }
}
