// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i42;
import 'package:flutter/material.dart' as _i43;

import '../../domain/entities/groupchat/groupchat_entity.dart' as _i47;
import '../../domain/entities/private_event/private_event_entity.dart' as _i48;
import '../../domain/entities/shopping_list_item/shopping_list_item_entity.dart'
    as _i46;
import '../../domain/entities/user/user_entity.dart' as _i45;
import '../screens/chat_page/chat_add_user_page.dart' as _i30;
import '../screens/chat_page/chat_info_page.dart' as _i29;
import '../screens/chat_page/chat_page.dart' as _i28;
import '../screens/chat_page/chat_page_wrapper.dart' as _i11;
import '../screens/create_user_page.dart' as _i5;
import '../screens/home_page/home_page.dart' as _i8;
import '../screens/home_page/pages/home_chat_page.dart' as _i23;
import '../screens/home_page/pages/home_event_page.dart' as _i24;
import '../screens/home_page/pages/home_map_page.dart' as _i25;
import '../screens/home_page/pages/home_profile_page.dart' as _i27;
import '../screens/home_page/pages/home_search_page.dart' as _i26;
import '../screens/login_page.dart' as _i1;
import '../screens/new_groupchat/new_groupchat_wrapper_page.dart' as _i13;
import '../screens/new_groupchat/pages/new_groupchat_details_tab.dart' as _i37;
import '../screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i38;
import '../screens/new_private_event/new_private_event_page.dart' as _i14;
import '../screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i39;
import '../screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i41;
import '../screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart'
    as _i40;
import '../screens/private_event_page/private_event_create_shopping_list_item_page.dart'
    as _i33;
import '../screens/private_event_page/private_event_invite_user_page.dart'
    as _i32;
import '../screens/private_event_page/private_event_wrapper_page.dart' as _i12;
import '../screens/private_event_page/tab_page/pages/private_event_tab_info.dart'
    as _i35;
import '../screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart'
    as _i36;
import '../screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i31;
import '../screens/profile_page/profile_page.dart' as _i15;
import '../screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart'
    as _i19;
import '../screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart'
    as _i18;
import '../screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart'
    as _i17;
import '../screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart'
    as _i16;
import '../screens/profile_page/profile_wrapper_page.dart' as _i6;
import '../screens/register_page.dart' as _i4;
import '../screens/reset_password_page.dart' as _i3;
import '../screens/settings_page/pages/settings_page.dart' as _i20;
import '../screens/settings_page/pages/theme_mode_page.dart' as _i21;
import '../screens/settings_page/pages/update_password_page.dart' as _i22;
import '../screens/settings_page/settings_page_wrapper.dart' as _i7;
import '../screens/shopping_list_item_page/shopping_list_item_page.dart'
    as _i10;
import '../screens/shopping_list_item_page/standard_shopping_list_item_page.dart'
    as _i34;
import '../screens/shopping_list_page/shopping_list_page.dart' as _i9;
import '../screens/verify_email_page.dart' as _i2;
import 'auth_guard.dart' as _i44;

