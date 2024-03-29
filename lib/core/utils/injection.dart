import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_map/home_map_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/application/provider/dark_mode.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/calendar_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/audio_player_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/internet_connection_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/microphone_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/vibration_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/imprint_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/launch_url_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/request_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/secure_storage_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/ad_mob_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/audio_player_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/calendar_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/imprint_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/internet_connection_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/introduction_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/launch_url_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/microphone_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/request_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/secure_storage_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/audio_player.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/internet_connection.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/microphone.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/permission.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/vibration.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/local/persist_hive_datasource.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/local/secure_storage.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/remote/http.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/ad_mob_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/calendar_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/chat_repsoitory_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/audio_player_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/internet_connection_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/introduction_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/microphone_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/permission_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/secure_storage_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/vibration_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/imprint_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/launch_url_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/message_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/one_signal_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/request_repository_impl.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/authorized_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/not_authenticated_pages_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/core/utils/graphql_utils.dart';
import 'package:chattyevent_app_flutter/domain/repositories/auth_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/bought_amount_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/image_picker_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/location_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/settings_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/groupchat_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/event_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/shopping_list_item_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_relation_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/user_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/bought_amount_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/groupchat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/image_picker_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/location_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/event_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/shopping_list_item_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_relation_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/user_usecases.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/image_picker.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/device/location.dart';
import 'package:chattyevent_app_flutter/infrastructure/datasources/remote/graphql.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/auth_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/bought_amount_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/image_picker_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/location_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/device/settings_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/groupchat_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/event_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/user_relation_repository_impl.dart';
import 'package:chattyevent_app_flutter/infrastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

///auth stuff has a different Locator so it has no circular dependencys
final authenticatedLocator = GetIt.asNewInstance();

