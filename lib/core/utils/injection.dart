import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/repositories/ad_mob_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/calendar_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/chat_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/audio_player_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/microphone_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/permission_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/device/vibration_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/imprint_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/introduction_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/launch_url_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/message_repository.dart';
import 'package:chattyevent_app_flutter/domain/repositories/one_signal_repository.dart';
import 'package:chattyevent_app_flutter/domain/usecases/ad_mob_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/audio_player_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/calendar_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/chat_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/imprint_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/introduction_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/launch_url_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/microphone_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/one_signal_use_cases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/permission_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/audio_player.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/microphone.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/permission.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/device/vibration.dart';
import 'package:chattyevent_app_flutter/infastructure/datasources/remote/http.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/ad_mob_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/calendar_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/chat_repsoitory_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/audio_player_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/introduction_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/microphone_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/permission_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/device/vibration_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/imprint_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/launch_url_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/message_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/one_signal_repository_impl.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_pages_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
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
import 'package:chattyevent_app_flutter/infastructure/respositories/event_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/shopping_list_item_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/user_relation_repository_impl.dart';
import 'package:chattyevent_app_flutter/infastructure/respositories/user_repository_impl.dart';

final serviceLocator = GetIt.I;

class InjectionUtils {
  static Future initialize() async {
    //auth stuff so it can init
    serviceLocator.registerLazySingleton<AuthUseCases>(
      () => AuthUseCases(
        authRepository: serviceLocator(),
        oneSignalRepository: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(auth: FirebaseAuth.instance),
    );
    serviceLocator.registerLazySingleton<OneSignalUseCases>(
      () => OneSignalUseCases(oneSignalRepository: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<OneSignalRepository>(
      () => OneSignalRepositoryImpl(),
    );

    // cubit
    serviceLocator.registerLazySingleton<IntroductionCubit>(
      () => IntroductionCubit(
        introductionUseCases: serviceLocator(),
        notificationCubit: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<NotificationCubit>(
      () => NotificationCubit(),
    );
    final tokenOrFailure = await serviceLocator<AuthUseCases>().refreshToken();
    final String? token = tokenOrFailure.fold(
      (_) => null,
      (token) => token,
    );

    serviceLocator.registerLazySingleton<AuthCubit>(
      () {
        final User? user =
            serviceLocator<AuthUseCases>().getFirebaseUser().fold(
                  (_) => null,
                  (user) => user,
                );

        return AuthCubit(
          AuthState(
            currentUser: UserEntity(
              authId: user?.uid ?? "",
              id: "",
            ),
            token: token,
            status: token == null
                ? AuthStateStatus.initial
                : AuthStateStatus.loggedIn,
          ),
          oneSignalUseCases: serviceLocator(),
          notificationCubit: serviceLocator(),
          authUseCases: serviceLocator(),
          userUseCases: serviceLocator(),
          permissionUseCases: serviceLocator(),
        );
      },
    );

    // router
    serviceLocator.registerLazySingleton<AppRouter>(
      () => AppRouter(
        authPagesGuard: AuthPagesGuard(authUseCases: serviceLocator()),
        verifyEmailPageGuard: VerifyEmailPageGuard(
          authUseCases: serviceLocator(),
        ),
        createUserPageGuard: CreateUserPageGuard(authCubit: serviceLocator()),
        authGuard: AuthGuard(authCubit: serviceLocator()),
      ),
    );

    // use cases
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
    serviceLocator.registerFactory<CalendarUseCases>(
      () => CalendarUseCases(calendarRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<GroupchatUseCases>(
      () => GroupchatUseCases(groupchatRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<ChatUseCases>(
      () => ChatUseCases(chatRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<BoughtAmountUseCases>(
      () => BoughtAmountUseCases(boughtAmountRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<MessageUseCases>(
      () => MessageUseCases(messageRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<EventUseCases>(
      () => EventUseCases(privateEventRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<UserUseCases>(
      () => UserUseCases(userRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<UserRelationUseCases>(
      () => UserRelationUseCases(userRelationRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<AudioPlayerUseCases>(
      () => AudioPlayerUseCases(audioPlayerRepository: serviceLocator()),
    );
    serviceLocator.registerFactory<ShoppingListItemUseCases>(
      () => ShoppingListItemUseCases(
        shoppingListItemRepository: serviceLocator(),
      ),
    );

    // repositories
    serviceLocator.registerLazySingleton<LaunchUrlRepository>(
      () => LaunchUrlRepositoryImpl(),
    );
    serviceLocator.registerLazySingleton<IntroductionRepository>(
      () => IntroductionRepositoryImpl(
        sharedPrefrencesDatasource: serviceLocator(),
      ),
    );
    serviceLocator.registerLazySingleton<AdMobRepository>(
      () => AdMobRepositoryImpl(),
    );
    serviceLocator.registerLazySingleton<ImprintRepository>(
      () => ImprintRepositoryImpl(httpDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<VibrationRepository>(
      () => VibrationRepositoryImpl(vibrationDatasource: serviceLocator()),
    );
    serviceLocator.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(locationDatasource: serviceLocator()),
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
      () =>
          SettingsRepositoryImpl(sharedPrefrencesDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<MessageRepository>(
      () => MessageRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<CalendarRepository>(
      () => CalendarRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<GroupchatRepository>(
      () => GroupchatRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<BoughtAmountRepository>(
      () => BoughtAmountRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<UserRepository>(
      () => UserRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<UserRelationRepository>(
      () => UserRelationRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<EventRepository>(
      () => EventRepositoryImpl(graphQlDatasource: serviceLocator()),
    );
    serviceLocator.registerFactory<AudioPlayerRepository>(
      () => AudioPlayerRepositoryImpl(audioPlayerDataource: serviceLocator()),
    );
    serviceLocator.registerFactory<ShoppingListItemRepository>(
      () => ShoppingListItemRepositoryImpl(graphQlDatasource: serviceLocator()),
    );

    // datasources
    final sharedPrefs = await SharedPreferences.getInstance();
    serviceLocator.registerLazySingleton<SharedPreferencesDatasource>(
      () => SharedPreferencesDatasourceImpl(sharedPreferences: sharedPrefs),
    );
    serviceLocator.registerLazySingleton<VibrationDatasource>(
        () => VibrationDatasourceImpl());
    serviceLocator.registerLazySingleton<PermissionDatasource>(
        () => PermissionDatasourceImpl());
    serviceLocator.registerLazySingleton<MicrophoneDatasource>(
      () => MicrophoneDatasourceImpl(recorder: FlutterSoundRecorder()),
    );
    serviceLocator.registerFactory<AudioPlayerDatasource>(
      () => AudioPlayerDatasourceImpl(
        audioPlayer: AudioPlayer(playerId: UniqueKey().toString()),
      ),
    );
    serviceLocator.registerLazySingleton<HttpDatasource>(
      () => HttpDatasourceImpl(),
    );
    serviceLocator.registerFactory<GraphQlDatasource>(
      () {
        return GraphQlDatasourceImpl(
          client: GraphQlUtils.getGraphQlClient(token: token),
        );
      },
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
  }
}
