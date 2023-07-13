// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i68;
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart'
    as _i70;
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart'
    as _i71;
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart'
    as _i74;
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart'
    as _i73;
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart'
    as _i1;
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart'
    as _i2;
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart'
    as _i3;
import 'package:chattyevent_app_flutter/presentation/screens/future_events_page/future_events_page.dart'
    as _i4;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_add_user_page.dart'
    as _i61;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_change_chat_username_page.dart'
    as _i62;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_future_private_events_page.dart'
    as _i63;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_info_page.dart'
    as _i64;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page.dart'
    as _i65;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page_wrapper.dart'
    as _i66;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_update_permissions_page.dart'
    as _i67;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart'
    as _i5;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart'
    as _i6;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_event_page.dart'
    as _i7;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart'
    as _i8;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_search_page.dart'
    as _i9;
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart'
    as _i10;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart'
    as _i11;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart'
    as _i12;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_permissions_tab.dart'
    as _i13;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i14;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart'
    as _i15;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart'
    as _i16;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i17;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i18;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_permissions_tab.dart'
    as _i19;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tab.dart'
    as _i20;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart'
    as _i21;
import 'package:chattyevent_app_flutter/presentation/screens/past_events_page/past_events_page.dart'
    as _i22;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_create_shopping_list_item_page.dart'
    as _i23;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_invite_user_page.dart'
    as _i24;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_update_loaction_page.dart'
    as _i25;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_update_permissions_page.dart'
    as _i26;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart'
    as _i27;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_change_user_page.dart'
    as _i28;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_page.dart'
    as _i29;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_wrapper_page.dart'
    as _i30;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_chat.dart'
    as _i31;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_info.dart'
    as _i32;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart'
    as _i33;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_user_list.dart'
    as _i34;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i35;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_chat_page.dart'
    as _i36;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_page.dart'
    as _i37;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart'
    as _i40;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart'
    as _i38;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart'
    as _i39;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart'
    as _i41;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_wrapper_page.dart'
    as _i42;
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart'
    as _i43;
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart'
    as _i44;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_page.dart'
    as _i45;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/imprint_page.dart'
    as _i46;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_deletion_page.dart'
    as _i47;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_insight.dart'
    as _i48;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_page.dart'
    as _i49;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/groupchat_add_me_page.dart'
    as _i50;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/private_event_add_me_page.dart'
    as _i51;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart'
    as _i52;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart'
    as _i53;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/settings_page.dart'
    as _i54;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_change_user_page.dart'
    as _i55;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_page.dart'
    as _i56;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_wrapper_page.dart'
    as _i57;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart'
    as _i58;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_wrapper_page.dart'
    as _i59;
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart'
    as _i60;
import 'package:flutter/cupertino.dart' as _i72;
import 'package:flutter/material.dart' as _i69;

