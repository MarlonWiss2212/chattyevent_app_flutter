import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_add_user_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page_wrapper.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_map_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/home_page/pages/home_search_page.dart';
import 'package:social_media_app_flutter/presentation/screens/login_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_page/create_shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/pages/info_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_page/current_shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/private_event_tab_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/settings_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/settings_page_wrapper.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_page/shopping_list_wrapper_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: false),
    AutoRoute(page: RegisterPage, initial: false),

    //profile page
    AutoRoute(
      page: ProfilePage,
      initial: false,
      guards: [AuthGuard],
      path: '/profile/:id',
    ),

    // settings page
    AutoRoute(
      page: SettingsWrapperPage,
      guards: [AuthGuard],
      path: "/settings",
      children: [
        AutoRoute(page: SettingsPage, guards: [AuthGuard], path: ''),
        AutoRoute(page: ThemeModePage, guards: [AuthGuard], path: 'theme-mode'),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),

    // home page
    AutoRoute(
      page: HomePage,
      initial: true,
      guards: [AuthGuard],
      path: '/',
      children: [
        AutoRoute(
          page: HomeChatPage,
          guards: [AuthGuard],
          path: 'chats',
          initial: true,
        ),
        AutoRoute(page: HomeEventPage, guards: [AuthGuard], path: 'events'),
        AutoRoute(page: Location, guards: [AuthGuard], path: 'map'),
        AutoRoute(page: HomeSearchPage, guards: [AuthGuard], path: 'search'),
        AutoRoute(page: HomeProfilePage, guards: [AuthGuard], path: 'profile'),
        RedirectRoute(path: '*', redirectTo: 'chats')
      ],
    ),

    // chat page
    AutoRoute(
      page: ChatPageWrapper,
      guards: [AuthGuard],
      path: '/chats/:id',
      children: [
        AutoRoute(
          page: ChatPage,
          guards: [AuthGuard],
          path: '',
          initial: true,
        ),
        AutoRoute(page: ChatInfoPage, guards: [AuthGuard], path: 'info'),
        AutoRoute(
          page: ChatAddUserPage,
          guards: [AuthGuard],
          path: 'add-user',
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),

    // private event page
    AutoRoute(
      page: PrivateEventTabPage,
      guards: [AuthGuard],
      path: '/private-event/:id',
      children: [
        AutoRoute(
          page: InfoTab,
          initial: true,
          path: 'info',
          guards: [AuthGuard],
        ),
        // TODO: make this to an own router
        AutoRoute(
          page: ShoppingListWrapperPage,
          guards: [AuthGuard],
          path: 'shopping-list',
          children: [
            AutoRoute(
              page: ShoppingListPage,
              initial: true,
              path: '',
              guards: [AuthGuard],
            ),
            AutoRoute(
              page: CurrentShoppingListItemPage,
              initial: true,
              path: ':shoppingListItemId',
              guards: [AuthGuard],
            ),
            AutoRoute(
              page: CreateShoppingListItem,
              initial: false,
              path: 'create',
              guards: [AuthGuard],
            ),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: 'info'),
      ],
    ),

    // new groupchat
    AutoRoute(
      page: NewGroupchatWrapperPage,
      guards: [AuthGuard],
      path: '/new-groupchat',
      children: [
        AutoRoute(
          page: NewGroupchatDetailsTab,
          initial: true,
          guards: [AuthGuard],
          path: '',
        ),
        AutoRoute(
          page: NewGroupchatSelectUserTab,
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
      children: [
        AutoRoute(
          page: NewPrivateEventDetailsTab,
          initial: true,
          guards: [AuthGuard],
          path: '',
        ),
        AutoRoute(
          page: NewPrivateEventSearchGroupchatTab,
          guards: [AuthGuard],
          path: 'groupchat',
        ),
        AutoRoute(
          page: NewPrivateEventLocationTab,
          initial: false,
          guards: [AuthGuard],
          path: 'location',
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/chats')
  ],
)
class $AppRouter {}
