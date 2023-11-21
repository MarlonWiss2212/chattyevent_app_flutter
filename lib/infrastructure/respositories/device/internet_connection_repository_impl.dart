import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/internet_connection_repository.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/internet_connection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

class InternetConnectionRepositoryImpl implements InternetConnectionRepository {
  final InternetConnectionDatasource internetConnectionDatasource;
  InternetConnectionRepositoryImpl({
    required this.internetConnectionDatasource,
  });

  @override
  Either<NotificationAlert, Stream<ConnectivityResult>>
      internetConnectionStream() {
    try {
      return Right(internetConnectionDatasource.internetConnectionStream());
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
