import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection.dart' as di;
import 'presentation/router/router.gr.dart' as r;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await di.init();
  runApp(const BlocInitializer());
}

class BlocInitializer extends StatelessWidget {
  const BlocInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<MessageBloc>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<UserSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<ChatBloc>(),
        ),
        BlocProvider(
          create: (context) => di.serviceLocator<PrivateEventBloc>(),
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
    final AppRouter _appRouter = r.AppRouter(
      authGuard: AuthGuard(state: BlocProvider.of<AuthBloc>(context).state),
    );

    return BlocListener<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(AuthGetTokenEvent()),
      listener: (context, state) async {
        _appRouter.authGuard.state = state;
        if (state is AuthStateLoaded) {
          _appRouter.replace(const HomePageRoute());
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

          return MaterialApp.router(
            title: 'Social Media App',
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