class InjectionUtils {
  static Future initialize() async {
    //provider
    serviceLocator.registerLazySingleton<DarkModeProvider>(
      () => DarkModeProvider(
        settingsUseCases: serviceLocator(),
      ),
    );
    //cubit
    serviceLocator.registerLazySingleton<IntroductionCubit>(
      () => IntroductionCubit(
        introductionUseCases: serviceLocator(),
        notificationCubit: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<InternetConnectionCubit>(
      () => InternetConnectionCubit(
        internetConnectionUseCases: serviceLocator(),
        notificationCubit: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<NotificationCubit>(
      () => NotificationCubit(),
    );
    serviceLocator.registerLazySingleton<ImprintCubit>(
      () => ImprintCubit(
        imprintUseCases: serviceLocator(),
        notificationCubit: serviceLocator(),
      ),
    );

    //usecases
    serviceLocator.registerFactory<AudioPlayerUseCases>(
      () => AudioPlayerUseCases(audioPlayerRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<InternetConnectionUseCases>(
      () => InternetConnectionUseCases(
        internetConnectionRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PermissionUseCases>(
      () => PermissionUseCases(permissionRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<LaunchUrlUseCases>(
      () => LaunchUrlUseCases(launchUrlRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AdMobUseCases>(
      () => AdMobUseCases(adMobRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<IntroductionUseCases>(
      () => IntroductionUseCases(introductionRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<VibrationUseCases>(
      () => VibrationUseCases(vibrationRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ImprintUseCases>(
      () => ImprintUseCases(imprintRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<LocationUseCases>(
      () => LocationUseCases(
        locationRepository: serviceLocator(),
        permissionRepository: serviceLocator(),
        launchUrlUseCases: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<MicrophoneUseCases>(
      () => MicrophoneUseCases(
        microphoneRepository: serviceLocator(),
        permissionRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ImagePickerUseCases>(
      () => ImagePickerUseCases(
        imagePickerRepository: serviceLocator(),
        permissionRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<SettingsUseCases>(
      () => SettingsUseCases(
        settingsRepository: serviceLocator(),
        launchUrlUseCases: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<AuthUseCases>(
      () => AuthUseCases(
        authRepository: serviceLocator(),
        oneSignalRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<OneSignalUseCases>(
      () => OneSignalUseCases(
        oneSignalRepository: serviceLocator(),
        permissionRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<SecureStorageUseCases>(
      () => SecureStorageUseCases(
        secureStorageRepository: serviceLocator(),
      ),
    );

    //repositories
    serviceLocator.registerLazySingleton<LaunchUrlRepository>(
      () => LaunchUrlRepositoryImpl(),
    );
    serviceLocator.registerLazySingleton<IntroductionRepository>(
      () => IntroductionRepositoryImpl(
        persistHiveDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<AdMobRepository>(
      () => AdMobRepositoryImpl(),
    );
    serviceLocator.registerLazySingleton<InternetConnectionRepository>(
      () => InternetConnectionRepositoryImpl(
        internetConnectionDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<ImprintRepository>(
      () => ImprintRepositoryImpl(httpDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<VibrationRepository>(
      () => VibrationRepositoryImpl(vibrationDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(
        locationDatasource: serviceLocator(),
        persistHiveDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<MicrophoneRepository>(
      () => MicrophoneRepositoryImpl(microphoneDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<ImagePickerRepository>(
      () => ImagePickerRepositoryImpl(
        imagePickerDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<PermissionRepository>(
      () => PermissionRepositoryImpl(permissionDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(
        persistHiveDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerFactory<AudioPlayerRepository>(
      () => AudioPlayerRepositoryImpl(audioPlayerDataource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        auth: FirebaseAuth.instance,
        persistHiveDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<OneSignalRepository>(
      () => OneSignalRepositoryImpl(),
    );
    serviceLocator.registerLazySingleton<SecureStorageRepository>(
      () => SecureStorageRepositoryImpl(
        secureStorageDatasource: serviceLocator(),
      ),
    );
    //datasources
    // non token datasource
    serviceLocator.registerLazySingleton<InternetConnectionDatasource>(
      () => InternetConnectionDatasourceImpl(
        connectivity: Connectivity(),
      ),
    );
    serviceLocator.registerLazySingleton<HttpDatasource>(
      () => HttpDatasourceImpl(),
    );
    serviceLocator.registerLazySingleton<LocationDatasource>(() {
      return LocationDatasourceImpl();
    });
    serviceLocator.registerLazySingleton<ImagePickerDatasource>(() {
      return ImagePickerDatasourceImpl(
        imageCropper: ImageCropper(),
        imagePicker: ImagePicker(),
      );
    });
    serviceLocator.registerLazySingleton<VibrationDatasource>(
      () => VibrationDatasourceImpl(),
    );
    serviceLocator.registerLazySingleton<PermissionDatasource>(
      () => PermissionDatasourceImpl(),
    );
    serviceLocator.registerLazySingleton<MicrophoneDatasource>(
      () => MicrophoneDatasourceImpl(
        recorder: FlutterSoundRecorder(),
      ),
    );
    serviceLocator.registerLazySingleton<SecureStorageDatasource>(
      () => SecureStorageDatasourceImpl(
        flutterSecureStorage: const FlutterSecureStorage(),
      ),
    );
    serviceLocator.registerFactory<AudioPlayerDatasource>(
      () => AudioPlayerDatasourceImpl(
        audioPlayer: AudioPlayer(
          playerId: UniqueKey().toString(),
        ),
      ),
    );

    //DB
    final secureKey =
        await serviceLocator<SecureStorageUseCases>().getSecureKeyOrGenerateNew(
      key: "persistData",
    );
    late Uint8List secureKeyAsList;
    secureKey.fold(
      ///TODO fix that
      (alert) => throw Exception("Fehler beim holen der Daten"),
      (value) => secureKeyAsList = base64Url.decode(value),
    );
    final box = await Hive.openBox(
      "persistData",
      encryptionCipher: HiveAesCipher(secureKeyAsList),
    );
    serviceLocator.registerLazySingleton<PersistHiveDatasource>(
      () => PersistHiveDatasourceImpl(box: box),
    );

    serviceLocator.registerLazySingleton<AuthCubit>(
      () {
        final User? user =
            serviceLocator<AuthUseCases>().getFirebaseUser().fold(
                  (_) => null,
                  (user) => user,
                );

        return AuthCubit(
          AuthState.standardState(user),
          oneSignalUseCases: serviceLocator(),
          notificationCubit: serviceLocator(),
          authUseCases: serviceLocator(),
          permissionUseCases: serviceLocator(),
        );
      },
    );

    // router
    serviceLocator.registerLazySingleton<AppRouter>(
      () => AppRouter(
        notAuthenticatedPagesGuard: NotAuthenticatedPagesGuard(
          authUseCases: serviceLocator<AuthUseCases>(),
        ),
        verifyEmailPageGuard: VerifyEmailPageGuard(
          authUseCases: serviceLocator<AuthUseCases>(),
        ),
        createUserPageGuard: CreateUserPageGuard(
          authCubit: serviceLocator<AuthCubit>(),
        ),
        authGuard: AuthGuard(
          authCubit: serviceLocator<AuthCubit>(),
        ),
        authorizedGuard: AuthorizedGuard(
          authCubit: serviceLocator<AuthCubit>(),
        ),
      ),
    );
  }

  static Future<void> resetAuthenticatedLocator() async =>
      await authenticatedLocator.reset(
        dispose: true,
      );

  static void initializeAuthenticatedLocator() {
    // just for development so i can hot refresh
    // authenticatedLocator.reset(
    //   dispose: false,
    // );
    // cubits
    authenticatedLocator.registerLazySingleton<ChatCubit>(
      () => ChatCubit(
        chatUseCases: authenticatedLocator(),
        notificationCubit: serviceLocator(),
        authCubit: serviceLocator(),
        messageStreamCubit: authenticatedLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<HomeEventCubit>(
      () => HomeEventCubit(
        eventUseCases: authenticatedLocator(),
        notificationCubit: serviceLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<HomeMapCubit>(
      () => HomeMapCubit(
        eventUseCases: authenticatedLocator(),
        notificationCubit: serviceLocator(),
        locationUseCases: serviceLocator(),
      )..setCurrentLocationFromStorage(),
    );
    authenticatedLocator.registerLazySingleton<MessageStreamCubit>(
      () => MessageStreamCubit(
        messageUseCases: authenticatedLocator(),
        notificationCubit: serviceLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<RequestsCubit>(
      () => RequestsCubit(
        chatCubit: authenticatedLocator(),
        notificationCubit: serviceLocator(),
        requestUseCases: authenticatedLocator(),
      ),
    );

    // use cases
    authenticatedLocator.registerLazySingleton<CalendarUseCases>(
      () => CalendarUseCases(calendarRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<GroupchatUseCases>(
      () => GroupchatUseCases(groupchatRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<ChatUseCases>(
      () => ChatUseCases(chatRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<BoughtAmountUseCases>(
      () =>
          BoughtAmountUseCases(boughtAmountRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<MessageUseCases>(
      () => MessageUseCases(messageRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<EventUseCases>(
      () => EventUseCases(privateEventRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<UserUseCases>(
      () => UserUseCases(userRepository: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<UserRelationUseCases>(
      () => UserRelationUseCases(
        userRelationRepository: authenticatedLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<RequestUseCases>(
      () => RequestUseCases(
        requestRepository: authenticatedLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<ShoppingListItemUseCases>(
      () => ShoppingListItemUseCases(
        shoppingListItemRepository: authenticatedLocator(),
      ),
    );

    // repositories
    authenticatedLocator.registerLazySingleton<RequestRepository>(
      () => RequestRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<CalendarRepository>(
      () => CalendarRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<GroupchatRepository>(
      () => GroupchatRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<BoughtAmountRepository>(
      () => BoughtAmountRepositoryImpl(
        graphQlDatasource: authenticatedLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<UserRelationRepository>(
      () => UserRelationRepositoryImpl(
        graphQlDatasource: authenticatedLocator(),
      ),
    );
    authenticatedLocator.registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(graphQlDatasource: authenticatedLocator()),
    );
    authenticatedLocator.registerLazySingleton<ShoppingListItemRepository>(
      () => ShoppingListItemRepositoryImpl(
        graphQlDatasource: authenticatedLocator(),
      ),
    );

    // datasources
    authenticatedLocator.registerLazySingleton<GraphQlDatasource>(
      () {
        return GraphQlDatasourceImpl(
          newClient: () async {
            final String oldToken =
                serviceLocator<AuthCubit>().state.token ?? "";

            await serviceLocator<AuthCubit>().refreshAuthToken();

            final String newToken =
                serviceLocator<AuthCubit>().state.token ?? "";

            if (oldToken != newToken) {
              await authenticatedLocator.resetLazySingleton<GraphQLClient>();
            }
            return authenticatedLocator.get<GraphQLClient>();
          },
          client: authenticatedLocator(),
        );
      },
    );

    // client
    authenticatedLocator.registerLazySingleton<GraphQLClient>(
      () => GraphQlUtils.getGraphQlClient(
        token: serviceLocator<AuthCubit>().state.token,
      ),
    );
  }
}
