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
import 'package:auto_route/auto_route.dart' as _i30;
import 'package:flutter/material.dart' as _i31;

import '../../domain/entities/groupchat/groupchat_entity.dart' as _i34;
import '../../domain/entities/private_event/private_event_entity.dart' as _i35;
import '../../domain/entities/shopping_list_item/shopping_list_item_entity.dart'
    as _i36;
import '../../domain/entities/user_entity.dart' as _i33;
import '../screens/chat_page/chat_add_user_page.dart' as _i19;
import '../screens/chat_page/chat_info_page.dart' as _i18;
import '../screens/chat_page/chat_page.dart' as _i17;
import '../screens/chat_page/chat_page_wrapper.dart' as _i6;
import '../screens/home_page/home_page.dart' as _i5;
import '../screens/home_page/pages/home_chat_page.dart' as _i12;
import '../screens/home_page/pages/home_event_page.dart' as _i13;
import '../screens/home_page/pages/home_map_page.dart' as _i14;
import '../screens/home_page/pages/home_profile_page.dart' as _i16;
import '../screens/home_page/pages/home_search_page.dart' as _i15;
import '../screens/login_page.dart' as _i1;
import '../screens/new_groupchat/new_groupchat_wrapper_page.dart' as _i8;
import '../screens/new_groupchat/pages/new_groupchat_details_tab.dart' as _i25;
import '../screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i26;
import '../screens/new_private_event/new_private_event_page.dart' as _i9;
import '../screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i27;
import '../screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i29;
import '../screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart'
    as _i28;
import '../screens/private_event_page/private_event_create_shopping_list_item_page.dart'
    as _i21;
import '../screens/private_event_page/private_event_current_shopping_list_item_page.dart'
    as _i22;
import '../screens/private_event_page/private_event_wrapper_page.dart' as _i7;
import '../screens/private_event_page/tab_page/pages/private_event_tab_info.dart'
    as _i23;
import '../screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart'
    as _i24;
import '../screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i20;
import '../screens/profile_page.dart' as _i3;
import '../screens/register_page.dart' as _i2;
import '../screens/settings_page/pages/settings_page.dart' as _i10;
import '../screens/settings_page/pages/theme_mode_page.dart' as _i11;
import '../screens/settings_page/settings_page_wrapper.dart' as _i4;
import 'auth_guard.dart' as _i32;

