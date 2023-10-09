import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/domain/repositories/secure_storage_repository.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/secure_storage.dart';
import 'package:dartz/dartz.dart';

class SecureStorageRepositoryImpl implements SecureStorageRepository {
  final SecureStorageDatasource secureStorageDatasource;
  SecureStorageRepositoryImpl({
    required this.secureStorageDatasource,
  });

  @override
  Future<Either<NotificationAlert, String>> read({required String key}) async {
    try {
      final value = await secureStorageDatasource.read(key: key);
      if (value == null) {
        throw Exception("Fehler beim holen der Daten von dem Sicheren Storage");
      }
      return Right(value);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<Either<NotificationAlert, Unit>> write({
    required String key,
    required String? value,
  }) async {
    try {
      await secureStorageDatasource.write(key: key, value: value);
      return const Right(unit);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
