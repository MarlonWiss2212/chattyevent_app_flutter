import 'dart:async';
import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/auth/current_user_cubit.dart';
import 'package:social_media_app_flutter/application/provider/darkMode.dart';
import 'package:social_media_app_flutter/bloc_init.dart';
import 'package:social_media_app_flutter/core/colors.dart';
import 'package:social_media_app_flutter/core/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/core/graphql.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/notification_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:social_media_app_flutter/domain/usecases/user_usecases.dart';
import 'package:social_media_app_flutter/infastructure/datasources/device/notification.dart';
import 'package:social_media_app_flutter/infastructure/datasources/local/sharedPreferences.dart';
import 'package:social_media_app_flutter/infastructure/datasources/remote/graphql.dart';
import 'package:social_media_app_flutter/infastructure/respositories/auth_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/notification_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/settings_repository_impl.dart';
import 'package:social_media_app_flutter/infastructure/respositories/user_repository_impl.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/one_signal.dart' as one_signal;
import 'core/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();

  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      await one_signal.init();
    }
  }

  final client = getGraphQlClient();
  final datasource = GraphQlDatasourceImpl(client: client);
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    BlocProvider.value(
      value: AuthCubit(
        notificationUseCases: NotificationUseCases(
          notificationRepository: NotificationRepositoryImpl(
            notificationDatasource: NotificationDatasourceImpl(),
          ),
        ),
        userUseCases: UserUseCases(
          userRepository: UserRepositoryImpl(
            graphQlDatasource: datasource,
          ),
        ),
        authUseCases: AuthUseCases(
          authRepository: AuthRepositoryImpl(
            sharedPrefrencesDatasource: SharedPreferencesDatasourceImpl(
              sharedPreferences: sharedPrefs,
            ),
            graphQlDatasource: datasource,
          ),
        ),
      )..getTokenAndLoadUser(),
      child: const BlocInit(),
    ),
  );
}

class App extends StatefulWidget {
  final AuthState authState;
  final AppRouter appRouter;
  const App({
    super.key,
    required this.authState,
    required this.appRouter,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DarkModeProvider darkModeProvider = DarkModeProvider(
    settingsUseCases: SettingsUseCases(
      settingsRepository: SettingsRepositoryImpl(
        sharedPrefrencesDatasource:
            serviceLocator.get<SharedPreferencesDatasource>(),
      ),
    ),
  );

  // for dark mode provider
  @override
  void initState() {
    super.initState();
    setDarkMode();
  }

  setDarkMode() async {
    final darkMode =
        await darkModeProvider.settingsUseCases.getDarkModeFromStorage();

    darkMode.fold(
      (error) => darkModeProvider.darkMode = true,
      (darkMode) => darkModeProvider.darkMode = darkMode,
    );

    final autoDarkMode =
        await darkModeProvider.settingsUseCases.getAutoDarkModeFromStorage();

    autoDarkMode.fold(
      (error) => darkModeProvider.darkMode = true,
      (autoDarkMode) => darkModeProvider.autoDarkMode = autoDarkMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.authState is AuthLoaded) {
      final authState = widget.authState as AuthLoaded;
      widget.appRouter.authGuard.state = authState;

      if (authState.userResponse == null) {
        BlocProvider.of<CurrentUserCubit>(context).getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(
            id: Jwt.parseJwt(authState.token)["sub"],
          ),
        );
      } else if (authState.userResponse != null) {
        widget.appRouter.replace(const HomePageRoute());
      }
    }
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        lightDynamic != null
            ? lightColorScheme = lightDynamic
            : lightColorScheme = lightColorSchemeStatic;
        darkDynamic != null
            ? darkColorScheme = darkDynamic
            : darkColorScheme = darkColorSchemeStatic;

        return ChangeNotifierProvider(
          create: (context) => darkModeProvider,
          child: Consumer<DarkModeProvider>(
            builder: (context, value, child) {
              return PlatformApp.router(
                title: 'Social Media App',
                routeInformationParser: widget.appRouter.defaultRouteParser(),
                routerDelegate: widget.appRouter.delegate(),
                material: (context, platform) => MaterialAppRouterData(
                  theme: ThemeData(
                    //  scaffoldBackgroundColor: Colors.white,
                    useMaterial3: true,
                    colorScheme: lightColorScheme,
                  ),
                  darkTheme: ThemeData(
                    //    scaffoldBackgroundColor: Colors.black,
                    useMaterial3: true,
                    colorScheme: darkColorScheme,
                  ),
                  themeMode: value.autoDarkMode == true
                      ? ThemeMode.system
                      : value.darkMode == true
                          ? ThemeMode.dark
                          : ThemeMode.light,
                ),
                cupertino: (context, platform) => CupertinoAppRouterData(
                  theme: const CupertinoThemeData(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
