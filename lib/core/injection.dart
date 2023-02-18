import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';

final serviceLocator = GetIt.I;

Future init() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(
      sharedPreferences: sharedPrefs,
    ),
  );
}
