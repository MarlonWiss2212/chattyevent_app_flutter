import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';

abstract class SharedPreferencesDatasource {
  Future<void> deleteFromStorage(String name);

  Future<Either<NotificationAlert, String>> getStringFromStorage(String name);
  Future<void> saveStringToStorage(String name, String value);

  Future<Either<NotificationAlert, bool>> getBoolFromStorage(String name);
  Future<void> saveBoolToStorage(String name, bool value);
}

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  final SharedPreferences sharedPreferences;
  SharedPreferencesDatasourceImpl({required this.sharedPreferences});

  @override
  Future<Either<NotificationAlert, String>> getStringFromStorage(String name) {
    final value = sharedPreferences.getString(name);

    if (value == null) {
      return Future.value(Left(NotificationAlert(
        title: "Cache Fehler",
        message: "Keinen String Wert mit dem namen: $name gefunden",
      )));
    } else {
      return Future.value(Right(value));
    }
  }

  @override
  Future<void> saveStringToStorage(String name, String value) {
    return sharedPreferences.setString(name, value);
  }

  @override
  Future<Either<NotificationAlert, bool>> getBoolFromStorage(String name) {
    final value = sharedPreferences.getBool(name);

    if (value == null) {
      return Future.value(Left(NotificationAlert(
        title: "Cache Fehler",
        message: "Keinen Boolean Wert mit dem namen: $name gefunden",
      )));
    } else {
      return Future.value(Right(value));
    }
  }

  @override
  Future<void> saveBoolToStorage(String name, bool value) {
    return sharedPreferences.setBool(name, value);
  }

  @override
  Future<void> deleteFromStorage(String name) {
    return sharedPreferences.remove(name);
  }
}
