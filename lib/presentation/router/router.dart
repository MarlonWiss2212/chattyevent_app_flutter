import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/auth_pages_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart';
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final AuthPagesGuard authPagesGuard;
  final VerifyEmailPageGuard verifyEmailPageGuard;
  final AuthGuard authGuard;
  final CreateUserPageGuard createUserPageGuard;

  AppRouter({
    required this.authPagesGuard,
    required this.authGuard,
    required this.createUserPageGuard,
    required this.verifyEmailPageGuard,
  });

  @override
  List<AutoRoute> get routes {
    return [
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
              _homePageRoute,
              _groupchatRouter,
              _privateEventRouter,
              _profileRouter,
              ..._settingsRoutes,

              // future and past events
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: FutureEventsRoute.page,
                guards: [authGuard],
                path: 'future-events',
              ),
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PastEventsRoute.page,
                guards: [authGuard],
                path: 'past-events',
              ),

              //Shopping List page
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: ShoppingListWrapperRoute.page,
                guards: [authGuard],
                path: 'shopping-list',
                children: [
                  CustomRoute(
                    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                    page: ShoppingListRoute.page,
                    guards: [authGuard],
                    path: '',
                  ),
                  CustomRoute(
                    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                    page: ShoppingListItemWrapperRoute.page,
                    guards: [authGuard],
                    path: ':shoppingListItemId',
                    children: [
                      CustomRoute(
                        transitionsBuilder:
                            TransitionsBuilders.slideLeftWithFade,
                        page: ShoppingListItemRoute.page,
                        guards: [authGuard],
                        path: '',
                      ),
                      CustomRoute(
                        transitionsBuilder:
                            TransitionsBuilders.slideLeftWithFade,
                        page: ShoppingListItemChangeUserRoute.page,
                        guards: [authGuard],
                        path: 'change-user-to-buy-item',
                      ),
                    ],
                  ),
                  RedirectRoute(path: '*', redirectTo: '')
                ],
              ),

              // new groupchat
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: NewGroupchatWrapperRoute.page,
                guards: [authGuard],
                path: 'new-groupchat',
                children: [
                  AutoRoute(
                    page: NewGroupchatDetailsTab.page,
                    initial: true,
                    guards: [authGuard],
                    path: '',
                  ),
                  AutoRoute(
                    page: NewGroupchatSelectUserTab.page,
                    initial: false,
                    guards: [authGuard],
                    path: 'users',
                  ),
                  AutoRoute(
                    page: NewGroupchatPermissionsTab.page,
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
                page: NewPrivateEventRoute.page,
                guards: [authGuard],
                path: 'new-private-event',
                children: [
                  AutoRoute(
                    page: NewPrivateEventDetailsTab.page,
                    initial: true,
                    guards: [authGuard],
                    path: '',
                  ),
                  AutoRoute(
                    page: NewPrivateEventTypeTab.page,
                    guards: [authGuard],
                    path: 'type',
                  ),
                  AutoRoute(
                    page: NewPrivateEventSearchTab.page,
                    guards: [authGuard],
                    path: 'search',
                  ),
                  AutoRoute(
                    page: NewPrivateEventDateTab.page,
                    guards: [authGuard],
                    path: 'date',
                  ),
                  AutoRoute(
                    page: NewPrivateEventLocationTab.page,
                    guards: [authGuard],
                    path: 'location',
                  ),
                  AutoRoute(
                    page: NewPrivateEventPermissionsTab.page,
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
    ];
  }

  CustomRoute get _groupchatRouter => CustomRoute(
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        page: GroupchatRouteWrapper.page,
        guards: [authGuard],
        path: 'groupchat/:id',
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
        page: PrivateEventWrapperRoute.page,
        guards: [authGuard],
        path: 'private-event/:id',
        children: [
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventTabRoute.page,
            path: '',
            initial: true,
            guards: [authGuard],
            children: [
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventTabInfo.page,
                initial: true,
                path: 'info',
                guards: [authGuard],
              ),
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventTabChat.page,
                path: 'chat',
                guards: [authGuard],
              ),
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventTabUserList.page,
                path: 'users',
                guards: [authGuard],
              ),
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventTabShoppingList.page,
                path: 'shopping-list',
                guards: [authGuard],
              )
            ],
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventUpdateLocationRoute.page,
            path: 'update-location',
            guards: [authGuard],
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventUpdatePermissionsRoute.page,
            guards: [authGuard],
            path: 'update-permissions',
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventInviteUserRoute.page,
            path: 'invite',
            guards: [authGuard],
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventCreateShoppingListItemRoute.page,
            path: 'create-shopping-list-item',
            guards: [authGuard],
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: PrivateEventShoppingListItemWrapperRoute.page,
            guards: [authGuard],
            path: 'shopping-list/:shoppingListItemId',
            children: [
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventShoppingListItemRoute.page,
                guards: [authGuard],
                path: '',
              ),
              CustomRoute(
                transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
                page: PrivateEventShoppingListItemChangeUserRoute.page,
                guards: [authGuard],
                path: 'change-user-to-buy-item',
              ),
              RedirectRoute(path: '*', redirectTo: ''),
            ],
          ),
          RedirectRoute(path: '*', redirectTo: 'info'),
        ],
      );

  CustomRoute get _homePageRoute => CustomRoute(
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        page: HomeRoute.page,
        guards: [authGuard],
        path: '',
        children: [
          AutoRoute(
            page: HomeChatRoute.page,
            guards: [authGuard],
            path: 'chats',
            initial: true,
          ),
          AutoRoute(
              page: HomeEventRoute.page, guards: [authGuard], path: 'events'),
          AutoRoute(
              page: HomeSearchRoute.page, guards: [authGuard], path: 'search'),
          AutoRoute(
            page: HomeProfileRoute.page,
            guards: [authGuard],
            path: 'current-profile/:id',
            children: [
              AutoRoute(
                page: ProfileRoute.page,
                guards: [authGuard],
                path: '',
              ),
              //Doesnt need settings page because current user hasnt relation to change
              AutoRoute(
                page: ProfileUserRelationsTabRoute.page,
                guards: [authGuard],
                path: 'user-relations',
                fullscreenDialog: true,
                children: [
                  AutoRoute(
                    page: ProfileFollowerTab.page,
                    guards: [authGuard],
                    path: 'follower',
                  ),
                  AutoRoute(
                    page: ProfileFollowedTab.page,
                    guards: [authGuard],
                    path: 'followed',
                  ),
                  AutoRoute(
                    page: ProfileFollowRequestsTab.page,
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

  CustomRoute get _profileRouter => CustomRoute(
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        page: ProfileWrapperRoute.page,
        initial: false,
        guards: [authGuard],
        path: 'profile/:id',
        children: [
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: ProfileRoute.page,
            guards: [authGuard],
            path: '',
          ),
          CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: ProfileChatRoute.page,
            guards: [authGuard],
            path: 'chat',
          ),
          AutoRoute(
            page: ProfileUserRelationsTabRoute.page,
            guards: [authGuard],
            path: 'user-relations',
            children: [
              AutoRoute(
                page: ProfileFollowerTab.page,
                guards: [authGuard],
                path: 'follower',
              ),
              AutoRoute(
                page: ProfileFollowedTab.page,
                guards: [authGuard],
                path: 'followed',
              ),
              AutoRoute(
                page: ProfileFollowRequestsTab.page,
                guards: [authGuard],
                path: 'follow-requests',
              ),
            ],
          ),
          RedirectRoute(path: '*', redirectTo: '')
        ],
      );

  List<CustomRoute> get _settingsRoutes => [
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: SettingsRoute.page,
          guards: [authGuard],
          path: 'settings',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: ThemeModeRoute.page,
          guards: [authGuard],
          path: 'settings/theme',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: UpdatePasswordRoute.page,
          guards: [authGuard],
          path: 'settings/update-password',
        ),
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: SettingsInfoRoute.page,
            guards: [authGuard],
            path: 'settings/info'),
        CustomRoute(
            transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
            page: RightOnDeletionRoute.page,
            guards: [authGuard],
            path: 'settings/info/right-on-deletion'),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: ImprintRoute.page,
          guards: [authGuard],
          path: 'settings/info/imprint',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: SettingsPrivacyRoute.page,
          guards: [authGuard],
          path: 'settings/privacy',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: GroupchatAddMeRoute.page,
          guards: [authGuard],
          path: 'settings/privacy/groupchat-add-me-permission',
        ),
        CustomRoute(
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          page: PrivateEventAddMeRoute.page,
          guards: [authGuard],
          path: 'settings/privacy/private-event-add-me-permission',
        ),
      ];
}
