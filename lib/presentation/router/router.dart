import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page_wrapper.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_map_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_search_page.dart';
import 'package:social_media_app_flutter/presentation/screens/login_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_select_users_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/pages/groupchat_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/pages/info_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/private_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: false),
    AutoRoute(page: RegisterPage, initial: false),

    //profile page
    AutoRoute(page: ProfilePage, initial: false, guards: [AuthGuard]),

    // home page
    AutoRoute(
      page: HomePage,
      initial: true,
      guards: [AuthGuard],
      children: [
        AutoRoute(
          page: HomeChatPage,
          guards: [AuthGuard],
          path: 'chats',
          initial: true,
        ),
        AutoRoute(page: HomeEventPage, guards: [AuthGuard], path: 'events'),
        AutoRoute(page: HomeMapPage, guards: [AuthGuard], path: 'map'),
        AutoRoute(page: HomeSearchPage, guards: [AuthGuard], path: 'search'),
        AutoRoute(page: HomeProfilePage, guards: [AuthGuard], path: 'profile'),
        RedirectRoute(path: '*', redirectTo: 'chats')
      ],
    ),

    // chat page
    AutoRoute(
      page: ChatPageWrapper,
      guards: [AuthGuard],
      path: '/chat-page/:id',
      children: [
        AutoRoute(
          page: ChatPage,
          guards: [AuthGuard],
          path: '',
          initial: true,
        ),
        AutoRoute(page: ChatInfoPage, guards: [AuthGuard], path: 'info'),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),

    // private event page
    AutoRoute(
      page: PrivateEventPage,
      guards: [AuthGuard],
      path: '/private-event/:id',
      children: [
        AutoRoute(page: GroupchatTab, initial: true, path: 'chat'),
        AutoRoute(page: InfoTab, path: 'info'),
        RedirectRoute(path: '*', redirectTo: 'chat')
      ],
    ),

    // new groupchat
    AutoRoute(
      page: NewGroupchatWrapperPage,
      guards: [AuthGuard],
      path: '/new-groupchat',
      children: [
        AutoRoute(
          page: NewGroupchatPage,
          initial: true,
          guards: [AuthGuard],
          path: '',
        ),
        AutoRoute(
          page: NewGroupchatPageSelectUsersPage,
          initial: false,
          guards: [AuthGuard],
          path: 'users',
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),

    // new private event
    AutoRoute(
      page: NewPrivateEventPage,
      guards: [AuthGuard],
      path: '/new-private-event',
    ),

    RedirectRoute(path: '*', redirectTo: '')
  ],
)
class $AppRouter {}
