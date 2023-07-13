// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart'
    as _i17;
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart'
    as _i1;
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart'
    as _i2;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_add_user_page.dart'
    as _i13;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_change_chat_username_page.dart'
    as _i14;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_future_private_events_page.dart'
    as _i12;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_info_page.dart'
    as _i11;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_page.dart'
    as _i10;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_page_wrapper.dart'
    as _i9;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/groupchat_update_permissions_page.dart'
    as _i3;
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart'
    as _i4;
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart'
    as _i5;
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart'
    as _i6;
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart'
    as _i7;
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart'
    as _i8;
import 'package:flutter/cupertino.dart' as _i18;
import 'package:flutter/material.dart' as _i16;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    AuthorizedRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthorizedPage(),
      );
    },
    BlocInitRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BlocInitPage(),
      );
    },
    GroupchatUpdatePermissionsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.GroupchatUpdatePermissionsPage(),
      );
    },
    CreateUserRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.CreateUserPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.VerifyEmailPage(),
      );
    },
    GroupchatRouteWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteWrapperArgs>(
          orElse: () => GroupchatRouteWrapperArgs(
              groupchatId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.GroupchatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          groupchat: args.groupchat,
        ),
      );
    },
    GroupchatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteArgs>(
          orElse: () =>
              GroupchatRouteArgs(groupchatId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.GroupchatPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatInfoRouteArgs>(
          orElse: () =>
              GroupchatInfoRouteArgs(groupchatId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.GroupchatInfoPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatFuturePrivateEventsRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.GroupchatFuturePrivateEventsPage(),
      );
    },
    GroupchatAddUserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatAddUserRouteArgs>(
          orElse: () => GroupchatAddUserRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.GroupchatAddUserPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatChangeUsernameRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.GroupchatChangeUsernamePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthorizedPage]
class AuthorizedRoute extends _i15.PageRouteInfo<void> {
  const AuthorizedRoute({List<_i15.PageRouteInfo>? children})
      : super(
          AuthorizedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizedRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BlocInitPage]
class BlocInitRoute extends _i15.PageRouteInfo<void> {
  const BlocInitRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BlocInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocInitRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GroupchatUpdatePermissionsPage]
class GroupchatUpdatePermissionsRoute extends _i15.PageRouteInfo<void> {
  const GroupchatUpdatePermissionsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GroupchatUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatUpdatePermissionsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CreateUserPage]
class CreateUserRoute extends _i15.PageRouteInfo<void> {
  const CreateUserRoute({List<_i15.PageRouteInfo>? children})
      : super(
          CreateUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateUserRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ResetPasswordPage]
class ResetPasswordRoute extends _i15.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i16.Key? key,
    String? standardEmail,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            standardEmail: standardEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i15.PageInfo<ResetPasswordRouteArgs> page =
      _i15.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    this.standardEmail,
  });

  final _i16.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i8.VerifyEmailPage]
class VerifyEmailRoute extends _i15.PageRouteInfo<void> {
  const VerifyEmailRoute({List<_i15.PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.GroupchatPageWrapper]
class GroupchatRouteWrapper
    extends _i15.PageRouteInfo<GroupchatRouteWrapperArgs> {
  GroupchatRouteWrapper({
    _i16.Key? key,
    required String groupchatId,
    _i17.GroupchatEntity? groupchat,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GroupchatRouteWrapper.name,
          args: GroupchatRouteWrapperArgs(
            key: key,
            groupchatId: groupchatId,
            groupchat: groupchat,
          ),
          rawPathParams: {'id': groupchatId},
          initialChildren: children,
        );

  static const String name = 'GroupchatRouteWrapper';

  static const _i15.PageInfo<GroupchatRouteWrapperArgs> page =
      _i15.PageInfo<GroupchatRouteWrapperArgs>(name);
}

class GroupchatRouteWrapperArgs {
  const GroupchatRouteWrapperArgs({
    this.key,
    required this.groupchatId,
    this.groupchat,
  });

  final _i16.Key? key;

  final String groupchatId;

  final _i17.GroupchatEntity? groupchat;

  @override
  String toString() {
    return 'GroupchatRouteWrapperArgs{key: $key, groupchatId: $groupchatId, groupchat: $groupchat}';
  }
}

/// generated route for
/// [_i10.GroupchatPage]
class GroupchatRoute extends _i15.PageRouteInfo<GroupchatRouteArgs> {
  GroupchatRoute({
    required String groupchatId,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GroupchatRoute.name,
          args: GroupchatRouteArgs(
            groupchatId: groupchatId,
            key: key,
          ),
          rawPathParams: {'id': groupchatId},
          initialChildren: children,
        );

  static const String name = 'GroupchatRoute';

  static const _i15.PageInfo<GroupchatRouteArgs> page =
      _i15.PageInfo<GroupchatRouteArgs>(name);
}

class GroupchatRouteArgs {
  const GroupchatRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'GroupchatRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i11.GroupchatInfoPage]
class GroupchatInfoRoute extends _i15.PageRouteInfo<GroupchatInfoRouteArgs> {
  GroupchatInfoRoute({
    required String groupchatId,
    _i18.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GroupchatInfoRoute.name,
          args: GroupchatInfoRouteArgs(
            groupchatId: groupchatId,
            key: key,
          ),
          rawPathParams: {'id': groupchatId},
          initialChildren: children,
        );

  static const String name = 'GroupchatInfoRoute';

  static const _i15.PageInfo<GroupchatInfoRouteArgs> page =
      _i15.PageInfo<GroupchatInfoRouteArgs>(name);
}

class GroupchatInfoRouteArgs {
  const GroupchatInfoRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i18.Key? key;

  @override
  String toString() {
    return 'GroupchatInfoRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i12.GroupchatFuturePrivateEventsPage]
class GroupchatFuturePrivateEventsRoute extends _i15.PageRouteInfo<void> {
  const GroupchatFuturePrivateEventsRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GroupchatFuturePrivateEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatFuturePrivateEventsRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.GroupchatAddUserPage]
class GroupchatAddUserRoute
    extends _i15.PageRouteInfo<GroupchatAddUserRouteArgs> {
  GroupchatAddUserRoute({
    required String groupchatId,
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          GroupchatAddUserRoute.name,
          args: GroupchatAddUserRouteArgs(
            groupchatId: groupchatId,
            key: key,
          ),
          rawPathParams: {'id': groupchatId},
          initialChildren: children,
        );

  static const String name = 'GroupchatAddUserRoute';

  static const _i15.PageInfo<GroupchatAddUserRouteArgs> page =
      _i15.PageInfo<GroupchatAddUserRouteArgs>(name);
}

class GroupchatAddUserRouteArgs {
  const GroupchatAddUserRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i16.Key? key;

  @override
  String toString() {
    return 'GroupchatAddUserRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i14.GroupchatChangeUsernamePage]
class GroupchatChangeUsernameRoute extends _i15.PageRouteInfo<void> {
  const GroupchatChangeUsernameRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GroupchatChangeUsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatChangeUsernameRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
