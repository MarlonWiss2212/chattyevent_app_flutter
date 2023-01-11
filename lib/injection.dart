import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/notification_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/notification.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:social_media_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/notification_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

Future<void> init({String? token}) async {
  serviceLocator.allowReassignment = true;
  // Blocs
  serviceLocator.registerFactory(
    () => AuthBloc(
      authUseCases: serviceLocator(),
      notificationUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSearchBloc(
      userUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserBloc(
      userUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => ChatBloc(
      chatUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => PrivateEventBloc(
      privateEventUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => MessageBloc(
      messageUseCases: serviceLocator(),
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
  serviceLocator.registerLazySingleton(
    () => ChatUseCases(
      chatRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => PrivateEventUseCases(
      privateEventRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => MessageUseCases(
      messageRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => NotificationUseCases(
      notificationRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ImagePickerUseCases(
      imagePickerRepository: serviceLocator(),
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
  serviceLocator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      graphQlDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<PrivateEventRepository>(
    () => PrivateEventRepositoryImpl(
      graphQlDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(
      graphQlDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      notificationDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(
      imagePickerDatasource: serviceLocator(),
    ),
  );

  // datasources
  serviceLocator.registerLazySingleton<GraphQlDatasource>(
    () => GraphQlDatasourceImpl(client: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<NotificationDatasource>(
    () => NotificationDatasourceImpl(),
  );
  serviceLocator.registerLazySingleton<ImagePickerDatasource>(
    () => ImagePickerDatasourceImpl(),
  );

  //extern
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);

  Link link = HttpLink(
    dotenv.get("API_BASE_URL"),
    defaultHeaders: {
      "Apollo-Require-Preflight": "true",
      "Authorization": "Bearer $token"
    },
  );

  final gqlClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(),
    defaultPolicies: DefaultPolicies(
      query: Policies(fetch: FetchPolicy.noCache),
      mutate: Policies(fetch: FetchPolicy.noCache),
    ),
  );
  serviceLocator.registerLazySingleton<GraphQLClient>(
    () => gqlClient,
  );
}
