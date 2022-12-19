import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class SharedPreferencesDatasource {
  Future<Either<Failure, String>> getFromStorage(String name);
  Future<void> saveToStorage(String name, String value);
  Future<void> deleteFromStorage(String name);
}

class SharedPreferencesDatasourceImpl implements SharedPreferencesDatasource {
  final SharedPreferences sharedPreferences;
  SharedPreferencesDatasourceImpl({required this.sharedPreferences});

  @override
  Future<Either<Failure, String>> getFromStorage(String name) {
    final value = sharedPreferences.getString(name);

    if (value == null) {
      return Future.value(Left(CacheFailure()));
    } else {
      return Future.value(Right(value));
    }
  }

  @override
  Future<void> saveToStorage(String name, String value) {
    return sharedPreferences.setString(name, value);
  }

  @override
  Future<void> deleteFromStorage(String name) {
    return sharedPreferences.remove(name);
  }
}
