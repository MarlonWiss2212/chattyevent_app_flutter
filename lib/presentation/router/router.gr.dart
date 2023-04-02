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
import 'package:auto_route/auto_route.dart' as _i49;
import 'package:flutter/material.dart' as _i50;

import '../../application/bloc/chat/current_chat_cubit.dart' as _i53;
import '../../application/bloc/shopping_list/current_shopping_list_item_cubit.dart'
    as _i55;
import '../../domain/entities/private_event/private_event_entity.dart' as _i54;
import '../../domain/entities/user/user_entity.dart' as _i52;
import '../screens/chat_page/chat_add_user_page.dart' as _i33;
import '../screens/chat_page/chat_change_chat_username_page.dart' as _i31;
import '../screens/chat_page/chat_future_private_events_page.dart' as _i32;
import '../screens/chat_page/chat_info_page.dart' as _i30;
import '../screens/chat_page/chat_page.dart' as _i29;
import '../screens/chat_page/chat_page_wrapper.dart' as _i10;
import '../screens/create_user_page.dart' as _i5;
import '../screens/home_page/home_page.dart' as _i8;
import '../screens/home_page/pages/home_chat_page.dart' as _i22;
import '../screens/home_page/pages/home_event_page.dart' as _i23;
import '../screens/home_page/pages/home_map_page.dart' as _i24;
import '../screens/home_page/pages/home_profile_page.dart' as _i26;
import '../screens/home_page/pages/home_search_page.dart' as _i25;
import '../screens/login_page.dart' as _i1;
import '../screens/new_groupchat/new_groupchat_wrapper_page.dart' as _i12;
import '../screens/new_groupchat/pages/new_groupchat_details_tab.dart' as _i41;
import '../screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i42;
import '../screens/new_private_event/new_private_event_page.dart' as _i13;
import '../screens/new_private_event/pages/new_private_event_date_tab.dart'
    as _i47;
import '../screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i43;
import '../screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i48;
import '../screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart'
    as _i46;
import '../screens/new_private_event/pages/new_private_event_search_user_tab.dart'
    as _i45;
import '../screens/new_private_event/pages/new_private_event_type_tab.dart'
    as _i44;
import '../screens/private_event_page/private_event_create_shopping_list_item_page.dart'
    as _i36;
import '../screens/private_event_page/private_event_invite_user_page.dart'
    as _i35;
import '../screens/private_event_page/private_event_shopping_list_item_page.dart'
    as _i37;
import '../screens/private_event_page/private_event_wrapper_page.dart' as _i11;
import '../screens/private_event_page/tab_page/pages/private_event_tab_info.dart'
    as _i38;
import '../screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart'
    as _i40;
import '../screens/private_event_page/tab_page/pages/private_event_tab_user_list.dart'
    as _i39;
import '../screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i34;
import '../screens/profile_page/profile_page.dart' as _i14;
import '../screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart'
    as _i18;
import '../screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart'
    as _i17;
import '../screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart'
    as _i16;
import '../screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart'
    as _i15;
import '../screens/profile_page/profile_wrapper_page.dart' as _i6;
import '../screens/register_page.dart' as _i4;
import '../screens/reset_password_page.dart' as _i3;
import '../screens/settings_page/pages/settings_page.dart' as _i19;
import '../screens/settings_page/pages/theme_mode_page.dart' as _i20;
import '../screens/settings_page/pages/update_password_page.dart' as _i21;
import '../screens/settings_page/settings_page_wrapper.dart' as _i7;
import '../screens/shopping_list_page/shopping_list_item_page.dart' as _i28;
import '../screens/shopping_list_page/shopping_list_page.dart' as _i27;
import '../screens/shopping_list_page/shopping_list_wrapper_page.dart' as _i9;
import '../screens/verify_email_page.dart' as _i2;
import 'auth_guard.dart' as _i51;

