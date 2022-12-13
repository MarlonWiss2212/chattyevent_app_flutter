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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../domain/entities/groupchat/groupchat_entity.dart' as _i12;
import '../../domain/entities/private_event_entity.dart' as _i13;
import '../screens/chat_page.dart' as _i4;
import '../screens/home_page/home_page.dart' as _i3;
import '../screens/login_page.dart' as _i1;
import '../screens/new_event_page.dart' as _i8;
import '../screens/new_groupchat/new_groupchat_page.dart' as _i6;
import '../screens/new_groupchat/new_groupchat_select_users_page.dart' as _i7;
import '../screens/private_event_page.dart' as _i5;
import '../screens/register_page.dart' as _i2;
import 'auth_guard.dart' as _i11;

class AppRouter extends _i9.RootStackRouter {
  AppRouter({
    _i10.GlobalKey<_i10.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i11.AuthGuard authGuard;

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final args = routeData.argsAs<ChatPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ChatPage(
          groupchat: args.groupchat,
          key: args.key,
        ),
      );
    },
    PrivateEventPageRoute.name: (routeData) {
      final args = routeData.argsAs<PrivateEventPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.PrivateEventPage(
          privateEvent: args.privateEvent,
          key: args.key,
        ),
      );
    },
    NewGroupchatPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NewGroupchatPage(),
      );
    },
    NewGroupchatPageSelectUsersPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewGroupchatPageSelectUsersPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.NewGroupchatPageSelectUsersPage(
          key: args.key,
          title: args.title,
          description: args.description,
        ),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.NewPrivateEventPage(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i9.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i9.RouteConfig(
          HomePageRoute.name,
          path: '/',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          ChatPageRoute.name,
          path: '/chat-page',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          PrivateEventPageRoute.name,
          path: '/private-event-page',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          NewGroupchatPageRoute.name,
          path: '/new-groupchat-page',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          NewGroupchatPageSelectUsersPageRoute.name,
          path: '/new-groupchat-page-select-users-page',
          guards: [authGuard],
        ),
        _i9.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event-page',
          guards: [authGuard],
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i9.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i9.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i9.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.ChatPage]
class ChatPageRoute extends _i9.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({
    required _i12.GroupchatEntity groupchat,
    _i10.Key? key,
  }) : super(
          ChatPageRoute.name,
          path: '/chat-page',
          args: ChatPageRouteArgs(
            groupchat: groupchat,
            key: key,
          ),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({
    required this.groupchat,
    this.key,
  });

  final _i12.GroupchatEntity groupchat;

  final _i10.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{groupchat: $groupchat, key: $key}';
  }
}

/// generated route for
/// [_i5.PrivateEventPage]
class PrivateEventPageRoute
    extends _i9.PageRouteInfo<PrivateEventPageRouteArgs> {
  PrivateEventPageRoute({
    required _i13.PrivateEventEntity privateEvent,
    _i10.Key? key,
  }) : super(
          PrivateEventPageRoute.name,
          path: '/private-event-page',
          args: PrivateEventPageRouteArgs(
            privateEvent: privateEvent,
            key: key,
          ),
        );

  static const String name = 'PrivateEventPageRoute';
}

class PrivateEventPageRouteArgs {
  const PrivateEventPageRouteArgs({
    required this.privateEvent,
    this.key,
  });

  final _i13.PrivateEventEntity privateEvent;

  final _i10.Key? key;

  @override
  String toString() {
    return 'PrivateEventPageRouteArgs{privateEvent: $privateEvent, key: $key}';
  }
}

/// generated route for
/// [_i6.NewGroupchatPage]
class NewGroupchatPageRoute extends _i9.PageRouteInfo<void> {
  const NewGroupchatPageRoute()
      : super(
          NewGroupchatPageRoute.name,
          path: '/new-groupchat-page',
        );

  static const String name = 'NewGroupchatPageRoute';
}

/// generated route for
/// [_i7.NewGroupchatPageSelectUsersPage]
class NewGroupchatPageSelectUsersPageRoute
    extends _i9.PageRouteInfo<NewGroupchatPageSelectUsersPageRouteArgs> {
  NewGroupchatPageSelectUsersPageRoute({
    _i10.Key? key,
    required String title,
    String? description,
  }) : super(
          NewGroupchatPageSelectUsersPageRoute.name,
          path: '/new-groupchat-page-select-users-page',
          args: NewGroupchatPageSelectUsersPageRouteArgs(
            key: key,
            title: title,
            description: description,
          ),
        );

  static const String name = 'NewGroupchatPageSelectUsersPageRoute';
}

class NewGroupchatPageSelectUsersPageRouteArgs {
  const NewGroupchatPageSelectUsersPageRouteArgs({
    this.key,
    required this.title,
    this.description,
  });

  final _i10.Key? key;

  final String title;

  final String? description;

  @override
  String toString() {
    return 'NewGroupchatPageSelectUsersPageRouteArgs{key: $key, title: $title, description: $description}';
  }
}

/// generated route for
/// [_i8.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i9.PageRouteInfo<void> {
  const NewPrivateEventPageRoute()
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event-page',
        );

  static const String name = 'NewPrivateEventPageRoute';
}
