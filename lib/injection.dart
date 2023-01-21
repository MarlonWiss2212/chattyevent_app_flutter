import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/edit_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/location/location_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/edit_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/notification_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/location.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/notification.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:social_media_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/location_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/notification_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

Future<void> init({
  String? token,
}) async {
  // Blocs
  serviceLocator.registerLazySingleton(
    () => AuthCubit(
      userCubit: serviceLocator(),
      authUseCases: serviceLocator(),
      userUseCases: serviceLocator(),
      notificationUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UserSearchCubit(
      userUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => UserCubit(
      userUseCases: serviceLocator(),
    ),
  );

  // chat cubits
  serviceLocator.registerLazySingleton(
    () => ChatCubit(
      chatUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddChatCubit(
      chatUseCases: serviceLocator(),
      chatCubit: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => EditChatCubit(
      chatUseCases: serviceLocator(),
      chatCubit: serviceLocator(),
    ),
  );

  //message cubits
  serviceLocator.registerLazySingleton(
    () => MessageCubit(
      messageUseCases: serviceLocator(),
    ),
  );

  //private events cubits
  serviceLocator.registerLazySingleton(
    () => PrivateEventCubit(
      privateEventUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AddPrivateEventCubit(
      privateEventUseCases: serviceLocator(),
      privateEventCubit: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => EditPrivateEventCubit(
      privateEventUseCases: serviceLocator(),
      privateEventCubit: serviceLocator(),
    ),
  );

  //device cubits
  serviceLocator.registerLazySingleton(
    () => LocationCubit(
      locationUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ImageCubit(
      imagePickerUseCases: serviceLocator(),
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
  serviceLocator.registerLazySingleton(
    () => LocationUseCases(
      locationRepository: serviceLocator(),
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
  serviceLocator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      locationDatasource: serviceLocator(),
    ),
  );

  // datasources
  serviceLocator.registerLazySingleton<GraphQlDatasource>(
    () => GraphQlDatasourceImpl(client: serviceLocator()),
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
  serviceLocator.registerLazySingleton<LocationDatasource>(
    () => LocationDatasourceImpl(),
  );

  //extern
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);

  serviceLocator.registerLazySingleton(() {
    Link link = HttpLink(
      dotenv.get("API_BASE_URL"),
      defaultHeaders: {
        "Apollo-Require-Preflight": "true",
        "Authorization": "Bearer $token"
      },
    );

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.noCache),
        mutate: Policies(fetch: FetchPolicy.noCache),
        subscribe: Policies(fetch: FetchPolicy.noCache),
      ),
    );
  });
}
