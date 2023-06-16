import 'dart:async';
import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/provider/darkMode.dart';
import 'package:chattyevent_app_flutter/bloc_init.dart';
import 'package:chattyevent_app_flutter/core/colors.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/firebase_options.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/one_signal.dart' as one_signal;
import 'core/injection.dart' as di;
import 'package:flutter_funding_choices/flutter_funding_choices.dart' as fc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');
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
    status: token != null ? AuthStateStatus.loggedIn : AuthStateStatus.initial,
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
            permissionUseCases: di.serviceLocator(),
            userUseCases: di.serviceLocator(param1: authState),
            authUseCases: di.serviceLocator(),
          )..setCurrentUserFromFirebaseViaApi(),
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
              return MaterialApp.router(
                title: 'ChattyEvent',
                routeInformationParser: widget.appRouter.defaultRouteParser(),
                routerDelegate: widget.appRouter.delegate(),
                builder: (context, widget) {
                  return ScrollConfiguration(
                    behavior: const ScrollBehaviorModified(),
                    child: AdPopUp(child: widget!),
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

class AdPopUp extends StatefulWidget {
  final Widget child;
  const AdPopUp({super.key, required this.child});

  @override
  State<AdPopUp> createState() => _AdPopUpState();
}

class _AdPopUpState extends State<AdPopUp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fc.ConsentInformation consentInfo =
          await fc.FlutterFundingChoices.requestConsentInformation();
      if (consentInfo.isConsentFormAvailable &&
          consentInfo.consentStatus == fc.ConsentStatus.REQUIRED_ANDROID &&
          consentInfo.consentStatus == fc.ConsentStatus.REQUIRED_IOS) {
        await fc.FlutterFundingChoices.showConsentForm();
        // You can check the result by calling `FlutterFundingChoices.requestConsentInformation()` again !
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
