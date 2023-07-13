import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_pages_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_change_chat_username_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_future_private_events_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_info_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_add_user_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_page_wrapper.dart';
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_update_permissions_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/future_events_page/future_events_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_event_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_search_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_permissions_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_permissions_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/past_events_page/past_events_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_create_shopping_list_item_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_invite_user_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_update_loaction_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_update_permissions_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_change_user_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_chat.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_info.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/private_event_tab_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_chat_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/imprint_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_deletion_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_insight.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/groupchat_add_me_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/private_event_add_me_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/settings_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_change_user_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_wrapper_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final AuthPagesGuard authPagesGuard;
  final VerifyEmailPageGuard verifyEmailPageGuard;
  final AuthGuard authGuard;
  final CreateUserPageGuard createUserPageGuard;

  AppRouter({
    required this.authPagesGuard,
    required this.authGuard,required this.createUserPageGuard,required this.verifyEmailPageGuard,
  });

  @override      
  List<AutoRoute> get routes => [      
    AutoRoute(
      page: LoginRoute.page,
      initial: false,
      guards: [authPagesGuard],
    ),
    AutoRoute(
      page: ResetPasswordRoute.page,
      initial: false,
      guards: [authPagesGuard],
    ),
    AutoRoute(
      page: RegisterRoute.page,
      initial: false,
      guards: [authPagesGuard],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: AuthorizedRoute.page,
      path: '/',
      initial: true,
      children: [
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: VerifyEmailRoute.page,
          initial: false,
          guards: [verifyEmailPageGuard],
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: CreateUserRoute.page,
          initial: false,
          guards: [createUserPageGuard],
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: BlocInitRoute.page,
          path: '',
          initial: true,
          guards: [authGuard],
          children: [
            homePageRouter,
            ...settingRoutes,

            // future and past events
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              page: FutureEventsPage,
              guards: [authGuard],
              path: 'future-events',
            ),
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              page: PastEventsPage,
              guards: [authGuard],
              path: 'past-events',
            ),

            //Shopping List page
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              page: ShoppingListWrapperPage,
              guards: [authGuard],
              path: 'shopping-list',
              children: [
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                  page: ShoppingListPage,
                  guards: [authGuard],
                  path: '',
                ),
                CustomRoute(
                  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                  page: ShoppingListItemWrapperPage,
                  guards: [authGuard],
                  path: ':shoppingListItemId',
                  children: [
                    CustomRoute(
                      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                      page: ShoppingListItemPage,
                      guards: [authGuard],
                      path: '',
                    ),
                    CustomRoute(
                      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                      page: ShoppingListItemChangeUserPage,
                      guards: [authGuard],
                      path: 'change-user-to-buy-item',
                    ),
                  ],
                ),
                RedirectRoute(path: '*', redirectTo: '')
              ],
            ),

            _groupchatRouter,
            _privateEventRouter,
            profileRouter,

            // new groupchat
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              page: NewGroupchatWrapperPage,
              guards: [authGuard],
              path: 'new-groupchat',
              children: [
                AutoRoute(
                  page: NewGroupchatDetailsTab,
                  initial: true,
                  guards: [authGuard],
                  path: '',
                ),
                AutoRoute(
                  page: NewGroupchatSelectUserTab,
                  initial: false,
                  guards: [authGuard],
                  path: 'users',
                ),
                AutoRoute(
                  page: NewGroupchatPermissionsTab,
                  initial: false,
                  guards: [authGuard],
                  path: 'permssions',
                ),
                RedirectRoute(path: '*', redirectTo: '')
              ],
            ),

            // new private event
            CustomRoute(
              transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
              page: NewPrivateEventPage,
              guards: [authGuard],
              path: 'new-private-event',
              children: [
                AutoRoute(
                  page: NewPrivateEventDetailsTab,
                  initial: true,
                  guards: [authGuard],
                  path: '',
                ),
                AutoRoute(
                  page: NewPrivateEventTypeTab,
                  initial: true,
                  guards: [authGuard],
                  path: 'type',
                ),
                AutoRoute(
                  page: NewPrivateEventSearchTab,
                  initial: true,
                  guards: [authGuard],
                  path: 'search',
                ),
                AutoRoute(
                  page: NewPrivateEventDateTab,
                  guards: [authGuard],
                  path: 'date',
                ),
                AutoRoute(
                  page: NewPrivateEventLocationTab,
                  initial: false,
                  guards: [authGuard],
                  path: 'location',
                ),
                AutoRoute(
                  page: NewPrivateEventPermissionsTab,
                  initial: false,
                  guards: [authGuard],
                  path: 'permissions',
                ),
                RedirectRoute(path: '*', redirectTo: '')
              ],
            ),
          ],
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/chats')
  ],

  CustomRoute get _groupchatRouter => CustomRoute(
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  page: GroupchatRouteWrapper.page,
  guards: [authGuard],
  path: 'groupchat/:id',
  initial: true,
  children: [
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatRoute.page,
      guards: [authGuard],
      path: '',
      initial: true,
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatInfoRoute.page,
      guards: [authGuard],
      path: 'info',
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatChangeUsernameRoute.page,
      guards: [authGuard],
      path: 'change-chat-username',
      fullscreenDialog: true,
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatFuturePrivateEventsRoute.page,
      guards: [authGuard],
      path: 'private-events',
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatAddUserRoute.page,
      guards: [authGuard],
      path: 'add-user',
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: GroupchatUpdatePermissionsRoute.page,
      guards: [authGuard],
      path: 'update-permissions',
    ),
    RedirectRoute(path: '*', redirectTo: '')
  ],
);

  CustomRoute get _privateEventRouter => CustomRoute(
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  page: PrivateEventWrapperPage,
  guards: [authGuard],
  path: 'private-event/:id',
  children: [
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventTabPage,
      initial: true,
      path: '',
      guards: [authGuard],
      children: [
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventTabInfo,
          initial: true,
          path: 'info',
          guards: [authGuard],
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventTabChat,
          initial: true,
          path: 'chat',
          guards: [authGuard],
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventTabUserList,
          initial: false,
          path: 'users',
          guards: [authGuard],
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventTabShoppingList,
          initial: false,
          path: 'shopping-list',
          guards: [authGuard],
        )
      ],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventUpdateLocationPage,
      initial: true,
      path: 'update-location',
      guards: [authGuard],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventUpdatePermissionsPage,
      guards: [authGuard],
      path: 'update-permissions',
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventInviteUserPage,
      initial: true,
      path: 'invite',
      guards: [authGuard],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventCreateShoppingListItemPage,
      initial: true,
      path: 'create-shopping-list-item',
      guards: [authGuard],
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: PrivateEventShoppingListItemWrapperPage,
      guards: [authGuard],
      path: 'shopping-list/:shoppingListItemId',
      children: [
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventShoppingListItemPage,
          guards: [authGuard],
          path: '',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventShoppingListItemChangeUserPage,
          guards: [authGuard],
          path: 'change-user-to-buy-item',
        ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: 'info'),
  ],
);
}

