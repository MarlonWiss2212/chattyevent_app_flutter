import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_profile/user_profile_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/sharedPrefrences.dart';
import 'package:social_media_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

void init(SharedPreferences sharedPreferences, {Link? link}) {
  serviceLocator.allowReassignment = true;
  // Blocs
  serviceLocator.registerFactory(
    () => AuthBloc(
      authUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserProfileBloc(
      userUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSearchBloc(
      userUseCases: serviceLocator(),
    ),
  );

  // usecases
  serviceLocator.registerLazySingleton(
    () => AuthUseCases(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UserUseCases(
      userProfileRepository: serviceLocator(),
    ),
  );

  // repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sharedPrefrencesDatasource: serviceLocator(),
      graphQlDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      graphQlDatasource: serviceLocator(),
    ),
  );

  // datasources
  serviceLocator.registerLazySingleton<GraphQlDatasource>(
    () => GraphQlDatasourceImpl(client: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SharedPrefrencesDatasource>(
    () => SharedPrefrencesDatasourceImpl(sharedPreferences: serviceLocator()),
  );

  //extern
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton<GraphQLClient>(
    () => GraphQLClient(
      link: link ?? HttpLink("http://localhost:3000/graphql"),
      cache: GraphQLCache(),
    ),
  );
}
