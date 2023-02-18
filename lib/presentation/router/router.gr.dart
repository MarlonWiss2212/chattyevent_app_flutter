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
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:flutter/material.dart' as _i30;

import '../../domain/entities/groupchat/groupchat_entity.dart' as _i33;
import '../../domain/entities/private_event/private_event_entity.dart' as _i34;
import '../../domain/entities/user_entity.dart' as _i32;
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
import '../screens/new_groupchat/pages/new_groupchat_details_tab.dart' as _i24;
import '../screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i25;
import '../screens/new_private_event/new_private_event_page.dart' as _i9;
import '../screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i26;
import '../screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i28;
import '../screens/new_private_event/pages/new_private_event_search_groupchat_tab.dart'
    as _i27;
import '../screens/private_event_page/private_event_create_shopping_list_item.dart'
    as _i21;
import '../screens/private_event_page/private_event_wrapper_page.dart' as _i7;
import '../screens/private_event_page/tab_page/pages/info_tab.dart' as _i22;
import '../screens/private_event_page/tab_page/pages/shopping_list_tab.dart'
    as _i23;
import '../screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i20;
import '../screens/profile_page.dart' as _i3;
import '../screens/register_page.dart' as _i2;
import '../screens/settings_page/pages/settings_page.dart' as _i10;
import '../screens/settings_page/pages/theme_mode_page.dart' as _i11;
import '../screens/settings_page/settings_page_wrapper.dart' as _i4;
import 'auth_guard.dart' as _i31;