const profileRouter = CustomRoute(
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  page: ProfileWrapperPage,
  initial: false,
  guards: [authGuard],
  path: 'profile/:id',
  children: [
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: ProfilePage,
      guards: [authGuard],
      path: '',
    ),
    CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: ProfileChatPage,
      guards: [authGuard],
      path: 'chat',
    ),
    AutoRoute(
      page: ProfileUserRelationsTabPage,
      guards: [authGuard],
      path: 'user-relations',
      children: [
        AutoRoute(
          page: ProfileFollowerTab,
          guards: [authGuard],
          path: 'follower',
        ),
        AutoRoute(
          page: ProfileFollowedTab,
          guards: [authGuard],
          path: 'followed',
        ),
        AutoRoute(
          page: ProfileFollowRequestsTab,
          guards: [authGuard],
          path: 'follow-requests',
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '')
  ],
);

const homePageRouter = CustomRoute(
  transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  page: HomePage,
  initial: true,
  guards: [authGuard],
  path: '',
  children: [
    AutoRoute(
      page: HomeChatPage,
      guards: [authGuard],
      path: 'chats',
      initial: true,
    ),
    AutoRoute(page: HomeEventPage, guards: [authGuard], path: 'events'),
    AutoRoute(page: HomeSearchPage, guards: [authGuard], path: 'search'),
    AutoRoute(
      page: HomeProfilePage,
      guards: [authGuard],
      path: 'current-profile/:id',
      children: [
        AutoRoute(
          page: ProfilePage,
          guards: [authGuard],
          path: '',
        ),
        //Doesnt need settings page because current user hasnt relation to change
        AutoRoute(
          page: ProfileUserRelationsTabPage,
          guards: [authGuard],
          path: 'user-relations',
          fullscreenDialog: true,
          children: [
            AutoRoute(
              page: ProfileFollowerTab,
              guards: [authGuard],
              path: 'follower',
            ),
            AutoRoute(
              page: ProfileFollowedTab,
              guards: [authGuard],
              path: 'followed',
            ),
            AutoRoute(
              page: ProfileFollowRequestsTab,
              guards: [authGuard],
              path: 'follow-requests',
            ),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: '')
      ],
    ),
    RedirectRoute(path: '*', redirectTo: 'chats')
  ],
);

const settingRoutes = [
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: SettingsPage,
    guards: [authGuard],
    path: 'settings',
  ),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: ThemeModePage,
    guards: [authGuard],
    path: 'settings/theme',
  ),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: UpdatePasswordPage,
    guards: [authGuard],
    path: 'settings/update-password',
  ),
  CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: SettingsInfoPage,
      guards: [authGuard],
      path: 'settings/info'),
  CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: RightOnInsightPage,
      guards: [authGuard],
      path: 'settings/info/right-on-insight'),
  CustomRoute(
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      page: RightOnDeletionPage,
      guards: [authGuard],
      path: 'settings/info/right-on-deletion'),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: ImprintPage,
    guards: [authGuard],
    path: 'settings/info/imprint',
  ),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: SettingsPrivacyPage,
    guards: [authGuard],
    path: 'settings/privacy',
  ),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: GroupchatAddMePage,
    guards: [authGuard],
    path: 'settings/privacy/groupchat-add-me-permission',
  ),
  CustomRoute(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
    page: PrivateEventAddMePage,
    guards: [authGuard],
    path: 'settings/privacy/private-event-add-me-permission',
  ),
];
