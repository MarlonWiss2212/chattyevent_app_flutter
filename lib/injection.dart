import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
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

GraphQLClient getGraphQlClient({String? token}) {
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
}

final serviceLocator = GetIt.I;

Future<void> init() async {
  serviceLocator.allowReassignment = true;

  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      authUseCases: serviceLocator(),
      userUseCases: serviceLocator(),
      notificationUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      authRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserUseCases>(
    () => UserUseCases(
      userRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<NotificationUseCases>(
    () => NotificationUseCases(
      notificationRepository: serviceLocator(),
    ),
  );

  GraphQlDatasource graphQlDatasource = GraphQlDatasourceImpl(
    client: getGraphQlClient(),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sharedPrefrencesDatasource: serviceLocator(),
      graphQlDatasource: graphQlDatasource,
    ),
  );
  serviceLocator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      notificationDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      graphQlDatasource: graphQlDatasource,
    ),
  );
  serviceLocator.registerLazySingleton<NotificationDatasource>(
    () => NotificationDatasourceImpl(),
  );

  serviceLocator.registerFactory<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(sharedPreferences: serviceLocator()),
  );
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerFactory(() => sharedPrefs);

  /*serviceLocator.registerFactoryParam<ProfilePageCubit, GraphQLClient, void>(
    (param1, _) => ProfilePageCubit(
      userCubit: serviceLocator(param1: param1),
      userUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<UserSearchCubit, GraphQLClient, void>(
    (param1, _) => UserSearchCubit(
      userUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<UserCubit, GraphQLClient, void>(
    (param1, _) => UserCubit(
      userUseCases: serviceLocator(param1: param1),
    ),
  );

  // chat cubits
  serviceLocator.registerFactoryParam<ChatCubit, GraphQLClient, void>(
    (param1, _) => ChatCubit(
      chatUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<AddChatCubit, GraphQLClient, void>(
    (param1, _) => AddChatCubit(
      chatUseCases: serviceLocator(param1: param1),
      chatCubit: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<CurrentChatCubit, GraphQLClient, void>(
    (param1, _) => CurrentChatCubit(
      chatUseCases: serviceLocator(param1: param1),
      chatCubit: serviceLocator(param1: param1),
    ),
  );

  //message cubits
  serviceLocator.registerFactoryParam<MessageCubit, GraphQLClient, void>(
    (param1, _) => MessageCubit(
      messageUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<AddMessageCubit, GraphQLClient, void>(
    (param1, _) => AddMessageCubit(
      messageCubit: serviceLocator(param1: param1),
      messageUseCases: serviceLocator(param1: param1),
    ),
  );

  //private events cubits
  serviceLocator.registerFactoryParam<PrivateEventCubit, GraphQLClient, void>(
    (param1, _) => PrivateEventCubit(
      privateEventUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<AddPrivateEventCubit, GraphQLClient, void>(
    (param1, _) => AddPrivateEventCubit(
      privateEventUseCases: serviceLocator(param1: param1),
      privateEventCubit: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<CurrentPrivateEventCubit, GraphQLClient, void>(
    (param1, _) => CurrentPrivateEventCubit(
      privateEventUseCases: serviceLocator(param1: param1),
      privateEventCubit: serviceLocator(param1: param1),
    ),
  );

  //device cubits
  serviceLocator.registerFactoryParam<LocationCubit, GraphQLClient, void>(
    (param1, _) => LocationCubit(
      locationUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<HomeProfilePageCubit, GraphQLClient, void>(
    (param1, _) => HomeProfilePageCubit(
      userUseCases: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<ImageCubit, GraphQLClient, void>(
    (param1, _) => ImageCubit(
      imagePickerUseCases: serviceLocator(param1: param1),
    ),
  );

  // usecases
  serviceLocator.registerFactoryParam<ChatUseCases, GraphQLClient, void>(
    (param1, _) => ChatUseCases(
      chatRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<PrivateEventUseCases, GraphQLClient, void>(
    (param1, _) => PrivateEventUseCases(
      privateEventRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<MessageUseCases, GraphQLClient, void>(
    (param1, _) => MessageUseCases(
      messageRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam(
    (param1, _) => ImagePickerUseCases(
      imagePickerRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam(
    (param1, _) => LocationUseCases(
      locationRepository: serviceLocator(param1: param1),
    ),
  );

  // repositories
  serviceLocator.registerFactoryParam<UserRepository, GraphQLClient, void>(
    (param1, _) => UserRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<ChatRepository, GraphQLClient, void>(
    (param1, _) => ChatRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<PrivateEventRepository, GraphQLClient, void>(
    (param1, _) => PrivateEventRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<MessageRepository, GraphQLClient, void>(
    (param1, _) => MessageRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<ImagePickerRepository, GraphQLClient, void>(
    (param1, _) => ImagePickerRepositoryImpl(
      imagePickerDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactoryParam<LocationRepository, GraphQLClient, void>(
    (param1, _) => LocationRepositoryImpl(
      locationDatasource: serviceLocator(),
    ),
  );

  // datasources
  serviceLocator.registerFactoryParam<GraphQlDatasource, GraphQLClient, void>(
    (param1, _) => GraphQlDatasourceImpl(client: param1),
  );
  serviceLocator.registerFactory<ImagePickerDatasource>(
    () => ImagePickerDatasourceImpl(),
  );
  serviceLocator.registerFactory<LocationDatasource>(
    () => LocationDatasourceImpl(),
  );

  //extern
  */
}
