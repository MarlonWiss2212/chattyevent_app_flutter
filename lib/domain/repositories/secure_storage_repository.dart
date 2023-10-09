import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:dartz/dartz.dart';

abstract class SecureStorageRepository {
  Future<Either<NotificationAlert, String>> read({required String key});
  Future<Either<NotificationAlert, Unit>> write({
    required String key,
    required String? value,
  });
}
