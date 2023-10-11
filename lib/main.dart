import 'dart:async';
import 'dart:io';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state_status.dart';
import 'package:chattyevent_app_flutter/application/bloc/imprint/imprint_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/introduction/introduction_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/hive_utils.dart';
import 'package:chattyevent_app_flutter/core/utils/localization_utils.dart';
import 'package:chattyevent_app_flutter/core/utils/material_theme_utils.dart';
import 'package:chattyevent_app_flutter/domain/usecases/auth_usecases.dart';
import 'package:chattyevent_app_flutter/generated/codegen_loader.g.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.dart';
import 'package:chattyevent_app_flutter/scroll_bahaviour.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/provider/dark_mode.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/firebase_options.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/one_signal_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    HiveUtils.initialize(),
    LocalizationUtils.init(),
    dotenv.load(fileName: '.env'),
  ]);

  final List<Future> futures = [];

  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      futures.add(MobileAds.instance.initialize());
    }
  }

  await Future.wait([
    ...futures,
    InjectionUtils.initialize(),
    OneSignalUtils.initialize(),
    EasyLocalization.ensureInitialized(),
  ]);

  //set locales
  final String languageCode = LocalizationUtils.systemLocale.split("_")[0];
  await Future.wait([
    serviceLocator<AuthUseCases>().setLanguageCode(languageCode: languageCode),
    //serviceLocator<OneSignalUseCases>().setLanguageCode(
    //  languageCode: languageCode,
    //),
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale("en"),
        Locale("de"),
        //Locale("es"),
        //Locale("pt"),
        //Locale("fr"),
        //Locale("it"),
        //Locale("nl"),
      ],
      path: "assets/translations",
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale("en"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => serviceLocator<NotificationCubit>()),
          BlocProvider(create: (_) => serviceLocator<AuthCubit>()),
          BlocProvider(
            create: (_) => serviceLocator<InternetConnectionCubit>(),
          ),
          BlocProvider(create: (_) => serviceLocator<ImprintCubit>()),
          BlocProvider(create: (_) => serviceLocator<IntroductionCubit>()),
        ],
        child: Builder(
          builder: (context) {
            return MultiBlocListener(
              listeners: [
                BlocListener<AuthCubit, AuthState>(
                  listenWhen: (p, c) => p.status != c.status,
                  listener: (context, state) async {
                    if (state.status == AuthStateStatus.loggedIn &&
                        state.token != null) {
                      serviceLocator<AppRouter>().root.replace(
                            const AuthorizedRoute(
                              children: [
                                HomeRoute(),
                              ],
                            ),
                          );
                    } else if (state.status == AuthStateStatus.logout) {
                      serviceLocator<AppRouter>().root.popUntilRoot();
                      serviceLocator<AppRouter>().root.replace(
                            const LoginRoute(),
                          );
                    }
                  },
                ),
                BlocListener<InternetConnectionCubit, InternetConnectionState>(
                  listenWhen: (p, c) => p.hasInternet != c.hasInternet,
                  listener: (context, state) {
                    if (state.hasInternet) {
                      BlocProvider.of<NotificationCubit>(context).newAlert(
                        notificationAlert: NotificationAlert(
                          title:
                              "general.notificationAlert.internetIsThereAlert.title"
                                  .tr(),
                          message:
                              "general.notificationAlert.internetIsThereAlert.message"
                                  .tr(),
                          snackbar: true,
                          snackBarColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                      );
                    } else {
                      BlocProvider.of<NotificationCubit>(context).newAlert(
                        notificationAlert: NotificationAlert(
                          title:
                              "general.notificationAlert.noInternetIsThereAlert.title"
                                  .tr(),
                          message:
                              "general.notificationAlert.noInternetIsThereAlert.message"
                                  .tr(),
                          snackbar: true,
                          snackBarColor:
                              Theme.of(context).colorScheme.errorContainer,
                        ),
                      );
                    }
                  },
                )
              ],
              child: const App(),
            );
          },
        ),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  DarkModeProvider darkModeProvider = serviceLocator();

  @override
  void initState() {
    final darkMode = darkModeProvider.settingsUseCases.getDarkModeFromStorage();

    darkMode.fold(
      (error) => darkModeProvider.darkMode = true,
      (darkMode) => darkModeProvider.darkMode = darkMode,
    );

    final autoDarkMode =
        darkModeProvider.settingsUseCases.getAutoDarkModeFromStorage();

    autoDarkMode.fold(
      (error) => darkModeProvider.darkMode = true,
      (autoDarkMode) => darkModeProvider.autoDarkMode = autoDarkMode,
    );

    super.initState();
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
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                title: 'ChattyEvent',
                routerConfig: serviceLocator<AppRouter>().config(),
                builder: (context, widget) {
                  return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(),
                    child: widget!,
                  );
                },
                theme: ThemeData(
                  useMaterial3: true,
                  inputDecorationTheme: InputDecorationTheme(
                    fillColor: const Color.fromARGB(255, 230, 230, 230),
                    filled: true,
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  listTileTheme: ListTileThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  tabBarTheme: TabBarTheme(
                    indicatorColor: lightColorScheme.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: lightColorScheme.primary,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: lightColorScheme.primaryContainer,
                    ),
                  ),
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                  ),
                  navigationRailTheme: const NavigationRailThemeData(
                    backgroundColor: Colors.white,
                  ),
                  colorScheme: lightColorScheme.copyWith(
                    background: Colors.white,
                    surface: const Color.fromARGB(255, 230, 230, 230),
                  ),
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: darkColorScheme.surface,
                    border: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  listTileTheme: ListTileThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  tabBarTheme: TabBarTheme(
                    indicatorColor: darkColorScheme.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: darkColorScheme.primary,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: darkColorScheme.primaryContainer,
                    ),
                  ),
                  appBarTheme: const AppBarTheme(
                    centerTitle: true,
                    color: Colors.black,
                    surfaceTintColor: Colors.black,
                  ),
                  navigationRailTheme: const NavigationRailThemeData(
                    backgroundColor: Colors.black,
                  ),
                  colorScheme: darkColorScheme.copyWith(
                    background: Colors.black,
                  ),
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
