import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/enums/notification/notification_type_enum.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:dartz/dartz.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalRepositoryImpl implements OneSignalRepository {
  @override
  Future<Either<NotificationAlert, Unit>> login({
    required String userId,
  }) async {
    try {
      await OneSignal.login(userId);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> logout() async {
    try {
      await OneSignal.logout();
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Unit> setNotificationOpenedHandler({
    required AppRouter appRouter,
  }) {
    try {
      OneSignal.Notifications.addClickListener((event) {
        final String? route = event.notification.additionalData?['route'];
        if (route != null) {
          appRouter.pushNamed(route);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Either<NotificationAlert, Unit> setNotificationReceivedHandler({
    required AppRouter appRouter,
  }) {
    try {
      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        event.preventDefault();

        final Map<String, dynamic>? additionalData =
            event.notification.additionalData;
        if (additionalData == null) {
          event.notification.display();
          return;
        }

        final currentPath = appRouter.currentPath;
        if (currentPath == additionalData["route"]) {
          final NotificationTypeEnum? type = additionalData["type"] != null
              ? NotificationTypeEnumExtension.fromValue(additionalData["type"])
              : null;

          if (type == NotificationTypeEnum.messageadded) {
            return;
          }
        }

        event.notification.display();
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
