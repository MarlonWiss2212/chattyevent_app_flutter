import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_profile/user_profile_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

import 'injection.dart' as di;
import 'presentation/router/router.gr.dart' as r;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
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
          create: (context) => di.serviceLocator<UserProfileBloc>(),
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
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  final AppRouter _appRouter = r.AppRouter();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(AuthGetTokenEvent()),
      listener: (context, state) async {
        if (state is AuthStateLoaded) {
          final HttpLink httpLink = HttpLink("http://localhost:3000/graphql");
          final AuthLink authLink = AuthLink(
            getToken: () => "Bearer ${state.token}",
          );
          await di.serviceLocator.reset();
          await di.init(link: authLink.concat(httpLink));
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