class AppRouter extends _i42.RootStackRouter {
  AppRouter({
    _i43.GlobalKey<_i43.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i44.AuthGuard authGuard;

  @override
  final Map<String, _i42.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    VerifyEmailPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.VerifyEmailPage(),
      );
    },
    ResetPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordPageRouteArgs>(
          orElse: () => const ResetPasswordPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    CreateUserPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.CreateUserPage(),
      );
    },
    ProfileWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileWrapperPageRouteArgs>(
          orElse: () =>
              ProfileWrapperPageRouteArgs(userId: pathParams.getString('id')));
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ProfileWrapperPage(
          key: args.key,
          loadUserFromApiToo: args.loadUserFromApiToo,
          userToSet: args.userToSet,
          userId: args.userId,
        ),
      );
    },
    SettingsWrapperPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsWrapperPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    ShoppingListPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ShoppingListPage(),
      );
    },
    ShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ShoppingListItemPageRouteArgs>(
          orElse: () => ShoppingListItemPageRouteArgs(
              shoppingListItemId: pathParams.getString('shoppingListItemId')));
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ShoppingListItemPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemToSet: args.shoppingListItemToSet,
          loadShoppingListItemFromApiToo: args.loadShoppingListItemFromApiToo,
        ),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>(
          orElse: () => ChatPageWrapperRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.ChatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          chatToSet: args.chatToSet,
          loadChatFromApiToo: args.loadChatFromApiToo,
        ),
      );
    },
    PrivateEventWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventWrapperPageRouteArgs>(
          orElse: () => PrivateEventWrapperPageRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.PrivateEventWrapperPage(
          privateEventId: args.privateEventId,
          privateEventToSet: args.privateEventToSet,
          loadPrivateEventFromApiToo: args.loadPrivateEventFromApiToo,
          key: args.key,
        ),
      );
    },
    NewGroupchatWrapperPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.NewPrivateEventPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () => const ProfilePageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ProfilePage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
      );
    },
    ProfileUserRelationsTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileUserRelationsTabPageRouteArgs>(
          orElse: () => const ProfileUserRelationsTabPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.ProfileUserRelationsTabPage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
        fullscreenDialog: true,
      );
    },
    ProfileFollowerTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.ProfileFollowerTab(),
      );
    },
    ProfileFollowedTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.ProfileFollowedTab(),
      );
    },
    ProfileFollowRequestsTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileFollowRequestsTab(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.SettingsPage(),
      );
    },
    ThemeModePageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.ThemeModePage(),
      );
    },
    UpdatePasswordPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.UpdatePasswordPage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.HomeEventPage(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.Location(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.HomeProfilePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.ChatPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatInfoPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatInfoPageRouteArgs>(
          orElse: () => const ChatInfoPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i29.ChatInfoPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatAddUserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatAddUserPageRouteArgs>(
          orElse: () => const ChatAddUserPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i30.ChatAddUserPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabPageRouteArgs>(
          orElse: () => const PrivateEventTabPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i31.PrivateEventTabPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventInviteUserPageRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i32.PrivateEventInviteUserPage(),
      );
    },
    PrivateEventCreateShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCreateShoppingListItemPageRouteArgs>(
              orElse: () =>
                  const PrivateEventCreateShoppingListItemPageRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i33.PrivateEventCreateShoppingListItemPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    StandardShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StandardShoppingListItemPageRouteArgs>(
          orElse: () => StandardShoppingListItemPageRouteArgs(
              shoppingListItemId: pathParams.getString('shoppingListItemId')));
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i34.StandardShoppingListItemPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemToSet: args.shoppingListItemToSet,
          loadShoppingListItemFromApiToo: args.loadShoppingListItemFromApiToo,
          setCurrentPrivateEvent: args.setCurrentPrivateEvent,
        ),
      );
    },
    PrivateEventTabInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabInfoRouteArgs>(
          orElse: () => const PrivateEventTabInfoRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i35.PrivateEventTabInfo(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabShoppingListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabShoppingListRouteArgs>(
          orElse: () => const PrivateEventTabShoppingListRouteArgs());
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i36.PrivateEventTabShoppingList(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatDetailsTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i37.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatSelectUserTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i38.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventDetailsTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i39.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventSearchGroupchatTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i40.NewPrivateEventSearchGroupchatTab(),
      );
    },
    NewPrivateEventLocationTabRoute.name: (routeData) {
      return _i42.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i41.NewPrivateEventLocationTab(),
      );
    },
  };

  @override
  List<_i42.RouteConfig> get routes => [
        _i42.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i42.RouteConfig(
          VerifyEmailPageRoute.name,
          path: '/verify-email-page',
        ),
        _i42.RouteConfig(
          ResetPasswordPageRoute.name,
          path: '/reset-password-page',
        ),
        _i42.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i42.RouteConfig(
          CreateUserPageRoute.name,
          path: '/create-user-page',
          guards: [authGuard],
        ),
        _i42.RouteConfig(
          ProfileWrapperPageRoute.name,
          path: '/profile/:id',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              ProfilePageRoute.name,
              path: '',
              parent: ProfileWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              ProfileUserRelationsTabPageRoute.name,
              path: 'user-relations',
              parent: ProfileWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i42.RouteConfig(
                  ProfileFollowerTabRoute.name,
                  path: 'follower',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i42.RouteConfig(
                  ProfileFollowedTabRoute.name,
                  path: 'followed',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i42.RouteConfig(
                  ProfileFollowRequestsTabRoute.name,
                  path: 'follow-requests',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ProfileWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              SettingsPageRoute.name,
              path: '',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              ThemeModePageRoute.name,
              path: 'theme-mode',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              UpdatePasswordPageRoute.name,
              path: 'update-password',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SettingsWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
            _i42.RouteConfig(
              HomeChatPageRoute.name,
              path: 'chats',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              HomeEventPageRoute.name,
              path: 'events',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              LocationRoute.name,
              path: 'map',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              HomeSearchPageRoute.name,
              path: 'search',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              HomeProfilePageRoute.name,
              path: 'current-profile/:id',
              parent: HomePageRoute.name,
              guards: [authGuard],
              children: [
                _i42.RouteConfig(
                  ProfilePageRoute.name,
                  path: '',
                  parent: HomeProfilePageRoute.name,
                  guards: [authGuard],
                ),
                _i42.RouteConfig(
                  ProfileUserRelationsTabPageRoute.name,
                  path: 'user-relations',
                  parent: HomeProfilePageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i42.RouteConfig(
                      ProfileFollowerTabRoute.name,
                      path: 'follower',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i42.RouteConfig(
                      ProfileFollowedTabRoute.name,
                      path: 'followed',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i42.RouteConfig(
                      ProfileFollowRequestsTabRoute.name,
                      path: 'follow-requests',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                  ],
                ),
                _i42.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomeProfilePageRoute.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          ShoppingListPageRoute.name,
          path: '/shopping-list',
          guards: [authGuard],
        ),
        _i42.RouteConfig(
          ShoppingListItemPageRoute.name,
          path: '/shopping-list/:shoppingListItemId',
          guards: [authGuard],
        ),
        _i42.RouteConfig(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              ChatPageRoute.name,
              path: '',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              ChatInfoPageRoute.name,
              path: 'info',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              ChatAddUserPageRoute.name,
              path: 'add-user',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ChatPageWrapperRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          PrivateEventWrapperPageRoute.name,
          path: '/private-event/:id',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              '#redirect',
              path: '',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
            _i42.RouteConfig(
              PrivateEventTabPageRoute.name,
              path: 'info',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i42.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: PrivateEventTabPageRoute.name,
                  redirectTo: 'info',
                  fullMatch: true,
                ),
                _i42.RouteConfig(
                  PrivateEventTabInfoRoute.name,
                  path: 'info',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i42.RouteConfig(
                  PrivateEventTabShoppingListRoute.name,
                  path: 'shopping-list',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i42.RouteConfig(
              PrivateEventInviteUserPageRoute.name,
              path: 'invite',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              PrivateEventCreateShoppingListItemPageRoute.name,
              path: 'create-shopping-list-item',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              StandardShoppingListItemPageRoute.name,
              path: 'shopping-list/:shoppingListItemId',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              NewGroupchatDetailsTabRoute.name,
              path: '',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              NewGroupchatSelectUserTabRoute.name,
              path: 'users',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewGroupchatWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          guards: [authGuard],
          children: [
            _i42.RouteConfig(
              NewPrivateEventDetailsTabRoute.name,
              path: '',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              NewPrivateEventSearchGroupchatTabRoute.name,
              path: 'groupchat',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              NewPrivateEventLocationTabRoute.name,
              path: 'location',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i42.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewPrivateEventPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i42.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i42.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.VerifyEmailPage]
class VerifyEmailPageRoute extends _i42.PageRouteInfo<void> {
  const VerifyEmailPageRoute()
      : super(
          VerifyEmailPageRoute.name,
          path: '/verify-email-page',
        );

  static const String name = 'VerifyEmailPageRoute';
}

/// generated route for
/// [_i3.ResetPasswordPage]
class ResetPasswordPageRoute
    extends _i42.PageRouteInfo<ResetPasswordPageRouteArgs> {
  ResetPasswordPageRoute({
    _i43.Key? key,
    String? standardEmail,
  }) : super(
          ResetPasswordPageRoute.name,
          path: '/reset-password-page',
          args: ResetPasswordPageRouteArgs(
            key: key,
            standardEmail: standardEmail,
          ),
        );

  static const String name = 'ResetPasswordPageRoute';
}

class ResetPasswordPageRouteArgs {
  const ResetPasswordPageRouteArgs({
    this.key,
    this.standardEmail,
  });

  final _i43.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordPageRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterPageRoute extends _i42.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i5.CreateUserPage]
class CreateUserPageRoute extends _i42.PageRouteInfo<void> {
  const CreateUserPageRoute()
      : super(
          CreateUserPageRoute.name,
          path: '/create-user-page',
        );

  static const String name = 'CreateUserPageRoute';
}

/// generated route for
/// [_i6.ProfileWrapperPage]
class ProfileWrapperPageRoute
    extends _i42.PageRouteInfo<ProfileWrapperPageRouteArgs> {
  ProfileWrapperPageRoute({
    _i43.Key? key,
    bool loadUserFromApiToo = true,
    _i45.UserEntity? userToSet,
    required String userId,
    List<_i42.PageRouteInfo>? children,
  }) : super(
          ProfileWrapperPageRoute.name,
          path: '/profile/:id',
          args: ProfileWrapperPageRouteArgs(
            key: key,
            loadUserFromApiToo: loadUserFromApiToo,
            userToSet: userToSet,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileWrapperPageRoute';
}

class ProfileWrapperPageRouteArgs {
  const ProfileWrapperPageRouteArgs({
    this.key,
    this.loadUserFromApiToo = true,
    this.userToSet,
    required this.userId,
  });

  final _i43.Key? key;

  final bool loadUserFromApiToo;

  final _i45.UserEntity? userToSet;

  final String userId;

  @override
  String toString() {
    return 'ProfileWrapperPageRouteArgs{key: $key, loadUserFromApiToo: $loadUserFromApiToo, userToSet: $userToSet, userId: $userId}';
  }
}

/// generated route for
/// [_i7.SettingsWrapperPage]
class SettingsWrapperPageRoute extends _i42.PageRouteInfo<void> {
  const SettingsWrapperPageRoute({List<_i42.PageRouteInfo>? children})
      : super(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          initialChildren: children,
        );

  static const String name = 'SettingsWrapperPageRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomePageRoute extends _i42.PageRouteInfo<void> {
  const HomePageRoute({List<_i42.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i9.ShoppingListPage]
class ShoppingListPageRoute extends _i42.PageRouteInfo<void> {
  const ShoppingListPageRoute()
      : super(
          ShoppingListPageRoute.name,
          path: '/shopping-list',
        );

  static const String name = 'ShoppingListPageRoute';
}

/// generated route for
/// [_i10.ShoppingListItemPage]
class ShoppingListItemPageRoute
    extends _i42.PageRouteInfo<ShoppingListItemPageRouteArgs> {
  ShoppingListItemPageRoute({
    _i43.Key? key,
    required String shoppingListItemId,
    _i46.ShoppingListItemEntity? shoppingListItemToSet,
    bool loadShoppingListItemFromApiToo = true,
  }) : super(
          ShoppingListItemPageRoute.name,
          path: '/shopping-list/:shoppingListItemId',
          args: ShoppingListItemPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemToSet: shoppingListItemToSet,
            loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
        );

  static const String name = 'ShoppingListItemPageRoute';
}

class ShoppingListItemPageRouteArgs {
  const ShoppingListItemPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
  });

  final _i43.Key? key;

  final String shoppingListItemId;

  final _i46.ShoppingListItemEntity? shoppingListItemToSet;

  final bool loadShoppingListItemFromApiToo;

  @override
  String toString() {
    return 'ShoppingListItemPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemToSet: $shoppingListItemToSet, loadShoppingListItemFromApiToo: $loadShoppingListItemFromApiToo}';
  }
}

/// generated route for
/// [_i11.ChatPageWrapper]
class ChatPageWrapperRoute
    extends _i42.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i43.Key? key,
    required String groupchatId,
    _i47.GroupchatEntity? chatToSet,
    bool loadChatFromApiToo = true,
    List<_i42.PageRouteInfo>? children,
  }) : super(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          args: ChatPageWrapperRouteArgs(
            key: key,
            groupchatId: groupchatId,
            chatToSet: chatToSet,
            loadChatFromApiToo: loadChatFromApiToo,
          ),
          rawPathParams: {'id': groupchatId},
          initialChildren: children,
        );

  static const String name = 'ChatPageWrapperRoute';
}

class ChatPageWrapperRouteArgs {
  const ChatPageWrapperRouteArgs({
    this.key,
    required this.groupchatId,
    this.chatToSet,
    this.loadChatFromApiToo = true,
  });

  final _i43.Key? key;

  final String groupchatId;

  final _i47.GroupchatEntity? chatToSet;

  final bool loadChatFromApiToo;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, chatToSet: $chatToSet, loadChatFromApiToo: $loadChatFromApiToo}';
  }
}

/// generated route for
/// [_i12.PrivateEventWrapperPage]
class PrivateEventWrapperPageRoute
    extends _i42.PageRouteInfo<PrivateEventWrapperPageRouteArgs> {
  PrivateEventWrapperPageRoute({
    required String privateEventId,
    _i48.PrivateEventEntity? privateEventToSet,
    bool loadPrivateEventFromApiToo = true,
    _i43.Key? key,
    List<_i42.PageRouteInfo>? children,
  }) : super(
          PrivateEventWrapperPageRoute.name,
          path: '/private-event/:id',
          args: PrivateEventWrapperPageRouteArgs(
            privateEventId: privateEventId,
            privateEventToSet: privateEventToSet,
            loadPrivateEventFromApiToo: loadPrivateEventFromApiToo,
            key: key,
          ),
          rawPathParams: {'id': privateEventId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventWrapperPageRoute';
}

class PrivateEventWrapperPageRouteArgs {
  const PrivateEventWrapperPageRouteArgs({
    required this.privateEventId,
    this.privateEventToSet,
    this.loadPrivateEventFromApiToo = true,
    this.key,
  });

  final String privateEventId;

  final _i48.PrivateEventEntity? privateEventToSet;

  final bool loadPrivateEventFromApiToo;

  final _i43.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperPageRouteArgs{privateEventId: $privateEventId, privateEventToSet: $privateEventToSet, loadPrivateEventFromApiToo: $loadPrivateEventFromApiToo, key: $key}';
  }
}

/// generated route for
/// [_i13.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i42.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i42.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i14.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i42.PageRouteInfo<void> {
  const NewPrivateEventPageRoute({List<_i42.PageRouteInfo>? children})
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i15.ProfilePage]
class ProfilePageRoute extends _i42.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i43.Key? key})
      : super(
          ProfilePageRoute.name,
          path: '',
          args: ProfilePageRouteArgs(key: key),
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.ProfileUserRelationsTabPage]
class ProfileUserRelationsTabPageRoute
    extends _i42.PageRouteInfo<ProfileUserRelationsTabPageRouteArgs> {
  ProfileUserRelationsTabPageRoute({
    _i43.Key? key,
    List<_i42.PageRouteInfo>? children,
  }) : super(
          ProfileUserRelationsTabPageRoute.name,
          path: 'user-relations',
          args: ProfileUserRelationsTabPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileUserRelationsTabPageRoute';
}

class ProfileUserRelationsTabPageRouteArgs {
  const ProfileUserRelationsTabPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ProfileUserRelationsTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.ProfileFollowerTab]
class ProfileFollowerTabRoute extends _i42.PageRouteInfo<void> {
  const ProfileFollowerTabRoute()
      : super(
          ProfileFollowerTabRoute.name,
          path: 'follower',
        );

  static const String name = 'ProfileFollowerTabRoute';
}

/// generated route for
/// [_i18.ProfileFollowedTab]
class ProfileFollowedTabRoute extends _i42.PageRouteInfo<void> {
  const ProfileFollowedTabRoute()
      : super(
          ProfileFollowedTabRoute.name,
          path: 'followed',
        );

  static const String name = 'ProfileFollowedTabRoute';
}

/// generated route for
/// [_i19.ProfileFollowRequestsTab]
class ProfileFollowRequestsTabRoute extends _i42.PageRouteInfo<void> {
  const ProfileFollowRequestsTabRoute()
      : super(
          ProfileFollowRequestsTabRoute.name,
          path: 'follow-requests',
        );

  static const String name = 'ProfileFollowRequestsTabRoute';
}

/// generated route for
/// [_i20.SettingsPage]
class SettingsPageRoute extends _i42.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i21.ThemeModePage]
class ThemeModePageRoute extends _i42.PageRouteInfo<void> {
  const ThemeModePageRoute()
      : super(
          ThemeModePageRoute.name,
          path: 'theme-mode',
        );

  static const String name = 'ThemeModePageRoute';
}

/// generated route for
/// [_i22.UpdatePasswordPage]
class UpdatePasswordPageRoute extends _i42.PageRouteInfo<void> {
  const UpdatePasswordPageRoute()
      : super(
          UpdatePasswordPageRoute.name,
          path: 'update-password',
        );

  static const String name = 'UpdatePasswordPageRoute';
}

/// generated route for
/// [_i23.HomeChatPage]
class HomeChatPageRoute extends _i42.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i24.HomeEventPage]
class HomeEventPageRoute extends _i42.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i25.Location]
class LocationRoute extends _i42.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: 'map',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i26.HomeSearchPage]
class HomeSearchPageRoute extends _i42.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i27.HomeProfilePage]
class HomeProfilePageRoute extends _i42.PageRouteInfo<void> {
  const HomeProfilePageRoute({List<_i42.PageRouteInfo>? children})
      : super(
          HomeProfilePageRoute.name,
          path: 'current-profile/:id',
          initialChildren: children,
        );

  static const String name = 'HomeProfilePageRoute';
}

/// generated route for
/// [_i28.ChatPage]
class ChatPageRoute extends _i42.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i43.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i29.ChatInfoPage]
class ChatInfoPageRoute extends _i42.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i43.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i30.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i42.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i43.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i31.PrivateEventTabPage]
class PrivateEventTabPageRoute
    extends _i42.PageRouteInfo<PrivateEventTabPageRouteArgs> {
  PrivateEventTabPageRoute({
    _i43.Key? key,
    List<_i42.PageRouteInfo>? children,
  }) : super(
          PrivateEventTabPageRoute.name,
          path: 'info',
          args: PrivateEventTabPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabPageRoute';
}

class PrivateEventTabPageRouteArgs {
  const PrivateEventTabPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i32.PrivateEventInviteUserPage]
class PrivateEventInviteUserPageRoute extends _i42.PageRouteInfo<void> {
  const PrivateEventInviteUserPageRoute()
      : super(
          PrivateEventInviteUserPageRoute.name,
          path: 'invite',
        );

  static const String name = 'PrivateEventInviteUserPageRoute';
}

/// generated route for
/// [_i33.PrivateEventCreateShoppingListItemPage]
class PrivateEventCreateShoppingListItemPageRoute extends _i42
    .PageRouteInfo<PrivateEventCreateShoppingListItemPageRouteArgs> {
  PrivateEventCreateShoppingListItemPageRoute({_i43.Key? key})
      : super(
          PrivateEventCreateShoppingListItemPageRoute.name,
          path: 'create-shopping-list-item',
          args: PrivateEventCreateShoppingListItemPageRouteArgs(key: key),
        );

  static const String name = 'PrivateEventCreateShoppingListItemPageRoute';
}

class PrivateEventCreateShoppingListItemPageRouteArgs {
  const PrivateEventCreateShoppingListItemPageRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'PrivateEventCreateShoppingListItemPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i34.StandardShoppingListItemPage]
class StandardShoppingListItemPageRoute
    extends _i42.PageRouteInfo<StandardShoppingListItemPageRouteArgs> {
  StandardShoppingListItemPageRoute({
    _i43.Key? key,
    required String shoppingListItemId,
    _i46.ShoppingListItemEntity? shoppingListItemToSet,
    bool loadShoppingListItemFromApiToo = true,
    bool setCurrentPrivateEvent = false,
  }) : super(
          StandardShoppingListItemPageRoute.name,
          path: 'shopping-list/:shoppingListItemId',
          args: StandardShoppingListItemPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemToSet: shoppingListItemToSet,
            loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
            setCurrentPrivateEvent: setCurrentPrivateEvent,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
        );

  static const String name = 'StandardShoppingListItemPageRoute';
}

class StandardShoppingListItemPageRouteArgs {
  const StandardShoppingListItemPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
    this.setCurrentPrivateEvent = false,
  });

  final _i43.Key? key;

  final String shoppingListItemId;

  final _i46.ShoppingListItemEntity? shoppingListItemToSet;

  final bool loadShoppingListItemFromApiToo;

  final bool setCurrentPrivateEvent;

  @override
  String toString() {
    return 'StandardShoppingListItemPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemToSet: $shoppingListItemToSet, loadShoppingListItemFromApiToo: $loadShoppingListItemFromApiToo, setCurrentPrivateEvent: $setCurrentPrivateEvent}';
  }
}

/// generated route for
/// [_i35.PrivateEventTabInfo]
class PrivateEventTabInfoRoute
    extends _i42.PageRouteInfo<PrivateEventTabInfoRouteArgs> {
  PrivateEventTabInfoRoute({_i43.Key? key})
      : super(
          PrivateEventTabInfoRoute.name,
          path: 'info',
          args: PrivateEventTabInfoRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabInfoRoute';
}

class PrivateEventTabInfoRouteArgs {
  const PrivateEventTabInfoRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i36.PrivateEventTabShoppingList]
class PrivateEventTabShoppingListRoute
    extends _i42.PageRouteInfo<PrivateEventTabShoppingListRouteArgs> {
  PrivateEventTabShoppingListRoute({_i43.Key? key})
      : super(
          PrivateEventTabShoppingListRoute.name,
          path: 'shopping-list',
          args: PrivateEventTabShoppingListRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabShoppingListRoute';
}

class PrivateEventTabShoppingListRouteArgs {
  const PrivateEventTabShoppingListRouteArgs({this.key});

  final _i43.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabShoppingListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i37.NewGroupchatDetailsTab]
class NewGroupchatDetailsTabRoute extends _i42.PageRouteInfo<void> {
  const NewGroupchatDetailsTabRoute()
      : super(
          NewGroupchatDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatDetailsTabRoute';
}

/// generated route for
/// [_i38.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTabRoute extends _i42.PageRouteInfo<void> {
  const NewGroupchatSelectUserTabRoute()
      : super(
          NewGroupchatSelectUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewGroupchatSelectUserTabRoute';
}

/// generated route for
/// [_i39.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTabRoute extends _i42.PageRouteInfo<void> {
  const NewPrivateEventDetailsTabRoute()
      : super(
          NewPrivateEventDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventDetailsTabRoute';
}

/// generated route for
/// [_i40.NewPrivateEventSearchGroupchatTab]
class NewPrivateEventSearchGroupchatTabRoute extends _i42.PageRouteInfo<void> {
  const NewPrivateEventSearchGroupchatTabRoute()
      : super(
          NewPrivateEventSearchGroupchatTabRoute.name,
          path: 'groupchat',
        );

  static const String name = 'NewPrivateEventSearchGroupchatTabRoute';
}

/// generated route for
/// [_i41.NewPrivateEventLocationTab]
class NewPrivateEventLocationTabRoute extends _i42.PageRouteInfo<void> {
  const NewPrivateEventLocationTabRoute()
      : super(
          NewPrivateEventLocationTabRoute.name,
          path: 'location',
        );

  static const String name = 'NewPrivateEventLocationTabRoute';
}
