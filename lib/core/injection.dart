import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/core/graphql.dart';
import 'package:social_media_app_flutter/domain/repositories/auth_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/bought_amount_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/chat_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/notification_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/device/settings_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/message_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:social_media_app_flutter/domain/repositories/user_repository.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/location_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/message_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/location.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/notification.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/bought_amount_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/chat_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/location_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/notification_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/settings_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

Future init() async {
  // use cases
  serviceLocator.registerLazySingleton<NotificationUseCases>(
    () => NotificationUseCases(notificationRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LocationUseCases>(
    () => LocationUseCases(locationRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ImagePickerUseCases>(
    () => ImagePickerUseCases(imagePickerRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SettingsUseCases>(
    () => SettingsUseCases(settingsRepository: serviceLocator()),
  );
  serviceLocator.registerFactoryParam<ChatUseCases, AuthState?, void>(
    (param1, param2) => ChatUseCases(
      chatRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<BoughtAmountUseCases, AuthState?, void>(
    (param1, param2) => BoughtAmountUseCases(
      boughtAmountRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<MessageUseCases, AuthState?, void>(
    (param1, param2) => MessageUseCases(
      messageRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<PrivateEventUseCases, AuthState?, void>(
    (param1, param2) => PrivateEventUseCases(
      privateEventRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<UserUseCases, AuthState?, void>(
    (param1, param2) => UserUseCases(
      userRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<ShoppingListItemUseCases, AuthState?, void>(
    (param1, param2) => ShoppingListItemUseCases(
      shoppingListItemRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<AuthUseCases, AuthState?, void>(
    (param1, param2) => AuthUseCases(
      authRepository: serviceLocator(param1: param1),
    ),
  );

  // repositories
  serviceLocator.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(notificationDatasource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(locationDatasource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(imagePickerDatasource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sharedPrefrencesDatasource: serviceLocator()),
  );
  serviceLocator.registerFactoryParam<MessageRepository, AuthState?, void>(
    (param1, param2) => MessageRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<ChatRepository, AuthState?, void>(
    (param1, param2) => ChatRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<BoughtAmountRepository, AuthState?, void>(
    (param1, param2) => BoughtAmountRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<UserRepository, AuthState?, void>(
    (param1, param2) => UserRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<PrivateEventRepository, AuthState?, void>(
    (param1, param2) => PrivateEventRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<ShoppingListItemRepository, AuthState?, void>(
    (param1, param2) => ShoppingListItemRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<AuthRepository, AuthState?, void>(
    (param1, param2) => AuthRepositoryImpl(
      sharedPrefrencesDatasource: serviceLocator(),
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );

  // datasources
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(
      sharedPreferences: sharedPrefs,
    ),
  );
  serviceLocator.registerFactoryParam<GraphQlDatasource, AuthState?, void>(
    (param1, param2) {
      GraphQLClient client;
      if (param1 is AuthLoaded) {
        client = getGraphQlClient(token: param1.token);
      } else {
        client = getGraphQlClient();
      }

      return GraphQlDatasourceImpl(client: client);
    },
  );
  serviceLocator.registerLazySingleton<LocationDatasource>(() {
    return LocationDatasourceImpl();
  });
  serviceLocator.registerLazySingleton<ImagePickerDatasource>(() {
    return ImagePickerDatasourceImpl();
  });
  serviceLocator.registerLazySingleton<NotificationDatasource>(() {
    return NotificationDatasourceImpl();
  });
}