class AppRouter extends _i49.RootStackRouter {
  AppRouter({
    _i50.GlobalKey<_i50.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i51.AuthGuard authGuard;

  @override
  final Map<String, _i49.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    VerifyEmailPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.VerifyEmailPage(),
      );
    },
    ResetPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordPageRouteArgs>(
          orElse: () => const ResetPasswordPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.RegisterPage(),
      );
    },
    CreateUserPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.CreateUserPage(),
      );
    },
    ProfileWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileWrapperPageRouteArgs>(
          orElse: () =>
              ProfileWrapperPageRouteArgs(userId: pathParams.getString('id')));
      return _i49.MaterialPageX<dynamic>(
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
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsWrapperPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    ShoppingListWrapperPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ShoppingListWrapperPage(),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>();
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ChatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          chatStateToSet: args.chatStateToSet,
          loadChatFromApiToo: args.loadChatFromApiToo,
        ),
      );
    },
    PrivateEventWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventWrapperPageRouteArgs>(
          orElse: () => PrivateEventWrapperPageRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.PrivateEventWrapperPage(
          privateEventId: args.privateEventId,
          privateEventToSet: args.privateEventToSet,
          loadPrivateEventFromApiToo: args.loadPrivateEventFromApiToo,
          key: args.key,
        ),
      );
    },
    NewGroupchatWrapperPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.NewPrivateEventPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () => const ProfilePageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.ProfilePage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
      );
    },
    ProfileUserRelationsTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileUserRelationsTabPageRouteArgs>(
          orElse: () => const ProfileUserRelationsTabPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ProfileUserRelationsTabPage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
        fullscreenDialog: true,
      );
    },
    ProfileFollowerTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.ProfileFollowerTab(),
      );
    },
    ProfileFollowedTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.ProfileFollowedTab(),
      );
    },
    ProfileFollowRequestsTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.ProfileFollowRequestsTab(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.SettingsPage(),
      );
    },
    ThemeModePageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.ThemeModePage(),
      );
    },
    UpdatePasswordPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.UpdatePasswordPage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i22.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i23.HomeEventPage(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.Location(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.HomeProfilePage(),
      );
    },
    ShoppingListPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.ShoppingListPage(),
      );
    },
    ShoppingListItemPageRoute.name: (routeData) {
      final args = routeData.argsAs<ShoppingListItemPageRouteArgs>();
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i28.ShoppingListItemPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          currentShoppingListItemStateToSet:
              args.currentShoppingListItemStateToSet,
        ),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i29.ChatPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatInfoPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatInfoPageRouteArgs>(
          orElse: () => const ChatInfoPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i30.ChatInfoPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatChangeChatUsernamePageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i31.ChatChangeChatUsernamePage(),
        fullscreenDialog: true,
      );
    },
    ChatFuturePrivateEventsPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i32.ChatFuturePrivateEventsPage(),
      );
    },
    ChatAddUserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatAddUserPageRouteArgs>(
          orElse: () => const ChatAddUserPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i33.ChatAddUserPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabPageRouteArgs>(
          orElse: () => const PrivateEventTabPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i34.PrivateEventTabPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventInviteUserPageRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i35.PrivateEventInviteUserPage(),
      );
    },
    PrivateEventCreateShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCreateShoppingListItemPageRouteArgs>(
              orElse: () =>
                  const PrivateEventCreateShoppingListItemPageRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i36.PrivateEventCreateShoppingListItemPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventShoppingListItemPageRoute.name: (routeData) {
      final args =
          routeData.argsAs<PrivateEventShoppingListItemPageRouteArgs>();
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i37.PrivateEventShoppingListItemPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemStateToSet: args.shoppingListItemStateToSet,
          loadShoppingListItemFromApiToo: args.loadShoppingListItemFromApiToo,
          setCurrentPrivateEvent: args.setCurrentPrivateEvent,
        ),
      );
    },
    PrivateEventTabInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabInfoRouteArgs>(
          orElse: () => const PrivateEventTabInfoRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i38.PrivateEventTabInfo(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabUserListRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i39.PrivateEventTabUserList(),
      );
    },
    PrivateEventTabShoppingListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabShoppingListRouteArgs>(
          orElse: () => const PrivateEventTabShoppingListRouteArgs());
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i40.PrivateEventTabShoppingList(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatDetailsTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i41.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatSelectUserTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i42.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventDetailsTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i43.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventTypeTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i44.NewPrivateEventTypeTab(),
      );
    },
    NewPrivateEventSearchUserTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i45.NewPrivateEventSearchUserTab(),
      );
    },
    NewPrivateEventSearchGroupchatTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i46.NewPrivateEventSearchGroupchatTab(),
      );
    },
    NewPrivateEventDateTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i47.NewPrivateEventDateTab(),
      );
    },
    NewPrivateEventLocationTabRoute.name: (routeData) {
      return _i49.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i48.NewPrivateEventLocationTab(),
      );
    },
  };

  @override
  List<_i49.RouteConfig> get routes => [
        _i49.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i49.RouteConfig(
          VerifyEmailPageRoute.name,
          path: '/verify-email-page',
        ),
        _i49.RouteConfig(
          ResetPasswordPageRoute.name,
          path: '/reset-password-page',
        ),
        _i49.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i49.RouteConfig(
          CreateUserPageRoute.name,
          path: '/create-user-page',
          guards: [authGuard],
        ),
        _i49.RouteConfig(
          ProfileWrapperPageRoute.name,
          path: '/profile/:id',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              ProfilePageRoute.name,
              path: '',
              parent: ProfileWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ProfileUserRelationsTabPageRoute.name,
              path: 'user-relations',
              parent: ProfileWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i49.RouteConfig(
                  ProfileFollowerTabRoute.name,
                  path: 'follower',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i49.RouteConfig(
                  ProfileFollowedTabRoute.name,
                  path: 'followed',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i49.RouteConfig(
                  ProfileFollowRequestsTabRoute.name,
                  path: 'follow-requests',
                  parent: ProfileUserRelationsTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ProfileWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              SettingsPageRoute.name,
              path: '',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ThemeModePageRoute.name,
              path: 'theme-mode',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              UpdatePasswordPageRoute.name,
              path: 'update-password',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SettingsWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
            _i49.RouteConfig(
              HomeChatPageRoute.name,
              path: 'chats',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              HomeEventPageRoute.name,
              path: 'events',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              LocationRoute.name,
              path: 'map',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              HomeSearchPageRoute.name,
              path: 'search',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              HomeProfilePageRoute.name,
              path: 'current-profile/:id',
              parent: HomePageRoute.name,
              guards: [authGuard],
              children: [
                _i49.RouteConfig(
                  ProfilePageRoute.name,
                  path: '',
                  parent: HomeProfilePageRoute.name,
                  guards: [authGuard],
                ),
                _i49.RouteConfig(
                  ProfileUserRelationsTabPageRoute.name,
                  path: 'user-relations',
                  parent: HomeProfilePageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i49.RouteConfig(
                      ProfileFollowerTabRoute.name,
                      path: 'follower',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i49.RouteConfig(
                      ProfileFollowedTabRoute.name,
                      path: 'followed',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i49.RouteConfig(
                      ProfileFollowRequestsTabRoute.name,
                      path: 'follow-requests',
                      parent: ProfileUserRelationsTabPageRoute.name,
                      guards: [authGuard],
                    ),
                  ],
                ),
                _i49.RouteConfig(
                  '*#redirect',
                  path: '*',
                  parent: HomeProfilePageRoute.name,
                  redirectTo: '',
                  fullMatch: true,
                ),
              ],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          ShoppingListWrapperPageRoute.name,
          path: '/shopping-list',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              ShoppingListPageRoute.name,
              path: '',
              parent: ShoppingListWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ShoppingListItemPageRoute.name,
              path: ':shoppingListItemId',
              parent: ShoppingListWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ShoppingListWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              ChatPageRoute.name,
              path: '',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ChatInfoPageRoute.name,
              path: 'info',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ChatChangeChatUsernamePageRoute.name,
              path: 'change-chat-username',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ChatFuturePrivateEventsPageRoute.name,
              path: 'private-events',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              ChatAddUserPageRoute.name,
              path: 'add-user',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ChatPageWrapperRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          PrivateEventWrapperPageRoute.name,
          path: '/private-event/:id',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              '#redirect',
              path: '',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
            _i49.RouteConfig(
              PrivateEventTabPageRoute.name,
              path: 'info',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i49.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: PrivateEventTabPageRoute.name,
                  redirectTo: 'info',
                  fullMatch: true,
                ),
                _i49.RouteConfig(
                  PrivateEventTabInfoRoute.name,
                  path: 'info',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i49.RouteConfig(
                  PrivateEventTabUserListRoute.name,
                  path: 'users',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i49.RouteConfig(
                  PrivateEventTabShoppingListRoute.name,
                  path: 'shopping-list',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i49.RouteConfig(
              PrivateEventInviteUserPageRoute.name,
              path: 'invite',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              PrivateEventCreateShoppingListItemPageRoute.name,
              path: 'create-shopping-list-item',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              PrivateEventShoppingListItemPageRoute.name,
              path: 'shopping-list/:shoppingListItemId',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              NewGroupchatDetailsTabRoute.name,
              path: '',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewGroupchatSelectUserTabRoute.name,
              path: 'users',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewGroupchatWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          guards: [authGuard],
          children: [
            _i49.RouteConfig(
              NewPrivateEventDetailsTabRoute.name,
              path: '',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewPrivateEventTypeTabRoute.name,
              path: 'type',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewPrivateEventSearchUserTabRoute.name,
              path: 'users',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewPrivateEventSearchGroupchatTabRoute.name,
              path: 'groupchat',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewPrivateEventDateTabRoute.name,
              path: 'date',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              NewPrivateEventLocationTabRoute.name,
              path: 'location',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i49.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewPrivateEventPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i49.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i49.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.VerifyEmailPage]
class VerifyEmailPageRoute extends _i49.PageRouteInfo<void> {
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
    extends _i49.PageRouteInfo<ResetPasswordPageRouteArgs> {
  ResetPasswordPageRoute({
    _i50.Key? key,
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

  final _i50.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordPageRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterPageRoute extends _i49.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i5.CreateUserPage]
class CreateUserPageRoute extends _i49.PageRouteInfo<void> {
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
    extends _i49.PageRouteInfo<ProfileWrapperPageRouteArgs> {
  ProfileWrapperPageRoute({
    _i50.Key? key,
    bool loadUserFromApiToo = true,
    _i52.UserEntity? userToSet,
    required String userId,
    List<_i49.PageRouteInfo>? children,
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

  final _i50.Key? key;

  final bool loadUserFromApiToo;

  final _i52.UserEntity? userToSet;

  final String userId;

  @override
  String toString() {
    return 'ProfileWrapperPageRouteArgs{key: $key, loadUserFromApiToo: $loadUserFromApiToo, userToSet: $userToSet, userId: $userId}';
  }
}

/// generated route for
/// [_i7.SettingsWrapperPage]
class SettingsWrapperPageRoute extends _i49.PageRouteInfo<void> {
  const SettingsWrapperPageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          initialChildren: children,
        );

  static const String name = 'SettingsWrapperPageRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomePageRoute extends _i49.PageRouteInfo<void> {
  const HomePageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i9.ShoppingListWrapperPage]
class ShoppingListWrapperPageRoute extends _i49.PageRouteInfo<void> {
  const ShoppingListWrapperPageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          ShoppingListWrapperPageRoute.name,
          path: '/shopping-list',
          initialChildren: children,
        );

  static const String name = 'ShoppingListWrapperPageRoute';
}

/// generated route for
/// [_i10.ChatPageWrapper]
class ChatPageWrapperRoute
    extends _i49.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i50.Key? key,
    required String groupchatId,
    required _i53.CurrentChatState chatStateToSet,
    bool loadChatFromApiToo = true,
    List<_i49.PageRouteInfo>? children,
  }) : super(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          args: ChatPageWrapperRouteArgs(
            key: key,
            groupchatId: groupchatId,
            chatStateToSet: chatStateToSet,
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
    required this.chatStateToSet,
    this.loadChatFromApiToo = true,
  });

  final _i50.Key? key;

  final String groupchatId;

  final _i53.CurrentChatState chatStateToSet;

  final bool loadChatFromApiToo;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, chatStateToSet: $chatStateToSet, loadChatFromApiToo: $loadChatFromApiToo}';
  }
}

/// generated route for
/// [_i11.PrivateEventWrapperPage]
class PrivateEventWrapperPageRoute
    extends _i49.PageRouteInfo<PrivateEventWrapperPageRouteArgs> {
  PrivateEventWrapperPageRoute({
    required String privateEventId,
    _i54.PrivateEventEntity? privateEventToSet,
    bool loadPrivateEventFromApiToo = true,
    _i50.Key? key,
    List<_i49.PageRouteInfo>? children,
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

  final _i54.PrivateEventEntity? privateEventToSet;

  final bool loadPrivateEventFromApiToo;

  final _i50.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperPageRouteArgs{privateEventId: $privateEventId, privateEventToSet: $privateEventToSet, loadPrivateEventFromApiToo: $loadPrivateEventFromApiToo, key: $key}';
  }
}

/// generated route for
/// [_i12.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i49.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i13.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventPageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i14.ProfilePage]
class ProfilePageRoute extends _i49.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i50.Key? key})
      : super(
          ProfilePageRoute.name,
          path: '',
          args: ProfilePageRouteArgs(key: key),
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.ProfileUserRelationsTabPage]
class ProfileUserRelationsTabPageRoute
    extends _i49.PageRouteInfo<ProfileUserRelationsTabPageRouteArgs> {
  ProfileUserRelationsTabPageRoute({
    _i50.Key? key,
    List<_i49.PageRouteInfo>? children,
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

  final _i50.Key? key;

  @override
  String toString() {
    return 'ProfileUserRelationsTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.ProfileFollowerTab]
class ProfileFollowerTabRoute extends _i49.PageRouteInfo<void> {
  const ProfileFollowerTabRoute()
      : super(
          ProfileFollowerTabRoute.name,
          path: 'follower',
        );

  static const String name = 'ProfileFollowerTabRoute';
}

/// generated route for
/// [_i17.ProfileFollowedTab]
class ProfileFollowedTabRoute extends _i49.PageRouteInfo<void> {
  const ProfileFollowedTabRoute()
      : super(
          ProfileFollowedTabRoute.name,
          path: 'followed',
        );

  static const String name = 'ProfileFollowedTabRoute';
}

/// generated route for
/// [_i18.ProfileFollowRequestsTab]
class ProfileFollowRequestsTabRoute extends _i49.PageRouteInfo<void> {
  const ProfileFollowRequestsTabRoute()
      : super(
          ProfileFollowRequestsTabRoute.name,
          path: 'follow-requests',
        );

  static const String name = 'ProfileFollowRequestsTabRoute';
}

/// generated route for
/// [_i19.SettingsPage]
class SettingsPageRoute extends _i49.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i20.ThemeModePage]
class ThemeModePageRoute extends _i49.PageRouteInfo<void> {
  const ThemeModePageRoute()
      : super(
          ThemeModePageRoute.name,
          path: 'theme-mode',
        );

  static const String name = 'ThemeModePageRoute';
}

/// generated route for
/// [_i21.UpdatePasswordPage]
class UpdatePasswordPageRoute extends _i49.PageRouteInfo<void> {
  const UpdatePasswordPageRoute()
      : super(
          UpdatePasswordPageRoute.name,
          path: 'update-password',
        );

  static const String name = 'UpdatePasswordPageRoute';
}

/// generated route for
/// [_i22.HomeChatPage]
class HomeChatPageRoute extends _i49.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i23.HomeEventPage]
class HomeEventPageRoute extends _i49.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i24.Location]
class LocationRoute extends _i49.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: 'map',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i25.HomeSearchPage]
class HomeSearchPageRoute extends _i49.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i26.HomeProfilePage]
class HomeProfilePageRoute extends _i49.PageRouteInfo<void> {
  const HomeProfilePageRoute({List<_i49.PageRouteInfo>? children})
      : super(
          HomeProfilePageRoute.name,
          path: 'current-profile/:id',
          initialChildren: children,
        );

  static const String name = 'HomeProfilePageRoute';
}

/// generated route for
/// [_i27.ShoppingListPage]
class ShoppingListPageRoute extends _i49.PageRouteInfo<void> {
  const ShoppingListPageRoute()
      : super(
          ShoppingListPageRoute.name,
          path: '',
        );

  static const String name = 'ShoppingListPageRoute';
}

/// generated route for
/// [_i28.ShoppingListItemPage]
class ShoppingListItemPageRoute
    extends _i49.PageRouteInfo<ShoppingListItemPageRouteArgs> {
  ShoppingListItemPageRoute({
    _i50.Key? key,
    required String shoppingListItemId,
    required _i55.CurrentShoppingListItemState
        currentShoppingListItemStateToSet,
  }) : super(
          ShoppingListItemPageRoute.name,
          path: ':shoppingListItemId',
          args: ShoppingListItemPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            currentShoppingListItemStateToSet:
                currentShoppingListItemStateToSet,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
        );

  static const String name = 'ShoppingListItemPageRoute';
}

class ShoppingListItemPageRouteArgs {
  const ShoppingListItemPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.currentShoppingListItemStateToSet,
  });

  final _i50.Key? key;

  final String shoppingListItemId;

  final _i55.CurrentShoppingListItemState currentShoppingListItemStateToSet;

  @override
  String toString() {
    return 'ShoppingListItemPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, currentShoppingListItemStateToSet: $currentShoppingListItemStateToSet}';
  }
}

/// generated route for
/// [_i29.ChatPage]
class ChatPageRoute extends _i49.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i50.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i30.ChatInfoPage]
class ChatInfoPageRoute extends _i49.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i50.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i31.ChatChangeChatUsernamePage]
class ChatChangeChatUsernamePageRoute extends _i49.PageRouteInfo<void> {
  const ChatChangeChatUsernamePageRoute()
      : super(
          ChatChangeChatUsernamePageRoute.name,
          path: 'change-chat-username',
        );

  static const String name = 'ChatChangeChatUsernamePageRoute';
}

/// generated route for
/// [_i32.ChatFuturePrivateEventsPage]
class ChatFuturePrivateEventsPageRoute extends _i49.PageRouteInfo<void> {
  const ChatFuturePrivateEventsPageRoute()
      : super(
          ChatFuturePrivateEventsPageRoute.name,
          path: 'private-events',
        );

  static const String name = 'ChatFuturePrivateEventsPageRoute';
}

/// generated route for
/// [_i33.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i49.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i50.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i34.PrivateEventTabPage]
class PrivateEventTabPageRoute
    extends _i49.PageRouteInfo<PrivateEventTabPageRouteArgs> {
  PrivateEventTabPageRoute({
    _i50.Key? key,
    List<_i49.PageRouteInfo>? children,
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

  final _i50.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i35.PrivateEventInviteUserPage]
class PrivateEventInviteUserPageRoute extends _i49.PageRouteInfo<void> {
  const PrivateEventInviteUserPageRoute()
      : super(
          PrivateEventInviteUserPageRoute.name,
          path: 'invite',
        );

  static const String name = 'PrivateEventInviteUserPageRoute';
}

/// generated route for
/// [_i36.PrivateEventCreateShoppingListItemPage]
class PrivateEventCreateShoppingListItemPageRoute extends _i49
    .PageRouteInfo<PrivateEventCreateShoppingListItemPageRouteArgs> {
  PrivateEventCreateShoppingListItemPageRoute({_i50.Key? key})
      : super(
          PrivateEventCreateShoppingListItemPageRoute.name,
          path: 'create-shopping-list-item',
          args: PrivateEventCreateShoppingListItemPageRouteArgs(key: key),
        );

  static const String name = 'PrivateEventCreateShoppingListItemPageRoute';
}

class PrivateEventCreateShoppingListItemPageRouteArgs {
  const PrivateEventCreateShoppingListItemPageRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'PrivateEventCreateShoppingListItemPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i37.PrivateEventShoppingListItemPage]
class PrivateEventShoppingListItemPageRoute
    extends _i49.PageRouteInfo<PrivateEventShoppingListItemPageRouteArgs> {
  PrivateEventShoppingListItemPageRoute({
    _i50.Key? key,
    required String shoppingListItemId,
    required _i55.CurrentShoppingListItemState shoppingListItemStateToSet,
    bool loadShoppingListItemFromApiToo = true,
    bool setCurrentPrivateEvent = false,
  }) : super(
          PrivateEventShoppingListItemPageRoute.name,
          path: 'shopping-list/:shoppingListItemId',
          args: PrivateEventShoppingListItemPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemStateToSet: shoppingListItemStateToSet,
            loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
            setCurrentPrivateEvent: setCurrentPrivateEvent,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
        );

  static const String name = 'PrivateEventShoppingListItemPageRoute';
}

class PrivateEventShoppingListItemPageRouteArgs {
  const PrivateEventShoppingListItemPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.loadShoppingListItemFromApiToo = true,
    this.setCurrentPrivateEvent = false,
  });

  final _i50.Key? key;

  final String shoppingListItemId;

  final _i55.CurrentShoppingListItemState shoppingListItemStateToSet;

  final bool loadShoppingListItemFromApiToo;

  final bool setCurrentPrivateEvent;

  @override
  String toString() {
    return 'PrivateEventShoppingListItemPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemStateToSet: $shoppingListItemStateToSet, loadShoppingListItemFromApiToo: $loadShoppingListItemFromApiToo, setCurrentPrivateEvent: $setCurrentPrivateEvent}';
  }
}

/// generated route for
/// [_i38.PrivateEventTabInfo]
class PrivateEventTabInfoRoute
    extends _i49.PageRouteInfo<PrivateEventTabInfoRouteArgs> {
  PrivateEventTabInfoRoute({_i50.Key? key})
      : super(
          PrivateEventTabInfoRoute.name,
          path: 'info',
          args: PrivateEventTabInfoRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabInfoRoute';
}

class PrivateEventTabInfoRouteArgs {
  const PrivateEventTabInfoRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i39.PrivateEventTabUserList]
class PrivateEventTabUserListRoute extends _i49.PageRouteInfo<void> {
  const PrivateEventTabUserListRoute()
      : super(
          PrivateEventTabUserListRoute.name,
          path: 'users',
        );

  static const String name = 'PrivateEventTabUserListRoute';
}

/// generated route for
/// [_i40.PrivateEventTabShoppingList]
class PrivateEventTabShoppingListRoute
    extends _i49.PageRouteInfo<PrivateEventTabShoppingListRouteArgs> {
  PrivateEventTabShoppingListRoute({_i50.Key? key})
      : super(
          PrivateEventTabShoppingListRoute.name,
          path: 'shopping-list',
          args: PrivateEventTabShoppingListRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabShoppingListRoute';
}

class PrivateEventTabShoppingListRouteArgs {
  const PrivateEventTabShoppingListRouteArgs({this.key});

  final _i50.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabShoppingListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i41.NewGroupchatDetailsTab]
class NewGroupchatDetailsTabRoute extends _i49.PageRouteInfo<void> {
  const NewGroupchatDetailsTabRoute()
      : super(
          NewGroupchatDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatDetailsTabRoute';
}

/// generated route for
/// [_i42.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTabRoute extends _i49.PageRouteInfo<void> {
  const NewGroupchatSelectUserTabRoute()
      : super(
          NewGroupchatSelectUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewGroupchatSelectUserTabRoute';
}

/// generated route for
/// [_i43.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventDetailsTabRoute()
      : super(
          NewPrivateEventDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventDetailsTabRoute';
}

/// generated route for
/// [_i44.NewPrivateEventTypeTab]
class NewPrivateEventTypeTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventTypeTabRoute()
      : super(
          NewPrivateEventTypeTabRoute.name,
          path: 'type',
        );

  static const String name = 'NewPrivateEventTypeTabRoute';
}

/// generated route for
/// [_i45.NewPrivateEventSearchUserTab]
class NewPrivateEventSearchUserTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventSearchUserTabRoute()
      : super(
          NewPrivateEventSearchUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewPrivateEventSearchUserTabRoute';
}

/// generated route for
/// [_i46.NewPrivateEventSearchGroupchatTab]
class NewPrivateEventSearchGroupchatTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventSearchGroupchatTabRoute()
      : super(
          NewPrivateEventSearchGroupchatTabRoute.name,
          path: 'groupchat',
        );

  static const String name = 'NewPrivateEventSearchGroupchatTabRoute';
}

/// generated route for
/// [_i47.NewPrivateEventDateTab]
class NewPrivateEventDateTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventDateTabRoute()
      : super(
          NewPrivateEventDateTabRoute.name,
          path: 'date',
        );

  static const String name = 'NewPrivateEventDateTabRoute';
}

/// generated route for
/// [_i48.NewPrivateEventLocationTab]
class NewPrivateEventLocationTabRoute extends _i49.PageRouteInfo<void> {
  const NewPrivateEventLocationTabRoute()
      : super(
          NewPrivateEventLocationTabRoute.name,
          path: 'location',
        );

  static const String name = 'NewPrivateEventLocationTabRoute';
}
