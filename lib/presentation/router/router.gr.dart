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
import 'dart:io' as _i26;

import 'package:auto_route/auto_route.dart' as _i23;
import 'package:flutter/material.dart' as _i24;

import '../../domain/entities/groupchat/groupchat_entity.dart' as _i27;
import '../screens/chat_page/chat_add_user_page.dart' as _i17;
import '../screens/chat_page/chat_info_page.dart' as _i16;
import '../screens/chat_page/chat_page.dart' as _i15;
import '../screens/chat_page/chat_page_wrapper.dart' as _i6;
import '../screens/home_page/home_page.dart' as _i5;
import '../screens/home_page/pages/home_chat_page.dart' as _i10;
import '../screens/home_page/pages/home_event_page.dart' as _i11;
import '../screens/home_page/pages/home_map_page.dart' as _i12;
import '../screens/home_page/pages/home_profile_page.dart' as _i14;
import '../screens/home_page/pages/home_search_page.dart' as _i13;
import '../screens/login_page.dart' as _i1;
import '../screens/new_groupchat/new_groupchat_page.dart' as _i19;
import '../screens/new_groupchat/new_groupchat_select_users_page.dart' as _i20;
import '../screens/new_groupchat/new_groupchat_wrapper_page.dart' as _i8;
import '../screens/new_private_event/new_private_event_location_page.dart'
    as _i22;
import '../screens/new_private_event/new_private_event_page.dart' as _i21;
import '../screens/new_private_event/new_private_event_wrapper_page.dart'
    as _i9;
import '../screens/private_event_page/pages/info_tab.dart' as _i18;
import '../screens/private_event_page/private_event_page.dart' as _i7;
import '../screens/profile_page.dart' as _i3;
import '../screens/register_page.dart' as _i2;
import '../screens/settings_page/settings_page.dart' as _i4;
import 'auth_guard.dart' as _i25;

