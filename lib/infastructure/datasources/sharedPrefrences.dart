import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/domain/failures/failures.dart';

abstract class SharedPrefrencesDatasource {
  Future<Either<Failure, String>> getFromStorage(String name);
  Future<void> saveToStorage(String name, String value);
}

class SharedPrefrencesDatasourceImpl implements SharedPrefrencesDatasource {
  final SharedPreferences sharedPreferences;
  SharedPrefrencesDatasourceImpl({required this.sharedPreferences});

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
}
