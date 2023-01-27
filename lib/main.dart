import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/provider/darkMode.dart';
import 'package:social_media_app_flutter/bloc_init.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/domain/usecases/settings_usecases.dart';
import 'package:social_media_app_flutter/infastructure/respositories/device/settings_repository_impl.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection.dart' as di;
import 'one_signal.dart' as one_signal;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await MobileAds.instance.initialize();
  await di.init();
  await one_signal.init();

  runApp(
    BlocProvider(
      create: (context) => di.serviceLocator<AuthCubit>(),
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
        sharedPrefrencesDatasource: di.serviceLocator(),
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
      widget.appRouter.replace(const HomePageRoute());

      if (authState.userResponse == null) {
        BlocProvider.of<HomeProfilePageCubit>(context).getOneUserViaApi(
          getOneUserFilter: GetOneUserFilter(
            id: Jwt.parseJwt(authState.token)["sub"],
          ),
        );
      } else {
        BlocProvider.of<HomeProfilePageCubit>(context)
            .setCurrentUserFromAnotherResponse(
          user: authState.userResponse!,
        );
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
                    scaffoldBackgroundColor: Colors.white,
                    useMaterial3: true,
                    colorScheme: lightColorScheme,
                  ),
                  darkTheme: ThemeData(
                    scaffoldBackgroundColor: Colors.black,
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
