import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/profile_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_map_page/home_map_page_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/image/image_cubit.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_user_filter.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection.dart' as di;
import 'one_signal.dart' as one_signal;
import 'presentation/router/router.gr.dart' as r;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  await one_signal.init();

  runApp(const BlocInitializer());
}

class BlocInitializer extends StatelessWidget {
  const BlocInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.serviceLocator<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<ProfilePageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<MessageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<UserSearchCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<ChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<AddChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<CurrentChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<PrivateEventCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<AddPrivateEventCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<CurrentPrivateEventCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<HomeMapPageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<ImageCubit>(),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = r.AppRouter(
      authGuard: AuthGuard(state: BlocProvider.of<AuthCubit>(context).state),
    );

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        appRouter.authGuard.state = state;
        if (state is AuthLoaded) {
          BlocProvider.of<ProfilePageCubit>(context).getOneUserViaApi(
            getOneUserFilter: GetOneUserFilter(
              id: Jwt.parseJwt(state.token)["sub"],
            ),
          );
          appRouter.replace(const HomePageRoute());
        }
      },
      child: DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          BlocProvider.of<AuthCubit>(context).getTokenAndLoadUser();

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
      ),
    );
  }
}
