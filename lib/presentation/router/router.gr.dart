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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../screens/chat_page.dart' as _i4;
import '../screens/home_page/home_page.dart' as _i3;
import '../screens/login_page.dart' as _i1;
import '../screens/new_event_page.dart' as _i6;
import '../screens/new_groupchat_page.dart' as _i5;
import '../screens/register_page.dart' as _i2;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.ChatPage(),
      );
    },
    NewGroupchatPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.NewGroupchatPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.NewPrivateEventPage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          LoginPageRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
        ),
        _i7.RouteConfig(
          HomePageRoute.name,
          path: '/home-page',
        ),
        _i7.RouteConfig(
          ChatPageRoute.name,
          path: '/chat-page',
        ),
        _i7.RouteConfig(
          NewGroupchatPageRoute.name,
          path: '/new-groupchat-page',
        ),
        _i7.RouteConfig(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event-page',
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterPageRoute extends _i7.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i7.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.ChatPage]
class ChatPageRoute extends _i7.PageRouteInfo<void> {
  const ChatPageRoute()
      : super(
          ChatPageRoute.name,
          path: '/chat-page',
        );

  static const String name = 'ChatPageRoute';
}

/// generated route for
/// [_i5.NewGroupchatPage]
class NewGroupchatPageRoute extends _i7.PageRouteInfo<void> {
  const NewGroupchatPageRoute()
      : super(
          NewGroupchatPageRoute.name,
          path: '/new-groupchat-page',
        );

  static const String name = 'NewGroupchatPageRoute';
}

/// generated route for
/// [_i6.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i7.PageRouteInfo<void> {
  const NewPrivateEventPageRoute()
      : super(
          NewPrivateEventPageRoute.name,
          path: '/new-private-event-page',
        );

  static const String name = 'NewPrivateEventPageRoute';
}
