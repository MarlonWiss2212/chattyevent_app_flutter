import 'dart:async';
import 'dart:io';
import 'package:chattyevent_app_flutter/ad_pop_up_form.dart';
import 'package:chattyevent_app_flutter/core/utils/material_theme_utils.dart';
import 'package:chattyevent_app_flutter/scroll_bahaviour.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/provider/darkMode.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/firebase_options.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/one_signal_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
  await InjectionUtils.init();

  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      await OneSignalUtils.initialize();
    }
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: serviceLocator<NotificationCubit>()),
        BlocProvider.value(value: serviceLocator<AuthCubit>()),
      ],
      child: Builder(builder: (context) {
        return MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (p, c) => p.userException != c.userException,
              listener: (context, state) {
                if (state.isUserCode404()) {
                  serviceLocator<AppRouter>().root.popUntilRoot();
                  serviceLocator<AppRouter>().root.replace(
                      const AuthorizedPageRoute(
                          children: [CreateUserPageRoute()]));
                }
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (p, c) => c.goOnCreateUserPage,
              listener: (context, state) {
                serviceLocator<AppRouter>().root.popUntilRoot();
                serviceLocator<AppRouter>().root.replace(
                    const AuthorizedPageRoute(
                        children: [CreateUserPageRoute()]));
              },
            ),
            BlocListener<AuthCubit, AuthState>(
              listenWhen: (p, c) => p.status != c.status,
              listener: (context, state) {
                if (state.status == AuthStateStatus.loggedIn &&
                    state.token != null) {
                  serviceLocator<AppRouter>()
                      .replace(const AuthorizedPageRoute(children: [
                    BlocInitPageRoute(children: [HomePageRoute()])
                  ]));
                } else if (state.status == AuthStateStatus.logout) {
                  serviceLocator<AppRouter>().popUntilRoot();
                  serviceLocator<AppRouter>().replace(const LoginPageRoute());
                }
              },
            ),
          ],
          child: const App(),
        );
      }),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DarkModeProvider darkModeProvider = DarkModeProvider(
    settingsUseCases: serviceLocator(),
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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        lightDynamic != null
            ? lightColorScheme = lightDynamic
            : lightColorScheme = MaterialThemeUtils.lightColorSchemeStatic;
        darkDynamic != null
            ? darkColorScheme = darkDynamic
            : darkColorScheme = MaterialThemeUtils.darkColorSchemeStatic;

        return ChangeNotifierProvider(
          create: (context) => darkModeProvider,
          child: Consumer<DarkModeProvider>(
            builder: (context, value, child) {
              return MaterialApp.router(
                title: 'ChattyEvent',
                routeInformationParser:
                    serviceLocator<AppRouter>().defaultRouteParser(),
                routerDelegate: serviceLocator<AppRouter>().delegate(),
                builder: (context, widget) {
                  return SafeArea(
                    child: ScrollConfiguration(
                      behavior: const ScrollBehaviorModified(),
                      child: AdPopUp(child: widget!),
                    ),
                  );
                },
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shadowColor: Colors.transparent,
                  ),
                  tabBarTheme: TabBarTheme(
                    indicatorColor: lightColorScheme.primary,
                    labelColor: lightColorScheme.primary,
                    dividerColor: lightColorScheme.primary,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: lightColorScheme.primaryContainer,
                    ),
                  ),
                  bottomAppBarTheme: const BottomAppBarTheme(
                    color: Colors.white,
                  ),
                  scaffoldBackgroundColor: Colors.white,
                  colorScheme: lightColorScheme,
                ),
                darkTheme: ThemeData(
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                  ),
                  tabBarTheme: TabBarTheme(
                    indicatorColor: darkColorScheme.primary,
                    labelColor: darkColorScheme.primary,
                    dividerColor: darkColorScheme.primary,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: darkColorScheme.primaryContainer,
                    ),
                  ),
                  bottomAppBarTheme: const BottomAppBarTheme(
                    color: Colors.black,
                  ),
                  scaffoldBackgroundColor: Colors.black,
                  colorScheme: darkColorScheme,
                ),
                themeMode: value.autoDarkMode == true
                    ? ThemeMode.system
                    : value.darkMode == true
                        ? ThemeMode.dark
                        : ThemeMode.light,
              );
            },
          ),
        );
      },
    );
  }
}
