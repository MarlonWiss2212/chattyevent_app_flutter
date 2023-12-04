import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

abstract class InternetConnectionRepository {
  /// Either return a NotificationAlert when an error occurred or
  /// returns a stream with the current connectivity
  Either<NotificationAlert, Stream<ConnectivityResult>>
      internetConnectionStream();
}
