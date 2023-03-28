import 'package:auto_route/auto_route.dart';
import 'package:social_media_app_flutter/presentation/router/auth_guard.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_future_private_events_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_info_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_add_user_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page.dart';
import 'package:social_media_app_flutter/presentation/screens/chat_page/chat_page_wrapper.dart';
import 'package:social_media_app_flutter/presentation/screens/create_user_page.dart';
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
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_user_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/private_event_create_shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/private_event_invite_user_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_info.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_user_list.dart';
import 'package:social_media_app_flutter/presentation/screens/private_event_page/tab_page/private_event_tab_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart';
import 'package:social_media_app_flutter/presentation/screens/profile_page/profile_wrapper_page.dart';
import 'package:social_media_app_flutter/presentation/screens/register_page.dart';
import 'package:social_media_app_flutter/presentation/screens/reset_password_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/settings_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart';
import 'package:social_media_app_flutter/presentation/screens/settings_page/settings_page_wrapper.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_item_page/shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_item_page/standard_shopping_list_item_page.dart';
import 'package:social_media_app_flutter/presentation/screens/verify_email_page.dart';
import 'package:social_media_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, initial: false),
    AutoRoute(page: VerifyEmailPage, initial: false),
    AutoRoute(page: ResetPasswordPage, initial: false),
    AutoRoute(page: RegisterPage, initial: false),
    AutoRoute(page: CreateUserPage, initial: false, guards: [AuthGuard]),

    //profile page
    AutoRoute(
      page: ProfileWrapperPage,
      initial: false,
      guards: [AuthGuard],
      path: '/profile/:id',
      children: [
        AutoRoute(
          page: ProfilePage,
          guards: [AuthGuard],
          path: '',
        ),
        AutoRoute(
          page: ProfileUserRelationsTabPage,
          guards: [AuthGuard],
          path: 'user-relations',
          children: [
            AutoRoute(
              page: ProfileFollowerTab,
              guards: [AuthGuard],
              path: 'follower',
            ),
            AutoRoute(
              page: ProfileFollowedTab,
              guards: [AuthGuard],
              path: 'followed',
            ),
            AutoRoute(
              page: ProfileFollowRequestsTab,
              guards: [AuthGuard],
              path: 'follow-requests',
            ),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),

    // settings page
    AutoRoute(
      page: SettingsWrapperPage,
      guards: [AuthGuard],
      path: "/settings",
      children: [
        AutoRoute(page: SettingsPage, guards: [AuthGuard], path: ''),
        AutoRoute(page: ThemeModePage, guards: [AuthGuard], path: 'theme-mode'),
        AutoRoute(
          page: UpdatePasswordPage,
          guards: [AuthGuard],
          path: 'update-password',
        ),
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
        AutoRoute(
          page: HomeProfilePage,
          guards: [AuthGuard],
          path: 'current-profile/:id',
          children: [
            AutoRoute(
              page: ProfilePage,
              guards: [AuthGuard],
              path: '',
            ),
            AutoRoute(
              page: ProfileUserRelationsTabPage,
              guards: [AuthGuard],
              path: 'user-relations',
              fullscreenDialog: true,
              children: [
                AutoRoute(
                  page: ProfileFollowerTab,
                  guards: [AuthGuard],
                  path: 'follower',
                ),
                AutoRoute(
                  page: ProfileFollowedTab,
                  guards: [AuthGuard],
                  path: 'followed',
                ),
                AutoRoute(
                  page: ProfileFollowRequestsTab,
                  guards: [AuthGuard],
                  path: 'follow-requests',
                ),
              ],
            ),
            RedirectRoute(path: '*', redirectTo: '')
          ],
        ),
        RedirectRoute(path: '*', redirectTo: 'chats')
      ],
    ),

    //Shopping List page
    AutoRoute(
      page: ShoppingListPage,
      guards: [AuthGuard],
      path: '/shopping-list',
    ),

    //Shopping List item page
    AutoRoute(
      page: ShoppingListItemPage,
      guards: [AuthGuard],
      path: '/shopping-list/:shoppingListItemId',
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
          page: ChatFuturePrivateEventsPage,
          guards: [AuthGuard],
          path: 'private-events',
        ),
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
      page: PrivateEventWrapperPage,
      guards: [AuthGuard],
      path: '/private-event/:id',
      children: [
        AutoRoute(
          page: PrivateEventTabPage,
          initial: true,
          path: 'info',
          guards: [AuthGuard],
          children: [
            AutoRoute(
              page: PrivateEventTabInfo,
              initial: true,
              path: 'info',
              guards: [AuthGuard],
            ),
            AutoRoute(
              page: PrivateEventTabUserList,
              initial: false,
              path: 'users',
              guards: [AuthGuard],
            ),
            AutoRoute(
              page: PrivateEventTabShoppingList,
              initial: false,
              path: 'shopping-list',
              guards: [AuthGuard],
            )
          ],
        ),
        AutoRoute(
          page: PrivateEventInviteUserPage,
          initial: true,
          path: 'invite',
          guards: [AuthGuard],
        ),
        AutoRoute(
          page: PrivateEventCreateShoppingListItemPage,
          initial: true,
          path: 'create-shopping-list-item',
          guards: [AuthGuard],
        ),
        AutoRoute(
          page: StandardShoppingListItemPage,
          initial: false,
          path: 'shopping-list/:shoppingListItemId',
          guards: [AuthGuard],
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
          page: NewPrivateEventTypeTab,
          initial: true,
          guards: [AuthGuard],
          path: 'type',
        ),
        AutoRoute(
          page: NewPrivateEventSearchUserTab,
          initial: true,
          guards: [AuthGuard],
          path: 'users',
        ),
        AutoRoute(
          page: NewPrivateEventSearchGroupchatTab,
          guards: [AuthGuard],
          path: 'groupchat',
        ),
        AutoRoute(
          page: NewPrivateEventDateTab,
          guards: [AuthGuard],
          path: 'date',
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
