import 'dart:async';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

/// Repository for handling OneSignal-related functionality.
abstract class OneSignalRepository {
  /// Logs in with the provided user ID.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> login({required String userId});

  /// Logs out from OneSignal.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> logout();

  /// Sets the notification received handler.
  /// Returns a [NotificationAlert] in case of an error or [Unit].
  Either<NotificationAlert, Unit> setNotificationReceivedHandler({
    required AppRouter appRouter,
  });

  /// Sets the language code for OneSignal.
  /// Returns a [NotificationAlert] in case of an error or [Unit] when successful.
  Future<Either<NotificationAlert, Unit>> setLanguageCode({
    required String languageCode,
  });
}
