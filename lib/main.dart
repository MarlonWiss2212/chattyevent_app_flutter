import 'dart:async';
import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_profile/user_profile_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/user_search/user_search_bloc.dart';
import 'package:social_media_app_flutter/colors.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/presentation/screens/login_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';

import 'injection.dart' as di;
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  di.init(sharedPrefs);
  runApp(BlocInitializer(sharedPrefs: sharedPrefs));
}

class BlocInitializer extends StatelessWidget {
  final SharedPreferences sharedPrefs;
  const BlocInitializer({required this.sharedPrefs, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserSearchBloc>(),
        )
      ],
      child: AuthWidget(sharedPrefs: sharedPrefs),
    );
  }
}

class AuthWidget extends StatelessWidget {
  final SharedPreferences sharedPrefs;
  const AuthWidget({required this.sharedPrefs, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of<AuthBloc>(context)..add(AuthGetTokenEvent()),
      builder: (context, state) {
        final HttpLink httpLink = HttpLink("http://localhost:3000/graphql");
        if (state is AuthStateLoaded) {
          final AuthLink authLink = AuthLink(
            getToken: () => "Bearer ${state.token}",
          );

          serviceLocator.reset();
          di.init(sharedPrefs, link: authLink.concat(httpLink));
          return const App(initialRoute: '/');
        } else if (state is AuthStateLoading) {
          return const CircularProgressIndicator();
        } else if (state is AuthStateError) {
          return const App(initialRoute: '/login');
        } else {
          return Container();
        }
      },
    );
  }
}

class App extends StatelessWidget {
  final String initialRoute;
  const App({required this.initialRoute, super.key});

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

        return MaterialApp(
          title: 'Social Media App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/': (context) => const HomePage(),
            '/newEvent': (context) => const NewPrivateEvent(),
            '/newGroupchat': (context) => const NewGroupchat(),
            ChatPage.routeName: (context) => const ChatPage()
          },
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}
