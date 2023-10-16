import 'dart:async';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class OneSignalRepository {
  Future<Either<NotificationAlert, Unit>> login({required String userId});
  Future<Either<NotificationAlert, Unit>> logout();
  Either<NotificationAlert, Unit> setNotificationReceivedHandler({
    required AppRouter appRouter,
  });
  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  });
}
