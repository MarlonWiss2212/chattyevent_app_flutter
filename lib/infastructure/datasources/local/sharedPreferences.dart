import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class SharedPreferencesDatasource {
  Future<void> deleteFromStorage(String name);

  Future<Either<Failure, String>> getStringFromStorage(String name);
  Future<void> saveStringToStorage(String name, String value);

  Future<Either<Failure, bool>> getBoolFromStorage(String name);
  Future<void> saveBoolToStorage(String name, bool value);
}

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  final SharedPreferences sharedPreferences;
  SharedPreferencesDatasourceImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, String>> getStringFromStorage(String name) {
    final value = sharedPreferences.getString(name);

    if (value == null) {
      return Future.value(Left(CacheFailure()));
    } else {
      return Future.value(Right(value));
    }
  }

  @override
  Future<void> saveStringToStorage(String name, String value) {
    return sharedPreferences.setString(name, value);
  }

  @override
  Future<Either<Failure, bool>> getBoolFromStorage(String name) {
    final value = sharedPreferences.getBool(name);

    if (value == null) {
      return Future.value(Left(CacheFailure()));
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
