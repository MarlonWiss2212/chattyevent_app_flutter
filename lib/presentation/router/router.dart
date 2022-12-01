import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/presentation/screens/login_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';
import 'package:social_media_app_flutter/presentation/splash/splash.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: LoginPage, initial: false),
    AutoRoute(page: RegisterPage, initial: false),
    AutoRoute(page: HomePage, initial: false),
    AutoRoute(page: ChatPage, initial: false),
    AutoRoute(page: NewGroupchatPage, initial: false),
    AutoRoute(page: NewPrivateEventPage, initial: false),
  ],
)
class $AppRouter {}
