// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart'
    as _i35;
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart'
    as _i16;
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart'
    as _i9;
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart'
    as _i15;
import 'package:chattyevent_app_flutter/presentation/screens/future_events_page/future_events_page.dart'
    as _i14;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_add_user_page.dart'
    as _i30;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_change_chat_username_page.dart'
    as _i29;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_future_private_events_page.dart'
    as _i32;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_info_page.dart'
    as _i31;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page.dart'
    as _i26;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page_wrapper.dart'
    as _i28;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_update_permissions_page.dart'
    as _i27;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart'
    as _i7;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart'
    as _i6;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_event_page.dart'
    as _i5;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart'
    as _i3;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_search_page.dart'
    as _i4;
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart'
    as _i1;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart'
    as _i13;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart'
    as _i12;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_permissions_tab.dart'
    as _i10;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i11;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart'
    as _i25;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart'
    as _i22;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i23;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i24;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_permissions_tab.dart'
    as _i21;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tab.dart'
    as _i20;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart'
    as _i19;
import 'package:chattyevent_app_flutter/presentation/screens/past_events_page/past_events_page.dart'
    as _i8;
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart'
    as _i17;
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart'
    as _i18;
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart'
    as _i2;
import 'package:flutter/cupertino.dart' as _i36;
import 'package:flutter/material.dart' as _i34;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.VerifyEmailPage(),
      );
    },
    HomeProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeProfileRouteArgs>(
          orElse: () =>
              HomeProfileRouteArgs(userId: pathParams.optString('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomeProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    HomeSearchRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeSearchPage(),
      );
    },
    HomeEventRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeEventPage(),
      );
    },
    HomeChatRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeChatPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    PastEventsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.PastEventsPage(),
      );
    },
    BlocInitRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.BlocInitPage(),
      );
    },
    NewGroupchatPermissionsTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.NewGroupchatPermissionsTab(),
      );
    },
    NewGroupchatSelectUserTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.NewGroupchatSelectUserTab(),
      );
    },
    NewGroupchatDetailsTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatWrapperRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.NewGroupchatWrapperPage(),
      );
    },
    FutureEventsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.FutureEventsPage(),
      );
    },
    CreateUserRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.CreateUserPage(),
      );
    },
    AuthorizedRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.AuthorizedPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    NewPrivateEventTypeTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.NewPrivateEventTypeTab(),
      );
    },
    NewPrivateEventSearchTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.NewPrivateEventSearchTab(),
      );
    },
    NewPrivateEventPermissionsTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.NewPrivateEventPermissionsTab(),
      );
    },
    NewPrivateEventDateTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.NewPrivateEventDateTab(),
      );
    },
    NewPrivateEventDetailsTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventLocationTab.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.NewPrivateEventLocationTab(),
      );
    },
    NewPrivateEventRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.NewPrivateEventPage(),
      );
    },
    GroupchatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteArgs>(
          orElse: () =>
              GroupchatRouteArgs(groupchatId: pathParams.getString('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.GroupchatPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatUpdatePermissionsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.GroupchatUpdatePermissionsPage(),
      );
    },
    GroupchatRouteWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteWrapperArgs>(
          orElse: () => GroupchatRouteWrapperArgs(
              groupchatId: pathParams.getString('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.GroupchatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          groupchat: args.groupchat,
        ),
      );
    },
    GroupchatChangeUsernameRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.GroupchatChangeUsernamePage(),
      );
    },
    GroupchatAddUserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatAddUserRouteArgs>(
          orElse: () => GroupchatAddUserRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.GroupchatAddUserPage(
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
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.GroupchatInfoPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatFuturePrivateEventsRoute.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.GroupchatFuturePrivateEventsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i33.PageRouteInfo<void> {
  const LoginRoute({List<_i33.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i2.VerifyEmailPage]
class VerifyEmailRoute extends _i33.PageRouteInfo<void> {
  const VerifyEmailRoute({List<_i33.PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeProfilePage]
class HomeProfileRoute extends _i33.PageRouteInfo<HomeProfileRouteArgs> {
  HomeProfileRoute({
    _i34.Key? key,
    String? userId,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          HomeProfileRoute.name,
          args: HomeProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'HomeProfileRoute';

  static const _i33.PageInfo<HomeProfileRouteArgs> page =
      _i33.PageInfo<HomeProfileRouteArgs>(name);
}

class HomeProfileRouteArgs {
  const HomeProfileRouteArgs({
    this.key,
    this.userId,
  });

  final _i34.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'HomeProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i4.HomeSearchPage]
class HomeSearchRoute extends _i33.PageRouteInfo<void> {
  const HomeSearchRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeSearchRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomeEventPage]
class HomeEventRoute extends _i33.PageRouteInfo<void> {
  const HomeEventRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeEventRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeChatPage]
class HomeChatRoute extends _i33.PageRouteInfo<void> {
  const HomeChatRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeChatRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i33.PageRouteInfo<void> {
  const HomeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i8.PastEventsPage]
class PastEventsRoute extends _i33.PageRouteInfo<void> {
  const PastEventsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          PastEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PastEventsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i9.BlocInitPage]
class BlocInitRoute extends _i33.PageRouteInfo<void> {
  const BlocInitRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BlocInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocInitRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i10.NewGroupchatPermissionsTab]
class NewGroupchatPermissionsTab extends _i33.PageRouteInfo<void> {
  const NewGroupchatPermissionsTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewGroupchatPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatPermissionsTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i11.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTab extends _i33.PageRouteInfo<void> {
  const NewGroupchatSelectUserTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewGroupchatSelectUserTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatSelectUserTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i12.NewGroupchatDetailsTab]
class NewGroupchatDetailsTab extends _i33.PageRouteInfo<void> {
  const NewGroupchatDetailsTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewGroupchatDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatDetailsTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NewGroupchatWrapperPage]
class NewGroupchatWrapperRoute extends _i33.PageRouteInfo<void> {
  const NewGroupchatWrapperRoute({List<_i33.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i14.FutureEventsPage]
class FutureEventsRoute extends _i33.PageRouteInfo<void> {
  const FutureEventsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          FutureEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FutureEventsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i15.CreateUserPage]
class CreateUserRoute extends _i33.PageRouteInfo<void> {
  const CreateUserRoute({List<_i33.PageRouteInfo>? children})
      : super(
          CreateUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateUserRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i16.AuthorizedPage]
class AuthorizedRoute extends _i33.PageRouteInfo<void> {
  const AuthorizedRoute({List<_i33.PageRouteInfo>? children})
      : super(
          AuthorizedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizedRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i17.RegisterPage]
class RegisterRoute extends _i33.PageRouteInfo<void> {
  const RegisterRoute({List<_i33.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ResetPasswordPage]
class ResetPasswordRoute extends _i33.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i34.Key? key,
    String? standardEmail,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            standardEmail: standardEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i33.PageInfo<ResetPasswordRouteArgs> page =
      _i33.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    this.standardEmail,
  });

  final _i34.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i19.NewPrivateEventTypeTab]
class NewPrivateEventTypeTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventTypeTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventTypeTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventTypeTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i20.NewPrivateEventSearchTab]
class NewPrivateEventSearchTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventSearchTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventSearchTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventSearchTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i21.NewPrivateEventPermissionsTab]
class NewPrivateEventPermissionsTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventPermissionsTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPermissionsTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i22.NewPrivateEventDateTab]
class NewPrivateEventDateTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventDateTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventDateTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDateTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i23.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventDetailsTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDetailsTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i24.NewPrivateEventLocationTab]
class NewPrivateEventLocationTab extends _i33.PageRouteInfo<void> {
  const NewPrivateEventLocationTab({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventLocationTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventLocationTab';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i25.NewPrivateEventPage]
class NewPrivateEventRoute extends _i33.PageRouteInfo<void> {
  const NewPrivateEventRoute({List<_i33.PageRouteInfo>? children})
      : super(
          NewPrivateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i26.GroupchatPage]
class GroupchatRoute extends _i33.PageRouteInfo<GroupchatRouteArgs> {
  GroupchatRoute({
    required String groupchatId,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<GroupchatRouteArgs> page =
      _i33.PageInfo<GroupchatRouteArgs>(name);
}

class GroupchatRouteArgs {
  const GroupchatRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i34.Key? key;

  @override
  String toString() {
    return 'GroupchatRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i27.GroupchatUpdatePermissionsPage]
class GroupchatUpdatePermissionsRoute extends _i33.PageRouteInfo<void> {
  const GroupchatUpdatePermissionsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          GroupchatUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatUpdatePermissionsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i28.GroupchatPageWrapper]
class GroupchatRouteWrapper
    extends _i33.PageRouteInfo<GroupchatRouteWrapperArgs> {
  GroupchatRouteWrapper({
    _i34.Key? key,
    required String groupchatId,
    _i35.GroupchatEntity? groupchat,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<GroupchatRouteWrapperArgs> page =
      _i33.PageInfo<GroupchatRouteWrapperArgs>(name);
}

class GroupchatRouteWrapperArgs {
  const GroupchatRouteWrapperArgs({
    this.key,
    required this.groupchatId,
    this.groupchat,
  });

  final _i34.Key? key;

  final String groupchatId;

  final _i35.GroupchatEntity? groupchat;

  @override
  String toString() {
    return 'GroupchatRouteWrapperArgs{key: $key, groupchatId: $groupchatId, groupchat: $groupchat}';
  }
}

/// generated route for
/// [_i29.GroupchatChangeUsernamePage]
class GroupchatChangeUsernameRoute extends _i33.PageRouteInfo<void> {
  const GroupchatChangeUsernameRoute({List<_i33.PageRouteInfo>? children})
      : super(
          GroupchatChangeUsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatChangeUsernameRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i30.GroupchatAddUserPage]
class GroupchatAddUserRoute
    extends _i33.PageRouteInfo<GroupchatAddUserRouteArgs> {
  GroupchatAddUserRoute({
    required String groupchatId,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<GroupchatAddUserRouteArgs> page =
      _i33.PageInfo<GroupchatAddUserRouteArgs>(name);
}

class GroupchatAddUserRouteArgs {
  const GroupchatAddUserRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i34.Key? key;

  @override
  String toString() {
    return 'GroupchatAddUserRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i31.GroupchatInfoPage]
class GroupchatInfoRoute extends _i33.PageRouteInfo<GroupchatInfoRouteArgs> {
  GroupchatInfoRoute({
    required String groupchatId,
    _i36.Key? key,
    List<_i33.PageRouteInfo>? children,
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

  static const _i33.PageInfo<GroupchatInfoRouteArgs> page =
      _i33.PageInfo<GroupchatInfoRouteArgs>(name);
}

class GroupchatInfoRouteArgs {
  const GroupchatInfoRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i36.Key? key;

  @override
  String toString() {
    return 'GroupchatInfoRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i32.GroupchatFuturePrivateEventsPage]
class GroupchatFuturePrivateEventsRoute extends _i33.PageRouteInfo<void> {
  const GroupchatFuturePrivateEventsRoute({List<_i33.PageRouteInfo>? children})
      : super(
          GroupchatFuturePrivateEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatFuturePrivateEventsRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}