class AppRouter extends _i29.RootStackRouter {
  AppRouter({
    _i30.GlobalKey<_i30.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i31.AuthGuard authGuard;

  @override
  final Map<String, _i29.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () =>
              ProfilePageRouteArgs(userId: pathParams.getString('id')));
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsWrapperPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>(
          orElse: () => ChatPageWrapperRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NewPrivateEventPage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.SettingsPage(),
      );
    },
    ThemeModePageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ThemeModePage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.HomeEventPage(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.Location(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.HomeProfilePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
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
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.PrivateEventTabPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventCreateShoppingListItemRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCreateShoppingListItemRouteArgs>(
              orElse: () =>
                  const PrivateEventCreateShoppingListItemRouteArgs());
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.PrivateEventCreateShoppingListItem(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    InfoTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<InfoTabRouteArgs>(
          orElse: () => const InfoTabRouteArgs());
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.InfoTab(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ShoppingListTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ShoppingListTabRouteArgs>(
          orElse: () => const ShoppingListTabRouteArgs());
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i23.ShoppingListTab(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatDetailsTabRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i24.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatSelectUserTabRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i25.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventDetailsTabRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i26.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventSearchGroupchatTabRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i27.NewPrivateEventSearchGroupchatTab(),
      );
    },
    NewPrivateEventLocationTabRoute.name: (routeData) {
      return _i29.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i28.NewPrivateEventLocationTab(),
      );
    },
  };

  @override
  List<_i29.RouteConfig> get routes => [
        _i29.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i29.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i29.RouteConfig(
          ProfilePageRoute.name,
          path: '/profile/:id',
          guards: [authGuard],
        ),
        _i29.RouteConfig(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              SettingsPageRoute.name,
              path: '',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              ThemeModePageRoute.name,
              path: 'theme-mode',
              parent: SettingsWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: SettingsWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
            _i29.RouteConfig(
              HomeChatPageRoute.name,
              path: 'chats',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              HomeEventPageRoute.name,
              path: 'events',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              LocationRoute.name,
              path: 'map',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              HomeSearchPageRoute.name,
              path: 'search',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              HomeProfilePageRoute.name,
              path: 'profile',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          ChatPageWrapperRoute.name,
          path: '/chats/:id',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              ChatPageRoute.name,
              path: '',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              ChatInfoPageRoute.name,
              path: 'info',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              ChatAddUserPageRoute.name,
              path: 'add-user',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ChatPageWrapperRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          PrivateEventWrapperPageRoute.name,
          path: '/private-event/:id',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              PrivateEventTabPageRoute.name,
              path: '',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
              children: [
                _i29.RouteConfig(
                  '#redirect',
                  path: '',
                  parent: PrivateEventTabPageRoute.name,
                  redirectTo: 'info',
                  fullMatch: true,
                ),
                _i29.RouteConfig(
                  InfoTabRoute.name,
                  path: 'info',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
                _i29.RouteConfig(
                  ShoppingListTabRoute.name,
                  path: 'shopping-list',
                  parent: PrivateEventTabPageRoute.name,
                  guards: [authGuard],
                ),
              ],
            ),
            _i29.RouteConfig(
              PrivateEventCreateShoppingListItemRoute.name,
              path: 'create-shopping-list-item',
              parent: PrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: PrivateEventWrapperPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              NewGroupchatDetailsTabRoute.name,
              path: '',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              NewGroupchatSelectUserTabRoute.name,
              path: 'users',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewGroupchatWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          guards: [authGuard],
          children: [
            _i29.RouteConfig(
              NewPrivateEventDetailsTabRoute.name,
              path: '',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              NewPrivateEventSearchGroupchatTabRoute.name,
              path: 'groupchat',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              NewPrivateEventLocationTabRoute.name,
              path: 'location',
              parent: NewPrivateEventPageRoute.name,
              guards: [authGuard],
            ),
            _i29.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewPrivateEventPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i29.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i29.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i29.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.ProfilePage]
class ProfilePageRoute extends _i29.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    _i30.Key? key,
    bool loadUserFromApiToo = true,
    _i32.UserEntity? userToSet,
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

  final _i30.Key? key;

  final bool loadUserFromApiToo;

  final _i32.UserEntity? userToSet;

  final String userId;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, loadUserFromApiToo: $loadUserFromApiToo, userToSet: $userToSet, userId: $userId}';
  }
}

/// generated route for
/// [_i4.SettingsWrapperPage]
class SettingsWrapperPageRoute extends _i29.PageRouteInfo<void> {
  const SettingsWrapperPageRoute({List<_i29.PageRouteInfo>? children})
      : super(
          SettingsWrapperPageRoute.name,
          path: '/settings',
          initialChildren: children,
        );

  static const String name = 'SettingsWrapperPageRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomePageRoute extends _i29.PageRouteInfo<void> {
  const HomePageRoute({List<_i29.PageRouteInfo>? children})
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
    extends _i29.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i30.Key? key,
    required String groupchatId,
    _i33.GroupchatEntity? chatToSet,
    bool loadChatFromApiToo = true,
    List<_i29.PageRouteInfo>? children,
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

  final _i30.Key? key;

  final String groupchatId;

  final _i33.GroupchatEntity? chatToSet;

  final bool loadChatFromApiToo;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, chatToSet: $chatToSet, loadChatFromApiToo: $loadChatFromApiToo}';
  }
}

/// generated route for
/// [_i7.PrivateEventWrapperPage]
class PrivateEventWrapperPageRoute
    extends _i29.PageRouteInfo<PrivateEventWrapperPageRouteArgs> {
  PrivateEventWrapperPageRoute({
    required String privateEventId,
    _i34.PrivateEventEntity? privateEventToSet,
    bool loadPrivateEventFromApiToo = true,
    _i30.Key? key,
    List<_i29.PageRouteInfo>? children,
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

  final _i34.PrivateEventEntity? privateEventToSet;

  final bool loadPrivateEventFromApiToo;

  final _i30.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperPageRouteArgs{privateEventId: $privateEventId, privateEventToSet: $privateEventToSet, loadPrivateEventFromApiToo: $loadPrivateEventFromApiToo, key: $key}';
  }
}

/// generated route for
/// [_i8.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i29.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i29.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i9.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i29.PageRouteInfo<void> {
  const NewPrivateEventPageRoute({List<_i29.PageRouteInfo>? children})
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i10.SettingsPage]
class SettingsPageRoute extends _i29.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i11.ThemeModePage]
class ThemeModePageRoute extends _i29.PageRouteInfo<void> {
  const ThemeModePageRoute()
      : super(
          ThemeModePageRoute.name,
          path: 'theme-mode',
        );

  static const String name = 'ThemeModePageRoute';
}

/// generated route for
/// [_i12.HomeChatPage]
class HomeChatPageRoute extends _i29.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i13.HomeEventPage]
class HomeEventPageRoute extends _i29.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i14.Location]
class LocationRoute extends _i29.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: 'map',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i15.HomeSearchPage]
class HomeSearchPageRoute extends _i29.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i16.HomeProfilePage]
class HomeProfilePageRoute extends _i29.PageRouteInfo<void> {
  const HomeProfilePageRoute()
      : super(
          HomeProfilePageRoute.name,
          path: 'profile',
        );