class AppRouter extends _i30.RootStackRouter {
  AppRouter({
    _i31.GlobalKey<_i31.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i32.AuthGuard authGuard;

  @override
  final Map<String, _i30.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () =>
              ProfilePageRouteArgs(userId: pathParams.getString('id')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ProfilePage(
          key: args.key,
          loadUserFromApiToo: args.loadUserFromApiToo,
          userToSet: args.userToSet,
          userId: args.userId,
        ),
      );
    },
    SettingsWrapperPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsWrapperPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>(
          orElse: () => ChatPageWrapperRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ChatPageWrapper(
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
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.PrivateEventWrapperPage(
          privateEventId: args.privateEventId,
          privateEventToSet: args.privateEventToSet,
          loadPrivateEventFromApiToo: args.loadPrivateEventFromApiToo,
          key: args.key,
        ),
      );
    },
    NewGroupchatWrapperPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NewPrivateEventPage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsPage(),
      );
    },
    ThemeModePageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ThemeModePage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.HomeEventPage(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.Location(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.HomeProfilePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.ChatPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatInfoPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatInfoPageRouteArgs>(
          orElse: () => const ChatInfoPageRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.ChatInfoPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatAddUserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatAddUserPageRouteArgs>(
          orElse: () => const ChatAddUserPageRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i19.ChatAddUserPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabPageRouteArgs>(
          orElse: () => const PrivateEventTabPageRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.PrivateEventTabPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventCreateShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCreateShoppingListItemPageRouteArgs>(
              orElse: () =>
                  const PrivateEventCreateShoppingListItemPageRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.PrivateEventCreateShoppingListItemPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventCurrentShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCurrentShoppingListItemPageRouteArgs>(
              orElse: () => PrivateEventCurrentShoppingListItemPageRouteArgs(
                  shoppingListItemId:
                      pathParams.getString('shoppingListItemId')));
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.PrivateEventCurrentShoppingListItemPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemToSet: args.shoppingListItemToSet,
          loadShoppingListItemFromApiToo: args.loadShoppingListItemFromApiToo,
        ),
      );
    },
    PrivateEventTabInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabInfoRouteArgs>(
          orElse: () => const PrivateEventTabInfoRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.PrivateEventTabInfo(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabShoppingListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabShoppingListRouteArgs>(
          orElse: () => const PrivateEventTabShoppingListRouteArgs());
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i24.PrivateEventTabShoppingList(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatDetailsTabRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatSelectUserTabRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventDetailsTabRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventSearchGroupchatTabRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i28.NewPrivateEventSearchGroupchatTab(),
      );
    },
    NewPrivateEventLocationTabRoute.name: (routeData) {
      return _i30.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i29.NewPrivateEventLocationTab(),
      );
    },
  };

  @override
  List<_i30.RouteConfig> get routes => [
        _i30.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i30.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i30.RouteConfig(
          ProfilePageRoute.name,
          path: '/profile/:id',
          guards: [authGuard],
        ),
        _i30.RouteConfig(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              SettingsPageRoute.name,
              path: '',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              ThemeModePageRoute.name,
              path: 'theme-mode',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SettingsWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
            _i30.RouteConfig(
              HomeChatPageRoute.name,
              path: 'chats',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              HomeEventPageRoute.name,
              path: 'events',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              LocationRoute.name,
              path: 'map',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              HomeSearchPageRoute.name,
              path: 'search',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              HomeProfilePageRoute.name,
              path: 'profile',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              ChatPageRoute.name,
              path: '',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              ChatInfoPageRoute.name,
              path: 'info',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              ChatAddUserPageRoute.name,
              path: 'add-user',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ChatPageWrapperRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          PrivateEventWrapperPageRoute.name,
          path: '/private-event/:id',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              '#redirect',
              path: '',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
            _i30.RouteConfig(
              PrivateEventTabPageRoute.name,
              path: 'info',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i30.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: PrivateEventTabPageRoute.name,
                  redirectTo: 'info',
                  fullMatch: true,
                ),
                _i30.RouteConfig(
                  PrivateEventTabInfoRoute.name,
                  path: 'info',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i30.RouteConfig(
                  PrivateEventTabShoppingListRoute.name,
                  path: 'shopping-list',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i30.RouteConfig(
              PrivateEventCreateShoppingListItemPageRoute.name,
              path: 'create-shopping-list-item',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              PrivateEventCurrentShoppingListItemPageRoute.name,
              path: 'shopping-list/:shoppingListItemId',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              NewGroupchatDetailsTabRoute.name,
              path: '',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              NewGroupchatSelectUserTabRoute.name,
              path: 'users',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewGroupchatWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          guards: [authGuard],
          children: [
            _i30.RouteConfig(
              NewPrivateEventDetailsTabRoute.name,
              path: '',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              NewPrivateEventSearchGroupchatTabRoute.name,
              path: 'groupchat',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              NewPrivateEventLocationTabRoute.name,
              path: 'location',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i30.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewPrivateEventPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i30.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i30.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i30.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.ProfilePage]
class ProfilePageRoute extends _i30.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    _i31.Key? key,
    bool loadUserFromApiToo = true,
    _i33.UserEntity? userToSet,
    required String userId,
  }) : super(
          ProfilePageRoute.name,
          path: '/profile/:id',
          args: ProfilePageRouteArgs(
            key: key,
            loadUserFromApiToo: loadUserFromApiToo,
            userToSet: userToSet,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({
    this.key,
    this.loadUserFromApiToo = true,
    this.userToSet,
    required this.userId,
  });

  final _i31.Key? key;

  final bool loadUserFromApiToo;

  final _i33.UserEntity? userToSet;

  final String userId;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, loadUserFromApiToo: $loadUserFromApiToo, userToSet: $userToSet, userId: $userId}';
  }
}

/// generated route for
/// [_i4.SettingsWrapperPage]
class SettingsWrapperPageRoute extends _i30.PageRouteInfo<void> {
  const SettingsWrapperPageRoute({List<_i30.PageRouteInfo>? children})
      : super(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          initialChildren: children,
        );

  static const String name = 'SettingsWrapperPageRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomePageRoute extends _i30.PageRouteInfo<void> {
  const HomePageRoute({List<_i30.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i6.ChatPageWrapper]
class ChatPageWrapperRoute
    extends _i30.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i31.Key? key,
    required String groupchatId,
    _i34.GroupchatEntity? chatToSet,
    bool loadChatFromApiToo = true,
    List<_i30.PageRouteInfo>? children,
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

  final _i31.Key? key;

  final String groupchatId;

  final _i34.GroupchatEntity? chatToSet;

  final bool loadChatFromApiToo;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, chatToSet: $chatToSet, loadChatFromApiToo: $loadChatFromApiToo}';
  }
}

/// generated route for
/// [_i7.PrivateEventWrapperPage]
class PrivateEventWrapperPageRoute
    extends _i30.PageRouteInfo<PrivateEventWrapperPageRouteArgs> {
  PrivateEventWrapperPageRoute({
    required String privateEventId,
    _i35.PrivateEventEntity? privateEventToSet,
    bool loadPrivateEventFromApiToo = true,
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
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

  final _i35.PrivateEventEntity? privateEventToSet;

  final bool loadPrivateEventFromApiToo;

  final _i31.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperPageRouteArgs{privateEventId: $privateEventId, privateEventToSet: $privateEventToSet, loadPrivateEventFromApiToo: $loadPrivateEventFromApiToo, key: $key}';
  }
}

/// generated route for
/// [_i8.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i30.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i30.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i9.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i30.PageRouteInfo<void> {
  const NewPrivateEventPageRoute({List<_i30.PageRouteInfo>? children})
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsPageRoute extends _i30.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i11.ThemeModePage]
class ThemeModePageRoute extends _i30.PageRouteInfo<void> {
  const ThemeModePageRoute()
      : super(
          ThemeModePageRoute.name,
          path: 'theme-mode',
        );

  static const String name = 'ThemeModePageRoute';
}

/// generated route for
/// [_i12.HomeChatPage]
class HomeChatPageRoute extends _i30.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i13.HomeEventPage]
class HomeEventPageRoute extends _i30.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i14.Location]
class LocationRoute extends _i30.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: 'map',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i15.HomeSearchPage]
class HomeSearchPageRoute extends _i30.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i16.HomeProfilePage]
class HomeProfilePageRoute extends _i30.PageRouteInfo<void> {
  const HomeProfilePageRoute()
      : super(
          HomeProfilePageRoute.name,
          path: 'profile',
        );

  static const String name = 'HomeProfilePageRoute';
}

/// generated route for
/// [_i17.ChatPage]
class ChatPageRoute extends _i30.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i31.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.ChatInfoPage]
class ChatInfoPageRoute extends _i30.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i31.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i30.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i31.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.PrivateEventTabPage]
class PrivateEventTabPageRoute
    extends _i30.PageRouteInfo<PrivateEventTabPageRouteArgs> {
  PrivateEventTabPageRoute({
    _i31.Key? key,
    List<_i30.PageRouteInfo>? children,
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

  final _i31.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.PrivateEventCreateShoppingListItemPage]
class PrivateEventCreateShoppingListItemPageRoute extends _i30
    .PageRouteInfo<PrivateEventCreateShoppingListItemPageRouteArgs> {
  PrivateEventCreateShoppingListItemPageRoute({_i31.Key? key})
      : super(
          PrivateEventCreateShoppingListItemPageRoute.name,
          path: 'create-shopping-list-item',
          args: PrivateEventCreateShoppingListItemPageRouteArgs(key: key),
        );

  static const String name = 'PrivateEventCreateShoppingListItemPageRoute';
}

class PrivateEventCreateShoppingListItemPageRouteArgs {
  const PrivateEventCreateShoppingListItemPageRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'PrivateEventCreateShoppingListItemPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i22.PrivateEventCurrentShoppingListItemPage]
class PrivateEventCurrentShoppingListItemPageRoute extends _i30
    .PageRouteInfo<PrivateEventCurrentShoppingListItemPageRouteArgs> {
  PrivateEventCurrentShoppingListItemPageRoute({
    _i31.Key? key,
    required String shoppingListItemId,
    _i36.ShoppingListItemEntity? shoppingListItemToSet,
    bool loadShoppingListItemFromApiToo = true,
  }) : super(
          PrivateEventCurrentShoppingListItemPageRoute.name,
          path: 'shopping-list/:shoppingListItemId',
          args: PrivateEventCurrentShoppingListItemPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemToSet: shoppingListItemToSet,
            loadShoppingListItemFromApiToo: loadShoppingListItemFromApiToo,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
        );

  static const String name = 'PrivateEventCurrentShoppingListItemPageRoute';
}

class PrivateEventCurrentShoppingListItemPageRouteArgs {
  const PrivateEventCurrentShoppingListItemPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
  });

  final _i31.Key? key;

  final String shoppingListItemId;

  final _i36.ShoppingListItemEntity? shoppingListItemToSet;

  final bool loadShoppingListItemFromApiToo;

  @override
  String toString() {
    return 'PrivateEventCurrentShoppingListItemPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemToSet: $shoppingListItemToSet, loadShoppingListItemFromApiToo: $loadShoppingListItemFromApiToo}';
  }
}

/// generated route for
/// [_i23.PrivateEventTabInfo]
class PrivateEventTabInfoRoute
    extends _i30.PageRouteInfo<PrivateEventTabInfoRouteArgs> {
  PrivateEventTabInfoRoute({_i31.Key? key})
      : super(
          PrivateEventTabInfoRoute.name,
          path: 'info',
          args: PrivateEventTabInfoRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabInfoRoute';
}

class PrivateEventTabInfoRouteArgs {
  const PrivateEventTabInfoRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i24.PrivateEventTabShoppingList]
class PrivateEventTabShoppingListRoute
    extends _i30.PageRouteInfo<PrivateEventTabShoppingListRouteArgs> {
  PrivateEventTabShoppingListRoute({_i31.Key? key})
      : super(
          PrivateEventTabShoppingListRoute.name,
          path: 'shopping-list',
          args: PrivateEventTabShoppingListRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabShoppingListRoute';
}

class PrivateEventTabShoppingListRouteArgs {
  const PrivateEventTabShoppingListRouteArgs({this.key});

  final _i31.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabShoppingListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i25.NewGroupchatDetailsTab]
class NewGroupchatDetailsTabRoute extends _i30.PageRouteInfo<void> {
  const NewGroupchatDetailsTabRoute()
      : super(
          NewGroupchatDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatDetailsTabRoute';
}

/// generated route for
/// [_i26.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTabRoute extends _i30.PageRouteInfo<void> {
  const NewGroupchatSelectUserTabRoute()
      : super(
          NewGroupchatSelectUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewGroupchatSelectUserTabRoute';
}

/// generated route for
/// [_i27.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTabRoute extends _i30.PageRouteInfo<void> {
  const NewPrivateEventDetailsTabRoute()
      : super(
          NewPrivateEventDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventDetailsTabRoute';
}

/// generated route for
/// [_i28.NewPrivateEventSearchGroupchatTab]
class NewPrivateEventSearchGroupchatTabRoute extends _i30.PageRouteInfo<void> {
  const NewPrivateEventSearchGroupchatTabRoute()
      : super(
          NewPrivateEventSearchGroupchatTabRoute.name,
          path: 'groupchat',
        );

  static const String name = 'NewPrivateEventSearchGroupchatTabRoute';
}

/// generated route for
/// [_i29.NewPrivateEventLocationTab]
class NewPrivateEventLocationTabRoute extends _i30.PageRouteInfo<void> {
  const NewPrivateEventLocationTabRoute()
      : super(
          NewPrivateEventLocationTabRoute.name,
          path: 'location',
        );

  static const String name = 'NewPrivateEventLocationTabRoute';
}
