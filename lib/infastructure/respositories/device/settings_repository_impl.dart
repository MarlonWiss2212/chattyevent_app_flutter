import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/failure_helper.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/persist_hive_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final PersistHiveDatasource persistHiveDatasource;
  SettingsRepositoryImpl({
    required this.persistHiveDatasource,
  });

  @override
  Future<void> saveAutoDarkModeInStorage({required bool autoDarkMode}) async {
    return await persistHiveDatasource.put<bool>(
      key: "autoDarkMode",
      value: autoDarkMode,
    );
  }

  @override
  Either<NotificationAlert, bool> getAutoDarkModeFromStorage() {
    try {
      final bool data = persistHiveDatasource.get<bool>(
        key: "autoDarkMode",
      );
      return Right(data);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }

  @override
  Future<void> saveDarkModeInStorage({required bool darkMode}) async {
    return await persistHiveDatasource.put<bool>(
      key: "darkMode",
      value: darkMode,
    );
  }

  @override
  Either<NotificationAlert, bool> getDarkModeFromStorage() {
    try {
      final bool data = persistHiveDatasource.get<bool>(
        key: "darkMode",
      );
      return Right(data);
    } catch (e) {
      return Left(FailureHelper.catchFailureToNotificationAlert(exception: e));
    }
  }
}