class AppRouter extends _i23.RootStackRouter {
  AppRouter({
    _i24.GlobalKey<_i24.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i25.AuthGuard authGuard;

  @override
  final Map<String, _i23.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () =>
              ProfilePageRouteArgs(userId: pathParams.getString('id')));
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.SettingsPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>(
          orElse: () => ChatPageWrapperRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.ChatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          loadChat: args.loadChat,
        ),
      );
    },
    PrivateEventPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventPageRouteArgs>(
          orElse: () => PrivateEventPageRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.PrivateEventPage(
          privateEventId: args.privateEventId,
          loadPrivateEvent: args.loadPrivateEvent,
          key: args.key,
        ),
      );
    },
    NewGroupchatWrapperPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventWrapperPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NewPrivateEventWrapperPage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.HomeEventPage(),
      );
    },
    LocationRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.Location(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i13.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.HomeProfilePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.ChatPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatInfoPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatInfoPageRouteArgs>(
          orElse: () => const ChatInfoPageRouteArgs());
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i16.ChatInfoPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatAddUserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatAddUserPageRouteArgs>(
          orElse: () => const ChatAddUserPageRouteArgs());
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i17.ChatAddUserPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    InfoTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<InfoTabRouteArgs>(
          orElse: () => const InfoTabRouteArgs());
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i18.InfoTab(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.NewGroupchatPage(),
      );
    },
    NewGroupchatPageSelectUsersPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewGroupchatPageSelectUsersPageRouteArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i20.NewGroupchatPageSelectUsersPage(
          key: args.key,
          title: args.title,
          profileImage: args.profileImage,
          description: args.description,
        ),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i21.NewPrivateEventPage(),
      );
    },
    NewPrivateEventLocationPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewPrivateEventLocationPageRouteArgs>();
      return _i23.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i22.NewPrivateEventLocationPage(
          key: args.key,
          date: args.date,
          image: args.image,
          selectedGroupchat: args.selectedGroupchat,
          title: args.title,
        ),
      );
    },
  };

  @override
  List<_i23.RouteConfig> get routes => [
        _i23.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i23.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i23.RouteConfig(
          ProfilePageRoute.name,
          path: '/profile-page/:id',
          guards: [authGuard],
        ),
        _i23.RouteConfig(
          SettingsPageRoute.name,
          path: '/settings',
          guards: [authGuard],
        ),
        _i23.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i23.RouteConfig(
              '#redirect',
              path: '',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
            _i23.RouteConfig(
              HomeChatPageRoute.name,
              path: 'chats',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              HomeEventPageRoute.name,
              path: 'events',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              LocationRoute.name,
              path: 'map',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              HomeSearchPageRoute.name,
              path: 'search',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              HomeProfilePageRoute.name,
              path: 'profile',
              parent: HomePageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              '*#redirect',
              path: '*',
              parent: HomePageRoute.name,
              redirectTo: 'chats',
              fullMatch: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          ChatPageWrapperRoute.name,
          path: '/chat-page/:id',
          guards: [authGuard],
          children: [
            _i23.RouteConfig(
              ChatPageRoute.name,
              path: '',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              ChatInfoPageRoute.name,
              path: 'info',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              ChatAddUserPageRoute.name,
              path: 'add-user',
              parent: ChatPageWrapperRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              '*#redirect',
              path: '*',
              parent: ChatPageWrapperRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          PrivateEventPageRoute.name,
          path: '/private-event/:id',
          guards: [authGuard],
          children: [
            _i23.RouteConfig(
              '#redirect',
              path: '',
              parent: PrivateEventPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
            _i23.RouteConfig(
              InfoTabRoute.name,
              path: 'info',
              parent: PrivateEventPageRoute.name,
            ),
            _i23.RouteConfig(
              '*#redirect',
              path: '*',
              parent: PrivateEventPageRoute.name,
              redirectTo: 'info',
              fullMatch: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          guards: [authGuard],
          children: [
            _i23.RouteConfig(
              NewGroupchatPageRoute.name,
              path: '',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              NewGroupchatPageSelectUsersPageRoute.name,
              path: 'users',
              parent: NewGroupchatWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewGroupchatWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          NewPrivateEventWrapperPageRoute.name,
          path: '/new-private-event',
          guards: [authGuard],
          children: [
            _i23.RouteConfig(
              NewPrivateEventPageRoute.name,
              path: '',
              parent: NewPrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              NewPrivateEventLocationPageRoute.name,
              path: 'location',
              parent: NewPrivateEventWrapperPageRoute.name,
              guards: [authGuard],
            ),
            _i23.RouteConfig(
              '*#redirect',
              path: '*',
              parent: NewPrivateEventWrapperPageRoute.name,
              redirectTo: '',
              fullMatch: true,
            ),
          ],
        ),
        _i23.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i23.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i23.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.ProfilePage]
class ProfilePageRoute extends _i23.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({
    _i24.Key? key,
    required String userId,
  }) : super(
          ProfilePageRoute.name,
          path: '/profile-page/:id',
          args: ProfilePageRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({
    this.key,
    required this.userId,
  });

  final _i24.Key? key;

  final String userId;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i4.SettingsPage]
class SettingsPageRoute extends _i23.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: '/settings',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomePageRoute extends _i23.PageRouteInfo<void> {
  const HomePageRoute({List<_i23.PageRouteInfo>? children})
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
    extends _i23.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i24.Key? key,
    required String groupchatId,
    bool loadChat = true,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          ChatPageWrapperRoute.name,
          path: '/chat-page/:id',
          args: ChatPageWrapperRouteArgs(
            key: key,
            groupchatId: groupchatId,
            loadChat: loadChat,
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
    this.loadChat = true,
  });

  final _i24.Key? key;

  final String groupchatId;

  final bool loadChat;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, loadChat: $loadChat}';
  }
}

/// generated route for
/// [_i7.PrivateEventPage]
class PrivateEventPageRoute
    extends _i23.PageRouteInfo<PrivateEventPageRouteArgs> {
  PrivateEventPageRoute({
    required String privateEventId,
    bool loadPrivateEvent = true,
    _i24.Key? key,
    List<_i23.PageRouteInfo>? children,
  }) : super(
          PrivateEventPageRoute.name,
          path: '/private-event/:id',
          args: PrivateEventPageRouteArgs(
            privateEventId: privateEventId,
            loadPrivateEvent: loadPrivateEvent,
            key: key,
          ),
          rawPathParams: {'id': privateEventId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventPageRoute';
}

class PrivateEventPageRouteArgs {
  const PrivateEventPageRouteArgs({
    required this.privateEventId,
    this.loadPrivateEvent = true,
    this.key,
  });

  final String privateEventId;

  final bool loadPrivateEvent;

  final _i24.Key? key;

  @override
  String toString() {
    return 'PrivateEventPageRouteArgs{privateEventId: $privateEventId, loadPrivateEvent: $loadPrivateEvent, key: $key}';
  }
}

/// generated route for
/// [_i8.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i23.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i23.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: '/new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i9.NewPrivateEventWrapperPage]
class NewPrivateEventWrapperPageRoute extends _i23.PageRouteInfo<void> {
  const NewPrivateEventWrapperPageRoute({List<_i23.PageRouteInfo>? children})
      : super(
          NewPrivateEventWrapperPageRoute.name,
          path: '/new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventWrapperPageRoute';
}

/// generated route for
/// [_i10.HomeChatPage]
class HomeChatPageRoute extends _i23.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i11.HomeEventPage]
class HomeEventPageRoute extends _i23.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i12.Location]
class LocationRoute extends _i23.PageRouteInfo<void> {
  const LocationRoute()
      : super(
          LocationRoute.name,
          path: 'map',
        );

  static const String name = 'LocationRoute';
}

/// generated route for
/// [_i13.HomeSearchPage]
class HomeSearchPageRoute extends _i23.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i14.HomeProfilePage]
class HomeProfilePageRoute extends _i23.PageRouteInfo<void> {
  const HomeProfilePageRoute()
      : super(
          HomeProfilePageRoute.name,
          path: 'profile',
        );

  static const String name = 'HomeProfilePageRoute';
}

/// generated route for
/// [_i15.ChatPage]
class ChatPageRoute extends _i23.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i24.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.ChatInfoPage]
class ChatInfoPageRoute extends _i23.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i24.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i17.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i23.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i24.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.InfoTab]
class InfoTabRoute extends _i23.PageRouteInfo<InfoTabRouteArgs> {
  InfoTabRoute({_i24.Key? key})
      : super(
          InfoTabRoute.name,
          path: 'info',
          args: InfoTabRouteArgs(key: key),
        );

  static const String name = 'InfoTabRoute';
}

class InfoTabRouteArgs {
  const InfoTabRouteArgs({this.key});

  final _i24.Key? key;

  @override
  String toString() {
    return 'InfoTabRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i19.NewGroupchatPage]
class NewGroupchatPageRoute extends _i23.PageRouteInfo<void> {
  const NewGroupchatPageRoute()
      : super(
          NewGroupchatPageRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatPageRoute';
}

/// generated route for
/// [_i20.NewGroupchatPageSelectUsersPage]
class NewGroupchatPageSelectUsersPageRoute
    extends _i23.PageRouteInfo<NewGroupchatPageSelectUsersPageRouteArgs> {
  NewGroupchatPageSelectUsersPageRoute({
    _i24.Key? key,
    required String title,
    _i26.File? profileImage,
    String? description,
  }) : super(
          NewGroupchatPageSelectUsersPageRoute.name,
          path: 'users',
          args: NewGroupchatPageSelectUsersPageRouteArgs(
            key: key,
            title: title,
            profileImage: profileImage,
            description: description,
          ),
        );

  static const String name = 'NewGroupchatPageSelectUsersPageRoute';
}

class NewGroupchatPageSelectUsersPageRouteArgs {
  const NewGroupchatPageSelectUsersPageRouteArgs({
    this.key,
    required this.title,
    this.profileImage,
    this.description,
  });

  final _i24.Key? key;

  final String title;

  final _i26.File? profileImage;

  final String? description;

  @override
  String toString() {
    return 'NewGroupchatPageSelectUsersPageRouteArgs{key: $key, title: $title, profileImage: $profileImage, description: $description}';
  }
}

/// generated route for
/// [_i21.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i23.PageRouteInfo<void> {
  const NewPrivateEventPageRoute()
      : super(
          NewPrivateEventPageRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i22.NewPrivateEventLocationPage]
class NewPrivateEventLocationPageRoute
    extends _i23.PageRouteInfo<NewPrivateEventLocationPageRouteArgs> {
  NewPrivateEventLocationPageRoute({
    _i24.Key? key,
    required DateTime date,
    required _i26.File image,
    required _i27.GroupchatEntity selectedGroupchat,
    required dynamic title,
  }) : super(
          NewPrivateEventLocationPageRoute.name,
          path: 'location',
          args: NewPrivateEventLocationPageRouteArgs(
            key: key,
            date: date,
            image: image,
            selectedGroupchat: selectedGroupchat,
            title: title,
          ),
        );

  static const String name = 'NewPrivateEventLocationPageRoute';
}

class NewPrivateEventLocationPageRouteArgs {
  const NewPrivateEventLocationPageRouteArgs({
    this.key,
    required this.date,
    required this.image,
    required this.selectedGroupchat,
    required this.title,
  });

  final _i24.Key? key;

  final DateTime date;

  final _i26.File image;

  final _i27.GroupchatEntity selectedGroupchat;

  final dynamic title;

  @override
  String toString() {
    return 'NewPrivateEventLocationPageRouteArgs{key: $key, date: $date, image: $image, selectedGroupchat: $selectedGroupchat, title: $title}';
  }
}
