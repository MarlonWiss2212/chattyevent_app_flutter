import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class AdMobRepository {
  Future<Either<NotificationAlert, Unit>> showAdMobPopUpIfRequired();
}