  static const String name = 'HomeProfilePageRoute';
}

/// generated route for
/// [_i17.ChatPage]
class ChatPageRoute extends _i29.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i30.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.ChatInfoPage]
class ChatInfoPageRoute extends _i29.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i30.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i29.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i30.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i20.PrivateEventTabPage]
class PrivateEventTabPageRoute
    extends _i29.PageRouteInfo<PrivateEventTabPageRouteArgs> {
  PrivateEventTabPageRoute({
    _i30.Key? key,
    List<_i29.PageRouteInfo>? children,
  }) : super(
          PrivateEventTabPageRoute.name,
          path: '',
          args: PrivateEventTabPageRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabPageRoute';
}

class PrivateEventTabPageRouteArgs {
  const PrivateEventTabPageRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i21.PrivateEventCreateShoppingListItem]
class PrivateEventCreateShoppingListItemRoute
    extends _i29.PageRouteInfo<PrivateEventCreateShoppingListItemRouteArgs> {
  PrivateEventCreateShoppingListItemRoute({_i30.Key? key})
      : super(
          PrivateEventCreateShoppingListItemRoute.name,
          path: 'create-shopping-list-item',
          args: PrivateEventCreateShoppingListItemRouteArgs(key: key),
        );

  static const String name = 'PrivateEventCreateShoppingListItemRoute';
}

class PrivateEventCreateShoppingListItemRouteArgs {
  const PrivateEventCreateShoppingListItemRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'PrivateEventCreateShoppingListItemRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i22.InfoTab]
class InfoTabRoute extends _i29.PageRouteInfo<InfoTabRouteArgs> {
  InfoTabRoute({_i30.Key? key})
      : super(
          InfoTabRoute.name,
          path: 'info',
          args: InfoTabRouteArgs(key: key),
        );

  static const String name = 'InfoTabRoute';
}

class InfoTabRouteArgs {
  const InfoTabRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'InfoTabRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i23.ShoppingListTab]
class ShoppingListTabRoute
    extends _i29.PageRouteInfo<ShoppingListTabRouteArgs> {
  ShoppingListTabRoute({_i30.Key? key})
      : super(
          ShoppingListTabRoute.name,
          path: 'shopping-list',
          args: ShoppingListTabRouteArgs(key: key),
        );

  static const String name = 'ShoppingListTabRoute';
}

class ShoppingListTabRouteArgs {
  const ShoppingListTabRouteArgs({this.key});

  final _i30.Key? key;

  @override
  String toString() {
    return 'ShoppingListTabRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i24.NewGroupchatDetailsTab]
class NewGroupchatDetailsTabRoute extends _i29.PageRouteInfo<void> {
  const NewGroupchatDetailsTabRoute()
      : super(
          NewGroupchatDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatDetailsTabRoute';
}

/// generated route for
/// [_i25.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTabRoute extends _i29.PageRouteInfo<void> {
  const NewGroupchatSelectUserTabRoute()
      : super(
          NewGroupchatSelectUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewGroupchatSelectUserTabRoute';
}

/// generated route for
/// [_i26.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTabRoute extends _i29.PageRouteInfo<void> {
  const NewPrivateEventDetailsTabRoute()
      : super(
          NewPrivateEventDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventDetailsTabRoute';
}

/// generated route for
/// [_i27.NewPrivateEventSearchGroupchatTab]
class NewPrivateEventSearchGroupchatTabRoute extends _i29.PageRouteInfo<void> {
  const NewPrivateEventSearchGroupchatTabRoute()
      : super(
          NewPrivateEventSearchGroupchatTabRoute.name,
          path: 'groupchat',
        );

  static const String name = 'NewPrivateEventSearchGroupchatTabRoute';
}

/// generated route for
/// [_i28.NewPrivateEventLocationTab]
class NewPrivateEventLocationTabRoute extends _i29.PageRouteInfo<void> {
  const NewPrivateEventLocationTabRoute()
      : super(
          NewPrivateEventLocationTabRoute.name,
          path: 'location',
        );

  static const String name = 'NewPrivateEventLocationTabRoute';
}
