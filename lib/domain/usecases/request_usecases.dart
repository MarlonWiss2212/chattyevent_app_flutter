import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/repositories/request_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_one_request_filter.dart';
import 'package:chattyevent_app_flutter/infastructure/filter/request/find_requests_filter.dart';
import 'package:dartz/dartz.dart';

class RequestUseCases {
  final RequestRepository requestRepository;
  RequestUseCases({required this.requestRepository});

  Future<Either<NotificationAlert, void>> getRequestsViaApi({
    required FindRequestsFilter findRequestsFilter,
  }) async {
    return await requestRepository.getRequestsViaApi(
      findRequestsFilter: findRequestsFilter,
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