abstract class $AppRouter extends _i68.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i68.PageFactory> pagesMap = {
    AuthorizedRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthorizedPage(),
      );
    },
    BlocInitRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BlocInitPage(),
      );
    },
    CreateUserRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CreateUserPage(),
      );
    },
    FutureEventsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.FutureEventsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    HomeChatRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeChatPage(),
      );
    },
    HomeEventRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomeEventPage(),
      );
    },
    HomeProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeProfileRouteArgs>(
          orElse: () =>
              HomeProfileRouteArgs(userId: pathParams.optString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.HomeProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    HomeSearchRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeSearchPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    NewGroupchatWrapperRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.NewGroupchatWrapperPage(),
      );
    },
    NewGroupchatDetailsTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatPermissionsTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.NewGroupchatPermissionsTab(),
      );
    },
    NewGroupchatSelectUserTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.NewPrivateEventPage(),
      );
    },
    NewPrivateEventDateTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.NewPrivateEventDateTab(),
      );
    },
    NewPrivateEventDetailsTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventLocationTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.NewPrivateEventLocationTab(),
      );
    },
    NewPrivateEventPermissionsTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.NewPrivateEventPermissionsTab(),
      );
    },
    NewPrivateEventSearchTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.NewPrivateEventSearchTab(),
      );
    },
    NewPrivateEventTypeTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.NewPrivateEventTypeTab(),
      );
    },
    PastEventsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.PastEventsPage(),
      );
    },
    PrivateEventCreateShoppingListItemRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.PrivateEventCreateShoppingListItemPage(),
      );
    },
    PrivateEventInviteUserRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.PrivateEventInviteUserPage(),
      );
    },
    PrivateEventUpdateLocationRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.PrivateEventUpdateLocationPage(),
      );
    },
    PrivateEventUpdatePermissionsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.PrivateEventUpdatePermissionsPage(),
      );
    },
    PrivateEventWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventWrapperRouteArgs>(
          orElse: () => PrivateEventWrapperRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.PrivateEventWrapperPage(
          privateEventId: args.privateEventId,
          privateEventStateToSet: args.privateEventStateToSet,
          key: args.key,
        ),
      );
    },
    PrivateEventShoppingListItemChangeUserRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.PrivateEventShoppingListItemChangeUserPage(),
      );
    },
    PrivateEventShoppingListItemRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.PrivateEventShoppingListItemPage(),
      );
    },
    PrivateEventShoppingListItemWrapperRoute.name: (routeData) {
      final args =
          routeData.argsAs<PrivateEventShoppingListItemWrapperRouteArgs>();
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.PrivateEventShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemStateToSet: args.shoppingListItemStateToSet,
          setCurrentPrivateEvent: args.setCurrentPrivateEvent,
        ),
      );
    },
    PrivateEventTabChat.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabChatArgs>(
          orElse: () => PrivateEventTabChatArgs(
              privateEventId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.PrivateEventTabChat(
          privateEventId: args.privateEventId,
          key: args.key,
        ),
      );
    },
    PrivateEventTabInfo.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.PrivateEventTabInfo(),
      );
    },
    PrivateEventTabShoppingList.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.PrivateEventTabShoppingList(),
      );
    },
    PrivateEventTabUserList.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.PrivateEventTabUserList(),
      );
    },
    PrivateEventTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabRouteArgs>(
          orElse: () => PrivateEventTabRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.PrivateEventTabPage(
          key: args.key,
          privateEventId: args.privateEventId,
        ),
      );
    },
    ProfileChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileChatRouteArgs>(
          orElse: () =>
              ProfileChatRouteArgs(userId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i36.ProfileChatPage(
          userId: args.userId,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.optString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i37.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileFollowedTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.ProfileFollowedTab(),
      );
    },
    ProfileFollowerTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.ProfileFollowerTab(),
      );
    },
    ProfileFollowRequestsTab.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.ProfileFollowRequestsTab(),
      );
    },
    ProfileUserRelationsTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileUserRelationsTabRouteArgs>(
          orElse: () => ProfileUserRelationsTabRouteArgs(
              userId: pathParams.optString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i41.ProfileUserRelationsTabPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileWrapperRouteArgs>(
          orElse: () =>
              ProfileWrapperRouteArgs(userId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i42.ProfileWrapperPage(
          key: args.key,
          user: args.user,
          userId: args.userId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i43.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i44.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    SettingsInfoRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.SettingsInfoPage(),
      );
    },
    ImprintRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i46.ImprintPage(),
      );
    },
    RightOnDeletionRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i47.RightOnDeletionPage(),
      );
    },
    RightOnInsightRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i48.RightOnInsightPage(),
      );
    },
    SettingsPrivacyRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i49.SettingsPrivacyPage(),
      );
    },
    GroupchatAddMeRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i50.GroupchatAddMePage(),
      );
    },
    PrivateEventAddMeRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i51.PrivateEventAddMePage(),
      );
    },
    ThemeModeRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i52.ThemeModePage(),
      );
    },
    UpdatePasswordRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i53.UpdatePasswordPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i54.SettingsPage(),
      );
    },
    ShoppingListItemChangeUserRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i55.ShoppingListItemChangeUserPage(),
      );
    },
    ShoppingListItemRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i56.ShoppingListItemPage(),
      );
    },
    ShoppingListItemWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<ShoppingListItemWrapperRouteArgs>();
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i57.ShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          currentShoppingListItemStateToSet:
              args.currentShoppingListItemStateToSet,
        ),
      );
    },
    ShoppingListRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i58.ShoppingListPage(),
      );
    },
    ShoppingListWrapperRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i59.ShoppingListWrapperPage(),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i60.VerifyEmailPage(),
      );
    },
    GroupchatAddUserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatAddUserRouteArgs>(
          orElse: () => GroupchatAddUserRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i61.GroupchatAddUserPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatChangeUsernameRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i62.GroupchatChangeUsernamePage(),
      );
    },
    GroupchatFuturePrivateEventsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i63.GroupchatFuturePrivateEventsPage(),
      );
    },
    GroupchatInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatInfoRouteArgs>(
          orElse: () =>
              GroupchatInfoRouteArgs(groupchatId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i64.GroupchatInfoPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteArgs>(
          orElse: () =>
              GroupchatRouteArgs(groupchatId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i65.GroupchatPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatRouteWrapper.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatRouteWrapperArgs>(
          orElse: () => GroupchatRouteWrapperArgs(
              groupchatId: pathParams.getString('id')));
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i66.GroupchatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          groupchat: args.groupchat,
        ),
      );
    },
    GroupchatUpdatePermissionsRoute.name: (routeData) {
      return _i68.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i67.GroupchatUpdatePermissionsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthorizedPage]
class AuthorizedRoute extends _i68.PageRouteInfo<void> {
  const AuthorizedRoute({List<_i68.PageRouteInfo>? children})
      : super(
          AuthorizedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizedRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BlocInitPage]
class BlocInitRoute extends _i68.PageRouteInfo<void> {
  const BlocInitRoute({List<_i68.PageRouteInfo>? children})
      : super(
          BlocInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocInitRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreateUserPage]
class CreateUserRoute extends _i68.PageRouteInfo<void> {
  const CreateUserRoute({List<_i68.PageRouteInfo>? children})
      : super(
          CreateUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateUserRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i4.FutureEventsPage]
class FutureEventsRoute extends _i68.PageRouteInfo<void> {
  const FutureEventsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          FutureEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FutureEventsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i68.PageRouteInfo<void> {
  const HomeRoute({List<_i68.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeChatPage]
class HomeChatRoute extends _i68.PageRouteInfo<void> {
  const HomeChatRoute({List<_i68.PageRouteInfo>? children})
      : super(
          HomeChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeChatRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomeEventPage]
class HomeEventRoute extends _i68.PageRouteInfo<void> {
  const HomeEventRoute({List<_i68.PageRouteInfo>? children})
      : super(
          HomeEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeEventRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HomeProfilePage]
class HomeProfileRoute extends _i68.PageRouteInfo<HomeProfileRouteArgs> {
  HomeProfileRoute({
    _i69.Key? key,
    String? userId,
    List<_i68.PageRouteInfo>? children,
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

  static const _i68.PageInfo<HomeProfileRouteArgs> page =
      _i68.PageInfo<HomeProfileRouteArgs>(name);
}

class HomeProfileRouteArgs {
  const HomeProfileRouteArgs({
    this.key,
    this.userId,
  });

  final _i69.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'HomeProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i9.HomeSearchPage]
class HomeSearchRoute extends _i68.PageRouteInfo<void> {
  const HomeSearchRoute({List<_i68.PageRouteInfo>? children})
      : super(
          HomeSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeSearchRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i68.PageRouteInfo<void> {
  const LoginRoute({List<_i68.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i11.NewGroupchatWrapperPage]
class NewGroupchatWrapperRoute extends _i68.PageRouteInfo<void> {
  const NewGroupchatWrapperRoute({List<_i68.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i12.NewGroupchatDetailsTab]
class NewGroupchatDetailsTab extends _i68.PageRouteInfo<void> {
  const NewGroupchatDetailsTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewGroupchatDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatDetailsTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i13.NewGroupchatPermissionsTab]
class NewGroupchatPermissionsTab extends _i68.PageRouteInfo<void> {
  const NewGroupchatPermissionsTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewGroupchatPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatPermissionsTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i14.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTab extends _i68.PageRouteInfo<void> {
  const NewGroupchatSelectUserTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewGroupchatSelectUserTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatSelectUserTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i15.NewPrivateEventPage]
class NewPrivateEventRoute extends _i68.PageRouteInfo<void> {
  const NewPrivateEventRoute({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i16.NewPrivateEventDateTab]
class NewPrivateEventDateTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventDateTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventDateTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDateTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i17.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventDetailsTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDetailsTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i18.NewPrivateEventLocationTab]
class NewPrivateEventLocationTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventLocationTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventLocationTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventLocationTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i19.NewPrivateEventPermissionsTab]
class NewPrivateEventPermissionsTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventPermissionsTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPermissionsTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i20.NewPrivateEventSearchTab]
class NewPrivateEventSearchTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventSearchTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventSearchTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventSearchTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i21.NewPrivateEventTypeTab]
class NewPrivateEventTypeTab extends _i68.PageRouteInfo<void> {
  const NewPrivateEventTypeTab({List<_i68.PageRouteInfo>? children})
      : super(
          NewPrivateEventTypeTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventTypeTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i22.PastEventsPage]
class PastEventsRoute extends _i68.PageRouteInfo<void> {
  const PastEventsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PastEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PastEventsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i23.PrivateEventCreateShoppingListItemPage]
class PrivateEventCreateShoppingListItemRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventCreateShoppingListItemRoute(
      {List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventCreateShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventCreateShoppingListItemRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i24.PrivateEventInviteUserPage]
class PrivateEventInviteUserRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventInviteUserRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventInviteUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventInviteUserRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i25.PrivateEventUpdateLocationPage]
class PrivateEventUpdateLocationRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventUpdateLocationRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventUpdateLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventUpdateLocationRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i26.PrivateEventUpdatePermissionsPage]
class PrivateEventUpdatePermissionsRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventUpdatePermissionsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventUpdatePermissionsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i27.PrivateEventWrapperPage]
class PrivateEventWrapperRoute
    extends _i68.PageRouteInfo<PrivateEventWrapperRouteArgs> {
  PrivateEventWrapperRoute({
    required String privateEventId,
    _i70.CurrentPrivateEventState? privateEventStateToSet,
    _i69.Key? key,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          PrivateEventWrapperRoute.name,
          args: PrivateEventWrapperRouteArgs(
            privateEventId: privateEventId,
            privateEventStateToSet: privateEventStateToSet,
            key: key,
          ),
          rawPathParams: {'id': privateEventId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventWrapperRoute';

  static const _i68.PageInfo<PrivateEventWrapperRouteArgs> page =
      _i68.PageInfo<PrivateEventWrapperRouteArgs>(name);
}

class PrivateEventWrapperRouteArgs {
  const PrivateEventWrapperRouteArgs({
    required this.privateEventId,
    this.privateEventStateToSet,
    this.key,
  });

  final String privateEventId;

  final _i70.CurrentPrivateEventState? privateEventStateToSet;

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperRouteArgs{privateEventId: $privateEventId, privateEventStateToSet: $privateEventStateToSet, key: $key}';
  }
}

/// generated route for
/// [_i28.PrivateEventShoppingListItemChangeUserPage]
class PrivateEventShoppingListItemChangeUserRoute
    extends _i68.PageRouteInfo<void> {
  const PrivateEventShoppingListItemChangeUserRoute(
      {List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventShoppingListItemChangeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventShoppingListItemChangeUserRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i29.PrivateEventShoppingListItemPage]
class PrivateEventShoppingListItemRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventShoppingListItemRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventShoppingListItemRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i30.PrivateEventShoppingListItemWrapperPage]
class PrivateEventShoppingListItemWrapperRoute
    extends _i68.PageRouteInfo<PrivateEventShoppingListItemWrapperRouteArgs> {
  PrivateEventShoppingListItemWrapperRoute({
    _i69.Key? key,
    required String shoppingListItemId,
    required _i71.CurrentShoppingListItemState shoppingListItemStateToSet,
    bool setCurrentPrivateEvent = false,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          PrivateEventShoppingListItemWrapperRoute.name,
          args: PrivateEventShoppingListItemWrapperRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemStateToSet: shoppingListItemStateToSet,
            setCurrentPrivateEvent: setCurrentPrivateEvent,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventShoppingListItemWrapperRoute';

  static const _i68.PageInfo<PrivateEventShoppingListItemWrapperRouteArgs>
      page = _i68.PageInfo<PrivateEventShoppingListItemWrapperRouteArgs>(name);
}

class PrivateEventShoppingListItemWrapperRouteArgs {
  const PrivateEventShoppingListItemWrapperRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.setCurrentPrivateEvent = false,
  });

  final _i69.Key? key;

  final String shoppingListItemId;

  final _i71.CurrentShoppingListItemState shoppingListItemStateToSet;

  final bool setCurrentPrivateEvent;

  @override
  String toString() {
    return 'PrivateEventShoppingListItemWrapperRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemStateToSet: $shoppingListItemStateToSet, setCurrentPrivateEvent: $setCurrentPrivateEvent}';
  }
}

/// generated route for
/// [_i31.PrivateEventTabChat]
class PrivateEventTabChat extends _i68.PageRouteInfo<PrivateEventTabChatArgs> {
  PrivateEventTabChat({
    required String privateEventId,
    _i72.Key? key,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          PrivateEventTabChat.name,
          args: PrivateEventTabChatArgs(
            privateEventId: privateEventId,
            key: key,
          ),
          rawPathParams: {'id': privateEventId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabChat';

  static const _i68.PageInfo<PrivateEventTabChatArgs> page =
      _i68.PageInfo<PrivateEventTabChatArgs>(name);
}

class PrivateEventTabChatArgs {
  const PrivateEventTabChatArgs({
    required this.privateEventId,
    this.key,
  });

  final String privateEventId;

  final _i72.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabChatArgs{privateEventId: $privateEventId, key: $key}';
  }
}

/// generated route for
/// [_i32.PrivateEventTabInfo]
class PrivateEventTabInfo extends _i68.PageRouteInfo<void> {
  const PrivateEventTabInfo({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventTabInfo.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabInfo';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i33.PrivateEventTabShoppingList]
class PrivateEventTabShoppingList extends _i68.PageRouteInfo<void> {
  const PrivateEventTabShoppingList({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventTabShoppingList.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabShoppingList';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i34.PrivateEventTabUserList]
class PrivateEventTabUserList extends _i68.PageRouteInfo<void> {
  const PrivateEventTabUserList({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventTabUserList.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabUserList';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i35.PrivateEventTabPage]
class PrivateEventTabRoute
    extends _i68.PageRouteInfo<PrivateEventTabRouteArgs> {
  PrivateEventTabRoute({
    _i69.Key? key,
    required String privateEventId,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          PrivateEventTabRoute.name,
          args: PrivateEventTabRouteArgs(
            key: key,
            privateEventId: privateEventId,
          ),
          rawPathParams: {'id': privateEventId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventTabRoute';

  static const _i68.PageInfo<PrivateEventTabRouteArgs> page =
      _i68.PageInfo<PrivateEventTabRouteArgs>(name);
}

class PrivateEventTabRouteArgs {
  const PrivateEventTabRouteArgs({
    this.key,
    required this.privateEventId,
  });

  final _i69.Key? key;

  final String privateEventId;

  @override
  String toString() {
    return 'PrivateEventTabRouteArgs{key: $key, privateEventId: $privateEventId}';
  }
}

/// generated route for
/// [_i36.ProfileChatPage]
class ProfileChatRoute extends _i68.PageRouteInfo<ProfileChatRouteArgs> {
  ProfileChatRoute({
    required String userId,
    _i69.Key? key,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ProfileChatRoute.name,
          args: ProfileChatRouteArgs(
            userId: userId,
            key: key,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileChatRoute';

  static const _i68.PageInfo<ProfileChatRouteArgs> page =
      _i68.PageInfo<ProfileChatRouteArgs>(name);
}

class ProfileChatRouteArgs {
  const ProfileChatRouteArgs({
    required this.userId,
    this.key,
  });

  final String userId;

  final _i69.Key? key;

  @override
  String toString() {
    return 'ProfileChatRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i37.ProfilePage]
class ProfileRoute extends _i68.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i72.Key? key,
    String? userId,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i68.PageInfo<ProfileRouteArgs> page =
      _i68.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.userId,
  });

  final _i72.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i38.ProfileFollowedTab]
class ProfileFollowedTab extends _i68.PageRouteInfo<void> {
  const ProfileFollowedTab({List<_i68.PageRouteInfo>? children})
      : super(
          ProfileFollowedTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowedTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i39.ProfileFollowerTab]
class ProfileFollowerTab extends _i68.PageRouteInfo<void> {
  const ProfileFollowerTab({List<_i68.PageRouteInfo>? children})
      : super(
          ProfileFollowerTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowerTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i40.ProfileFollowRequestsTab]
class ProfileFollowRequestsTab extends _i68.PageRouteInfo<void> {
  const ProfileFollowRequestsTab({List<_i68.PageRouteInfo>? children})
      : super(
          ProfileFollowRequestsTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowRequestsTab';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i41.ProfileUserRelationsTabPage]
class ProfileUserRelationsTabRoute
    extends _i68.PageRouteInfo<ProfileUserRelationsTabRouteArgs> {
  ProfileUserRelationsTabRoute({
    _i69.Key? key,
    String? userId,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ProfileUserRelationsTabRoute.name,
          args: ProfileUserRelationsTabRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileUserRelationsTabRoute';

  static const _i68.PageInfo<ProfileUserRelationsTabRouteArgs> page =
      _i68.PageInfo<ProfileUserRelationsTabRouteArgs>(name);
}

class ProfileUserRelationsTabRouteArgs {
  const ProfileUserRelationsTabRouteArgs({
    this.key,
    this.userId,
  });

  final _i69.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'ProfileUserRelationsTabRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i42.ProfileWrapperPage]
class ProfileWrapperRoute extends _i68.PageRouteInfo<ProfileWrapperRouteArgs> {
  ProfileWrapperRoute({
    _i69.Key? key,
    _i73.UserEntity? user,
    required String userId,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ProfileWrapperRoute.name,
          args: ProfileWrapperRouteArgs(
            key: key,
            user: user,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'ProfileWrapperRoute';

  static const _i68.PageInfo<ProfileWrapperRouteArgs> page =
      _i68.PageInfo<ProfileWrapperRouteArgs>(name);
}

class ProfileWrapperRouteArgs {
  const ProfileWrapperRouteArgs({
    this.key,
    this.user,
    required this.userId,
  });

  final _i69.Key? key;

  final _i73.UserEntity? user;

  final String userId;

  @override
  String toString() {
    return 'ProfileWrapperRouteArgs{key: $key, user: $user, userId: $userId}';
  }
}

/// generated route for
/// [_i43.RegisterPage]
class RegisterRoute extends _i68.PageRouteInfo<void> {
  const RegisterRoute({List<_i68.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i44.ResetPasswordPage]
class ResetPasswordRoute extends _i68.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i69.Key? key,
    String? standardEmail,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            standardEmail: standardEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i68.PageInfo<ResetPasswordRouteArgs> page =
      _i68.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    this.standardEmail,
  });

  final _i69.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i45.SettingsInfoPage]
class SettingsInfoRoute extends _i68.PageRouteInfo<void> {
  const SettingsInfoRoute({List<_i68.PageRouteInfo>? children})
      : super(
          SettingsInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsInfoRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i46.ImprintPage]
class ImprintRoute extends _i68.PageRouteInfo<void> {
  const ImprintRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ImprintRoute.name,
          initialChildren: children,
        );

  static const String name = 'ImprintRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i47.RightOnDeletionPage]
class RightOnDeletionRoute extends _i68.PageRouteInfo<void> {
  const RightOnDeletionRoute({List<_i68.PageRouteInfo>? children})
      : super(
          RightOnDeletionRoute.name,
          initialChildren: children,
        );

  static const String name = 'RightOnDeletionRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i48.RightOnInsightPage]
class RightOnInsightRoute extends _i68.PageRouteInfo<void> {
  const RightOnInsightRoute({List<_i68.PageRouteInfo>? children})
      : super(
          RightOnInsightRoute.name,
          initialChildren: children,
        );

  static const String name = 'RightOnInsightRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i49.SettingsPrivacyPage]
class SettingsPrivacyRoute extends _i68.PageRouteInfo<void> {
  const SettingsPrivacyRoute({List<_i68.PageRouteInfo>? children})
      : super(
          SettingsPrivacyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPrivacyRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i50.GroupchatAddMePage]
class GroupchatAddMeRoute extends _i68.PageRouteInfo<void> {
  const GroupchatAddMeRoute({List<_i68.PageRouteInfo>? children})
      : super(
          GroupchatAddMeRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatAddMeRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i51.PrivateEventAddMePage]
class PrivateEventAddMeRoute extends _i68.PageRouteInfo<void> {
  const PrivateEventAddMeRoute({List<_i68.PageRouteInfo>? children})
      : super(
          PrivateEventAddMeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventAddMeRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i52.ThemeModePage]
class ThemeModeRoute extends _i68.PageRouteInfo<void> {
  const ThemeModeRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ThemeModeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeModeRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i53.UpdatePasswordPage]
class UpdatePasswordRoute extends _i68.PageRouteInfo<void> {
  const UpdatePasswordRoute({List<_i68.PageRouteInfo>? children})
      : super(
          UpdatePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdatePasswordRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i54.SettingsPage]
class SettingsRoute extends _i68.PageRouteInfo<void> {
  const SettingsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i55.ShoppingListItemChangeUserPage]
class ShoppingListItemChangeUserRoute extends _i68.PageRouteInfo<void> {
  const ShoppingListItemChangeUserRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ShoppingListItemChangeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemChangeUserRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i56.ShoppingListItemPage]
class ShoppingListItemRoute extends _i68.PageRouteInfo<void> {
  const ShoppingListItemRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i57.ShoppingListItemWrapperPage]
class ShoppingListItemWrapperRoute
    extends _i68.PageRouteInfo<ShoppingListItemWrapperRouteArgs> {
  ShoppingListItemWrapperRoute({
    _i69.Key? key,
    required String shoppingListItemId,
    required _i71.CurrentShoppingListItemState
        currentShoppingListItemStateToSet,
    List<_i68.PageRouteInfo>? children,
  }) : super(
          ShoppingListItemWrapperRoute.name,
          args: ShoppingListItemWrapperRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            currentShoppingListItemStateToSet:
                currentShoppingListItemStateToSet,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemWrapperRoute';

  static const _i68.PageInfo<ShoppingListItemWrapperRouteArgs> page =
      _i68.PageInfo<ShoppingListItemWrapperRouteArgs>(name);
}

class ShoppingListItemWrapperRouteArgs {
  const ShoppingListItemWrapperRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.currentShoppingListItemStateToSet,
  });

  final _i69.Key? key;

  final String shoppingListItemId;

  final _i71.CurrentShoppingListItemState currentShoppingListItemStateToSet;

  @override
  String toString() {
    return 'ShoppingListItemWrapperRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, currentShoppingListItemStateToSet: $currentShoppingListItemStateToSet}';
  }
}

/// generated route for
/// [_i58.ShoppingListPage]
class ShoppingListRoute extends _i68.PageRouteInfo<void> {
  const ShoppingListRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ShoppingListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i59.ShoppingListWrapperPage]
class ShoppingListWrapperRoute extends _i68.PageRouteInfo<void> {
  const ShoppingListWrapperRoute({List<_i68.PageRouteInfo>? children})
      : super(
          ShoppingListWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListWrapperRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i60.VerifyEmailPage]
class VerifyEmailRoute extends _i68.PageRouteInfo<void> {
  const VerifyEmailRoute({List<_i68.PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i61.GroupchatAddUserPage]
class GroupchatAddUserRoute
    extends _i68.PageRouteInfo<GroupchatAddUserRouteArgs> {
  GroupchatAddUserRoute({
    required String groupchatId,
    _i69.Key? key,
    List<_i68.PageRouteInfo>? children,
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

  static const _i68.PageInfo<GroupchatAddUserRouteArgs> page =
      _i68.PageInfo<GroupchatAddUserRouteArgs>(name);
}

class GroupchatAddUserRouteArgs {
  const GroupchatAddUserRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i69.Key? key;

  @override
  String toString() {
    return 'GroupchatAddUserRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i62.GroupchatChangeUsernamePage]
class GroupchatChangeUsernameRoute extends _i68.PageRouteInfo<void> {
  const GroupchatChangeUsernameRoute({List<_i68.PageRouteInfo>? children})
      : super(
          GroupchatChangeUsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatChangeUsernameRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i63.GroupchatFuturePrivateEventsPage]
class GroupchatFuturePrivateEventsRoute extends _i68.PageRouteInfo<void> {
  const GroupchatFuturePrivateEventsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          GroupchatFuturePrivateEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatFuturePrivateEventsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}

/// generated route for
/// [_i64.GroupchatInfoPage]
class GroupchatInfoRoute extends _i68.PageRouteInfo<GroupchatInfoRouteArgs> {
  GroupchatInfoRoute({
    required String groupchatId,
    _i72.Key? key,
    List<_i68.PageRouteInfo>? children,
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

  static const _i68.PageInfo<GroupchatInfoRouteArgs> page =
      _i68.PageInfo<GroupchatInfoRouteArgs>(name);
}

class GroupchatInfoRouteArgs {
  const GroupchatInfoRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i72.Key? key;

  @override
  String toString() {
    return 'GroupchatInfoRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i65.GroupchatPage]
class GroupchatRoute extends _i68.PageRouteInfo<GroupchatRouteArgs> {
  GroupchatRoute({
    required String groupchatId,
    _i69.Key? key,
    List<_i68.PageRouteInfo>? children,
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

  static const _i68.PageInfo<GroupchatRouteArgs> page =
      _i68.PageInfo<GroupchatRouteArgs>(name);
}

class GroupchatRouteArgs {
  const GroupchatRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i69.Key? key;

  @override
  String toString() {
    return 'GroupchatRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i66.GroupchatPageWrapper]
class GroupchatRouteWrapper
    extends _i68.PageRouteInfo<GroupchatRouteWrapperArgs> {
  GroupchatRouteWrapper({
    _i69.Key? key,
    required String groupchatId,
    _i74.GroupchatEntity? groupchat,
    List<_i68.PageRouteInfo>? children,
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

  static const _i68.PageInfo<GroupchatRouteWrapperArgs> page =
      _i68.PageInfo<GroupchatRouteWrapperArgs>(name);
}

class GroupchatRouteWrapperArgs {
  const GroupchatRouteWrapperArgs({
    this.key,
    required this.groupchatId,
    this.groupchat,
  });

  final _i69.Key? key;

  final String groupchatId;

  final _i74.GroupchatEntity? groupchat;

  @override
  String toString() {
    return 'GroupchatRouteWrapperArgs{key: $key, groupchatId: $groupchatId, groupchat: $groupchat}';
  }
}

/// generated route for
/// [_i67.GroupchatUpdatePermissionsPage]
class GroupchatUpdatePermissionsRoute extends _i68.PageRouteInfo<void> {
  const GroupchatUpdatePermissionsRoute({List<_i68.PageRouteInfo>? children})
      : super(
          GroupchatUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatUpdatePermissionsRoute';

  static const _i68.PageInfo<void> page = _i68.PageInfo<void>(name);
}
