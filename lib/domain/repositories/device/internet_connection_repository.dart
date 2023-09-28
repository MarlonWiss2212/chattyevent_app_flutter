import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

abstract class InternetConnectionRepository {
  Either<NotificationAlert, Stream<ConnectivityResult>>
      internetConnectionStream();
}
