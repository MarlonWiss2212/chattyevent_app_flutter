import 'dart:async';
import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/provider/darkMode.dart';
import 'package:social_media_app_flutter/bloc_init.dart';
import 'package:social_media_app_flutter/core/colors.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/firebase_options.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/one_signal.dart' as one_signal;
import 'core/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await dotenv.load(fileName: '.dev.env');
  await di.init();

  if (!kIsWeb) {
    if (Platform.isAndroid || Platform.isIOS) {
      await MobileAds.instance.initialize();
      await one_signal.init();
    }
  }

  final String? token =
      await serviceLocator<FirebaseAuth>().currentUser?.getIdToken();

  print(token);

  final authState = AuthState(
    currentUser: UserEntity(
      authId: di.serviceLocator<FirebaseAuth>().currentUser?.uid ?? "",
      id: "",
    ),
    token: token,
    status: token != null ? AuthStateStatus.success : AuthStateStatus.initial,
  );

  runApp(
    BlocProvider.value(
      value: NotificationCubit(),
      child: Builder(
        builder: (context) => BlocProvider.value(
          value: AuthCubit(
            authState,
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            auth: di.serviceLocator(),
            notificationUseCases: di.serviceLocator(),
            userUseCases: di.serviceLocator(param1: authState),
            authUseCases: di.serviceLocator(),
          ),
          child: const BlocInit(),
        ),
      ),
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
                routeInformationProvider: widget.appRouter.routeInfoProvider(),
                routeInformationParser: widget.appRouter.defaultRouteParser(),
                routerDelegate: widget.appRouter.delegate(),
                builder: (context, widget) {
                  return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(),
                    child: widget!,
                  );
                },
                material: (context, platform) => MaterialAppRouterData(
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                    ),
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: lightColorScheme,
                  ),
                  darkTheme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.black,
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

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
