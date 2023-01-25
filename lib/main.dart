import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_profile_page/home_profile_page_cubit.dart';
import 'package:social_media_app_flutter/bloc_init.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
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

class App extends StatelessWidget {
  final AuthState authState;
  final AppRouter appRouter;
  const App({super.key, required this.authState, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    if (authState is AuthLoaded) {
      final authState = this.authState as AuthLoaded;
      appRouter.authGuard.state = authState;
      appRouter.replace(const HomePageRoute());

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

        return PlatformApp.router(
          title: 'Social Media App',
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
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
            themeMode: ThemeMode.system,
          ),
          cupertino: (context, platform) => CupertinoAppRouterData(
            theme: const CupertinoThemeData(),
          ),
        );
      },
    );
  }
}
