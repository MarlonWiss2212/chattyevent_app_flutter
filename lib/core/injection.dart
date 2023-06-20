import 'package:chattyevent_app_flutter/domain/repositories/calendar_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/imprint_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/calendar_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/chat_usecase.dart';
import 'package:chattyevent_app_flutter/domain/usecases/imprint_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/http.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/calendar_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/chat_repsoitory_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/imprint_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_pages_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/core/graphql.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/bought_amount_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/groupchat_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/private_event_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_relation_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/private_event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/image_picker.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/location.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/bought_amount_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/location_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/settings_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/groupchat_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/private_event_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/user_relation_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

Future init() async {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  serviceLocator.registerFactoryParam<AppRouter, AuthCubit, void>(
    (param1, param2) => AppRouter(
      authPagesGuard: AuthPagesGuard(authCubit: param1),
      verifyEmailPageGuard: VerifyEmailPageGuard(authCubit: param1),
      createUserPageGuard: CreateUserPageGuard(authCubit: param1),
      authGuard: AuthGuard(authCubit: param1),
    ),
  );

  // use cases
  serviceLocator.registerLazySingleton<PermissionUseCases>(
    () => PermissionUseCases(),
  );
  serviceLocator.registerLazySingleton<ImprintUseCases>(
    () => ImprintUseCases(imprintRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LocationUseCases>(
    () => LocationUseCases(
      locationRepository: serviceLocator(),
      permissionUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ImagePickerUseCases>(
    () => ImagePickerUseCases(
      imagePickerRepository: serviceLocator(),
      permissionUseCases: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<SettingsUseCases>(
    () => SettingsUseCases(settingsRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactoryParam<CalendarUseCases, AuthState?, void>(
    (param1, param2) => CalendarUseCases(
      calendarRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<GroupchatUseCases, AuthState?, void>(
    (param1, param2) => GroupchatUseCases(
      groupchatRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<ChatUseCase, AuthState?, void>(
    (param1, param2) => ChatUseCase(
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
  serviceLocator.registerFactoryParam<UserRelationUseCases, AuthState?, void>(
    (param1, param2) => UserRelationUseCases(
      userRelationRepository: serviceLocator(param1: param1),
    ),
  );
  serviceLocator
      .registerFactoryParam<ShoppingListItemUseCases, AuthState?, void>(
    (param1, param2) => ShoppingListItemUseCases(
      shoppingListItemRepository: serviceLocator(param1: param1),
    ),
  );

  // repositories
  serviceLocator.registerLazySingleton<ImprintRepository>(
    () => ImprintRepositoryImpl(httpDatasource: serviceLocator()),
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
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(auth: serviceLocator()),
  );
  serviceLocator.registerFactoryParam<MessageRepository, AuthState?, void>(
    (param1, param2) => MessageRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<CalendarRepository, AuthState?, void>(
    (param1, param2) => CalendarRepositoryImpl(
      graphQlDatasource: serviceLocator(param1: param1),
    ),
  );
  serviceLocator.registerFactoryParam<GroupchatRepository, AuthState?, void>(
    (param1, param2) => GroupchatRepositoryImpl(
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
  serviceLocator.registerFactoryParam<UserRelationRepository, AuthState?, void>(
    (param1, param2) => UserRelationRepositoryImpl(
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

  // datasources
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
    () => SharedPreferencesDatasourceImpl(
      sharedPreferences: sharedPrefs,
    ),
  );
  serviceLocator.registerLazySingleton<HttpDatasource>(
    () => HttpDatasourceImpl(),
  );
  serviceLocator.registerFactoryParam<GraphQlDatasource, AuthState?, void>(
    (param1, param2) {
      return GraphQlDatasourceImpl(
        client: getGraphQlClient(token: param1?.token),
      );
    },
  );
  serviceLocator.registerLazySingleton<LocationDatasource>(() {
    return LocationDatasourceImpl();
  });
  serviceLocator.registerLazySingleton<ImagePickerDatasource>(() {
    return ImagePickerDatasourceImpl();
  });
}
