import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/edit_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/add_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/edit_private_event_cubit.dart';
import 'package:social_media_app_flutter/colors.dart';
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
          create: (context) => di.serviceLocator<EditChatCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<PrivateEventCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<AddPrivateEventCubit>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<EditPrivateEventCubit>(),
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

    BlocProvider.of<AuthCubit>(context).getToken();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        appRouter.authGuard.state = state;

        if (state is AuthStateLoaded) {
          appRouter.replace(const HomePageRoute());
        } else if (state is AuthStateLoadingCurrentUser) {
          // appRouter.replace(const LoadingCurrentUserPageRoute());
        }
      },
      child: DynamicColorBuilder(
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
      ),
    );
  }
}
