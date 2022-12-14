import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/presentation/screens/login_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_select_users_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: false),
    AutoRoute(page: RegisterPage, initial: false),
    AutoRoute(page: ProfilePage, initial: true, guards: [AuthGuard]),
    AutoRoute(page: HomePage, initial: true, guards: [AuthGuard]),
    AutoRoute(page: ChatPage, initial: false, guards: [AuthGuard]),
    AutoRoute(page: PrivateEventPage, initial: false, guards: [AuthGuard]),
    AutoRoute(page: NewGroupchatPage, initial: false, guards: [AuthGuard]),
    AutoRoute(
      page: NewGroupchatPageSelectUsersPage,
      initial: false,
      guards: [AuthGuard],
    ),
    AutoRoute(page: NewPrivateEventPage, initial: false, guards: [AuthGuard]),
  ],
)
class $AppRouter {}
