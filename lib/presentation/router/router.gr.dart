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
import 'package:auto_route/auto_route.dart' as _i63;
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart'
    as _i71;
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart'
    as _i73;
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart'
    as _i70;
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart'
    as _i72;
import 'package:chattyevent_app_flutter/presentation/router/auth_guard.dart'
    as _i68;
import 'package:chattyevent_app_flutter/presentation/router/auth_pages_guard.dart'
    as _i65;
import 'package:chattyevent_app_flutter/presentation/router/create_user_page_guard.dart'
    as _i67;
import 'package:chattyevent_app_flutter/presentation/router/verify_email_page_guard.dart'
    as _i66;
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart'
    as _i4;
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart'
    as _i7;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_add_user_page.dart'
    as _i43;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_change_chat_username_page.dart'
    as _i41;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_future_private_events_page.dart'
    as _i42;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_info_page.dart'
    as _i40;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_page.dart'
    as _i39;
import 'package:chattyevent_app_flutter/presentation/screens/chat_page/chat_page_wrapper.dart'
    as _i20;
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart'
    as _i6;
import 'package:chattyevent_app_flutter/presentation/screens/future_events_page/future_events_page.dart'
    as _i17;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart'
    as _i8;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart'
    as _i25;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_event_page.dart'
    as _i26;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_map_page.dart'
    as _i27;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart'
    as _i29;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_search_page.dart'
    as _i28;
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart'
    as _i1;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart'
    as _i23;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart'
    as _i56;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i57;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart'
    as _i24;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart'
    as _i61;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i58;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i62;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tab.dart'
    as _i60;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart'
    as _i59;
import 'package:chattyevent_app_flutter/presentation/screens/past_events_page/past_events_page.dart'
    as _i18;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_create_shopping_list_item_page.dart'
    as _i47;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_invite_user_page.dart'
    as _i46;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_update_loaction_page.dart'
    as _i45;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/private_event_wrapper_page.dart'
    as _i21;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_change_user_page.dart'
    as _i54;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_page.dart'
    as _i53;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/shopping_list_item_page/private_event_shopping_list_item_wrapper_page.dart'
    as _i48;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_chat.dart'
    as _i50;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_info.dart'
    as _i49;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_shopping_list.dart'
    as _i52;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/pages/private_event_tab_user_list.dart'
    as _i51;
import 'package:chattyevent_app_flutter/presentation/screens/private_event_page/tab_page/private_event_tab_page.dart'
    as _i44;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_chat_page.dart'
    as _i55;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_page.dart'
    as _i30;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart'
    as _i34;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart'
    as _i33;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart'
    as _i32;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart'
    as _i31;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_wrapper_page.dart'
    as _i22;
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart'
    as _i3;
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart'
    as _i2;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_page.dart'
    as _i12;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/imprint_page.dart'
    as _i15;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_deletion_page.dart'
    as _i14;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_insight.dart'
    as _i13;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_page.dart'
    as _i16;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart'
    as _i10;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/update_password_page.dart'
    as _i11;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/settings_page.dart'
    as _i9;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_change_user_page.dart'
    as _i38;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_page.dart'
    as _i37;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_wrapper_page.dart'
    as _i36;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart'
    as _i35;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_wrapper_page.dart'
    as _i19;
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart'
    as _i5;
import 'package:flutter/material.dart' as _i64;
import 'package:flutter/widgets.dart' as _i69;

class AppRouter extends _i63.RootStackRouter {
  AppRouter({
    _i64.GlobalKey<_i64.NavigatorState>? navigatorKey,
    required this.authPagesGuard,
    required this.verifyEmailPageGuard,
    required this.createUserPageGuard,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i65.AuthPagesGuard authPagesGuard;

  final _i66.VerifyEmailPageGuard verifyEmailPageGuard;

  final _i67.CreateUserPageGuard createUserPageGuard;

  final _i68.AuthGuard authGuard;

  @override
  final Map<String, _i63.PageFactory> pagesMap = {
    LoginPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
      );
    },
    ResetPasswordPageRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordPageRouteArgs>(
          orElse: () => const ResetPasswordPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    RegisterPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterPage(),
      );
    },
    AuthorizedPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.AuthorizedPage(),
      );
    },
    VerifyEmailPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.VerifyEmailPage(),
      );
    },
    CreateUserPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i6.CreateUserPage(),
      );
    },
    BlocInitPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.BlocInitPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    SettingsPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i9.SettingsPage(),
      );
    },
    ThemeModePageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i10.ThemeModePage(),
      );
    },
    UpdatePasswordPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i11.UpdatePasswordPage(),
      );
    },
    SettingsInfoPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i12.SettingsInfoPage(),
      );
    },
    RightOnInsightPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i13.RightOnInsightPage(),
      );
    },
    RightOnDeletionPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i14.RightOnDeletionPage(),
      );
    },
    ImprintPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i15.ImprintPage(),
      );
    },
    SettingsPrivacyPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i16.SettingsPrivacyPage(),
      );
    },
    FutureEventsPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i17.FutureEventsPage(),
      );
    },
    PastEventsPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i18.PastEventsPage(),
      );
    },
    ShoppingListWrapperPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i19.ShoppingListWrapperPage(),
      );
    },
    ChatPageWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageWrapperRouteArgs>(
          orElse: () => ChatPageWrapperRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i20.ChatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          groupchat: args.groupchat,
        ),
      );
    },
    PrivateEventWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventWrapperPageRouteArgs>(
          orElse: () => PrivateEventWrapperPageRouteArgs(
              privateEventId: pathParams.getString('id')));
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i21.PrivateEventWrapperPage(
          privateEventId: args.privateEventId,
          privateEventStateToSet: args.privateEventStateToSet,
          key: args.key,
        ),
      );
    },
    ProfileWrapperPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileWrapperPageRouteArgs>(
          orElse: () =>
              ProfileWrapperPageRouteArgs(userId: pathParams.getString('id')));
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i22.ProfileWrapperPage(
          key: args.key,
          user: args.user,
          userId: args.userId,
        ),
      );
    },
    NewGroupchatWrapperPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i23.NewGroupchatWrapperPage(),
      );
    },
    NewPrivateEventPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i24.NewPrivateEventPage(),
      );
    },
    HomeChatPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i25.HomeChatPage(),
      );
    },
    HomeEventPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i26.HomeEventPage(),
      );
    },
    HomeMapPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i27.HomeMapPage(),
      );
    },
    HomeSearchPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i28.HomeSearchPage(),
      );
    },
    HomeProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeProfilePageRouteArgs>(
          orElse: () =>
              HomeProfilePageRouteArgs(userId: pathParams.optString('id')));
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i29.HomeProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfilePageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfilePageRouteArgs>(
          orElse: () => const ProfilePageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i30.ProfilePage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
      );
    },
    ProfileUserRelationsTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileUserRelationsTabPageRouteArgs>(
          orElse: () => const ProfileUserRelationsTabPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i31.ProfileUserRelationsTabPage(
          key: args.key,
          userId: pathParams.optString('id'),
        ),
      );
    },
    ProfileFollowerTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i32.ProfileFollowerTab(),
      );
    },
    ProfileFollowedTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i33.ProfileFollowedTab(),
      );
    },
    ProfileFollowRequestsTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i34.ProfileFollowRequestsTab(),
      );
    },
    ShoppingListPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i35.ShoppingListPage(),
      );
    },
    ShoppingListItemWrapperPageRoute.name: (routeData) {
      final args = routeData.argsAs<ShoppingListItemWrapperPageRouteArgs>();
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i36.ShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          currentShoppingListItemStateToSet:
              args.currentShoppingListItemStateToSet,
        ),
      );
    },
    ShoppingListItemPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i37.ShoppingListItemPage(),
      );
    },
    ShoppingListItemChangeUserPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i38.ShoppingListItemChangeUserPage(),
      );
    },
    ChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatPageRouteArgs>(
          orElse: () => const ChatPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i39.ChatPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatInfoPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatInfoPageRouteArgs>(
          orElse: () => const ChatInfoPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i40.ChatInfoPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    ChatChangeChatUsernamePageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i41.ChatChangeChatUsernamePage(),
        fullscreenDialog: true,
      );
    },
    ChatFuturePrivateEventsPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i42.ChatFuturePrivateEventsPage(),
      );
    },
    ChatAddUserPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatAddUserPageRouteArgs>(
          orElse: () => const ChatAddUserPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i43.ChatAddUserPage(
          groupchatId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabPageRouteArgs>(
          orElse: () => const PrivateEventTabPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i44.PrivateEventTabPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventUpdateLocationPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i45.PrivateEventUpdateLocationPage(),
      );
    },
    PrivateEventInviteUserPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i46.PrivateEventInviteUserPage(),
      );
    },
    PrivateEventCreateShoppingListItemPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<PrivateEventCreateShoppingListItemPageRouteArgs>(
              orElse: () =>
                  const PrivateEventCreateShoppingListItemPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i47.PrivateEventCreateShoppingListItemPage(
          key: args.key,
          privateEventId: pathParams.getString('id'),
        ),
      );
    },
    PrivateEventShoppingListItemWrapperPageRoute.name: (routeData) {
      final args =
          routeData.argsAs<PrivateEventShoppingListItemWrapperPageRouteArgs>();
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i48.PrivateEventShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemStateToSet: args.shoppingListItemStateToSet,
          setCurrentPrivateEvent: args.setCurrentPrivateEvent,
        ),
      );
    },
    PrivateEventTabInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabInfoRouteArgs>(
          orElse: () => const PrivateEventTabInfoRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i49.PrivateEventTabInfo(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabChatRouteArgs>(
          orElse: () => const PrivateEventTabChatRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i50.PrivateEventTabChat(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventTabUserListRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i51.PrivateEventTabUserList(),
      );
    },
    PrivateEventTabShoppingListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PrivateEventTabShoppingListRouteArgs>(
          orElse: () => const PrivateEventTabShoppingListRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i52.PrivateEventTabShoppingList(
          privateEventId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    PrivateEventShoppingListItemPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i53.PrivateEventShoppingListItemPage(),
      );
    },
    PrivateEventShoppingListItemChangeUserPageRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i54.PrivateEventShoppingListItemChangeUserPage(),
      );
    },
    ProfileChatPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileChatPageRouteArgs>(
          orElse: () => const ProfileChatPageRouteArgs());
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i55.ProfileChatPage(
          userId: pathParams.getString('id'),
          key: args.key,
        ),
      );
    },
    NewGroupchatDetailsTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i56.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatSelectUserTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i57.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventDetailsTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i58.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventTypeTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i59.NewPrivateEventTypeTab(),
      );
    },
    NewPrivateEventSearchTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i60.NewPrivateEventSearchTab(),
      );
    },
    NewPrivateEventDateTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i61.NewPrivateEventDateTab(),
      );
    },
    NewPrivateEventLocationTabRoute.name: (routeData) {
      return _i63.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i62.NewPrivateEventLocationTab(),
      );
    },
  };

  @override
  List<_i63.RouteConfig> get routes => [
        _i63.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
          guards: [authPagesGuard],
        ),
        _i63.RouteConfig(
          ResetPasswordPageRoute.name,
          path: '/reset-password-page',
          guards: [authPagesGuard],
        ),
        _i63.RouteConfig(
          RegisterPageRoute.name,
          path: '/register-page',
          guards: [authPagesGuard],
        ),
        _i63.RouteConfig(
          AuthorizedPageRoute.name,
          path: '/',
          children: [
            _i63.RouteConfig(
              VerifyEmailPageRoute.name,
              path: 'verify-email-page',
              parent: AuthorizedPageRoute.name,
              guards: [verifyEmailPageGuard],
            ),
            _i63.RouteConfig(
              CreateUserPageRoute.name,
              path: 'create-user-page',
              parent: AuthorizedPageRoute.name,
              guards: [createUserPageGuard],
            ),
            _i63.RouteConfig(
              BlocInitPageRoute.name,
              path: '',
              parent: AuthorizedPageRoute.name,
              guards: [authGuard],
              children: [
                _i63.RouteConfig(
                  HomePageRoute.name,
                  path: '',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      '#redirect',
                      path: '',
                      parent: HomePageRoute.name,
                      redirectTo: 'chats',
                      fullMatch: true,
                    ),
                    _i63.RouteConfig(
                      HomeChatPageRoute.name,
                      path: 'chats',
                      parent: HomePageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      HomeEventPageRoute.name,
                      path: 'events',
                      parent: HomePageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      HomeMapPageRoute.name,
                      path: 'map',
                      parent: HomePageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      HomeSearchPageRoute.name,
                      path: 'search',
                      parent: HomePageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      HomeProfilePageRoute.name,
                      path: 'current-profile/:id',
                      parent: HomePageRoute.name,
                      guards: [authGuard],
                      children: [
                        _i63.RouteConfig(
                          ProfilePageRoute.name,
                          path: '',
                          parent: HomeProfilePageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          ProfileUserRelationsTabPageRoute.name,
                          path: 'user-relations',
                          parent: HomeProfilePageRoute.name,
                          guards: [authGuard],
                          children: [
                            _i63.RouteConfig(
                              ProfileFollowerTabRoute.name,
                              path: 'follower',
                              parent: ProfileUserRelationsTabPageRoute.name,
                              guards: [authGuard],
                            ),
                            _i63.RouteConfig(
                              ProfileFollowedTabRoute.name,
                              path: 'followed',
                              parent: ProfileUserRelationsTabPageRoute.name,
                              guards: [authGuard],
                            ),
                            _i63.RouteConfig(
                              ProfileFollowRequestsTabRoute.name,
                              path: 'follow-requests',
                              parent: ProfileUserRelationsTabPageRoute.name,
                              guards: [authGuard],
                            ),
                          ],
                        ),
                        _i63.RouteConfig(
                          '*#redirect',
                          path: '*',
                          parent: HomeProfilePageRoute.name,
                          redirectTo: '',
                          fullMatch: true,
                        ),
                      ],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: HomePageRoute.name,
                      redirectTo: 'chats',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  SettingsPageRoute.name,
                  path: 'settings',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  ThemeModePageRoute.name,
                  path: 'settings/theme',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  UpdatePasswordPageRoute.name,
                  path: 'settings/update-password',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  SettingsInfoPageRoute.name,
                  path: 'settings/info',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  RightOnInsightPageRoute.name,
                  path: 'settings/info/right-on-insight',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  RightOnDeletionPageRoute.name,
                  path: 'settings/info/right-on-deletion',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  ImprintPageRoute.name,
                  path: 'settings/info/imprint',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  SettingsPrivacyPageRoute.name,
                  path: 'settings/privacy',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  FutureEventsPageRoute.name,
                  path: 'future-events',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  PastEventsPageRoute.name,
                  path: 'past-events',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                ),
                _i63.RouteConfig(
                  ShoppingListWrapperPageRoute.name,
                  path: 'shopping-list',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      ShoppingListPageRoute.name,
                      path: '',
                      parent: ShoppingListWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ShoppingListItemWrapperPageRoute.name,
                      path: ':shoppingListItemId',
                      parent: ShoppingListWrapperPageRoute.name,
                      guards: [authGuard],
                      children: [
                        _i63.RouteConfig(
                          ShoppingListItemPageRoute.name,
                          path: '',
                          parent: ShoppingListItemWrapperPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          ShoppingListItemChangeUserPageRoute.name,
                          path: 'change-user-to-buy-item',
                          parent: ShoppingListItemWrapperPageRoute.name,
                          guards: [authGuard],
                        ),
                      ],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ShoppingListWrapperPageRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  ChatPageWrapperRoute.name,
                  path: 'groupchat/:id',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      ChatPageRoute.name,
                      path: '',
                      parent: ChatPageWrapperRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ChatInfoPageRoute.name,
                      path: 'info',
                      parent: ChatPageWrapperRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ChatChangeChatUsernamePageRoute.name,
                      path: 'change-chat-username',
                      parent: ChatPageWrapperRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ChatFuturePrivateEventsPageRoute.name,
                      path: 'private-events',
                      parent: ChatPageWrapperRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ChatAddUserPageRoute.name,
                      path: 'add-user',
                      parent: ChatPageWrapperRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ChatPageWrapperRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  PrivateEventWrapperPageRoute.name,
                  path: 'private-event/:id',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      PrivateEventTabPageRoute.name,
                      path: '',
                      parent: PrivateEventWrapperPageRoute.name,
                      guards: [authGuard],
                      children: [
                        _i63.RouteConfig(
                          '#redirect',
                          path: '',
                          parent: PrivateEventTabPageRoute.name,
                          redirectTo: 'info',
                          fullMatch: true,
                        ),
                        _i63.RouteConfig(
                          PrivateEventTabInfoRoute.name,
                          path: 'info',
                          parent: PrivateEventTabPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          PrivateEventTabChatRoute.name,
                          path: 'chat',
                          parent: PrivateEventTabPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          PrivateEventTabUserListRoute.name,
                          path: 'users',
                          parent: PrivateEventTabPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          PrivateEventTabShoppingListRoute.name,
                          path: 'shopping-list',
                          parent: PrivateEventTabPageRoute.name,
                          guards: [authGuard],
                        ),
                      ],
                    ),
                    _i63.RouteConfig(
                      PrivateEventUpdateLocationPageRoute.name,
                      path: 'update-location',
                      parent: PrivateEventWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      PrivateEventInviteUserPageRoute.name,
                      path: 'invite',
                      parent: PrivateEventWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      PrivateEventCreateShoppingListItemPageRoute.name,
                      path: 'create-shopping-list-item',
                      parent: PrivateEventWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      PrivateEventShoppingListItemWrapperPageRoute.name,
                      path: 'shopping-list/:shoppingListItemId',
                      parent: PrivateEventWrapperPageRoute.name,
                      guards: [authGuard],
                      children: [
                        _i63.RouteConfig(
                          PrivateEventShoppingListItemPageRoute.name,
                          path: '',
                          parent:
                              PrivateEventShoppingListItemWrapperPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          PrivateEventShoppingListItemChangeUserPageRoute.name,
                          path: 'change-user-to-buy-item',
                          parent:
                              PrivateEventShoppingListItemWrapperPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          '*#redirect',
                          path: '*',
                          parent:
                              PrivateEventShoppingListItemWrapperPageRoute.name,
                          redirectTo: '',
                          fullMatch: true,
                        ),
                      ],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: PrivateEventWrapperPageRoute.name,
                      redirectTo: 'info',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  ProfileWrapperPageRoute.name,
                  path: 'profile/:id',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      ProfilePageRoute.name,
                      path: '',
                      parent: ProfileWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ProfileChatPageRoute.name,
                      path: 'chat',
                      parent: ProfileWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      ProfileUserRelationsTabPageRoute.name,
                      path: 'user-relations',
                      parent: ProfileWrapperPageRoute.name,
                      guards: [authGuard],
                      children: [
                        _i63.RouteConfig(
                          ProfileFollowerTabRoute.name,
                          path: 'follower',
                          parent: ProfileUserRelationsTabPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          ProfileFollowedTabRoute.name,
                          path: 'followed',
                          parent: ProfileUserRelationsTabPageRoute.name,
                          guards: [authGuard],
                        ),
                        _i63.RouteConfig(
                          ProfileFollowRequestsTabRoute.name,
                          path: 'follow-requests',
                          parent: ProfileUserRelationsTabPageRoute.name,
                          guards: [authGuard],
                        ),
                      ],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: ProfileWrapperPageRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  NewGroupchatWrapperPageRoute.name,
                  path: 'new-groupchat',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      NewGroupchatDetailsTabRoute.name,
                      path: '',
                      parent: NewGroupchatWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      NewGroupchatSelectUserTabRoute.name,
                      path: 'users',
                      parent: NewGroupchatWrapperPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: NewGroupchatWrapperPageRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
                _i63.RouteConfig(
                  NewPrivateEventPageRoute.name,
                  path: 'new-private-event',
                  parent: BlocInitPageRoute.name,
                  guards: [authGuard],
                  children: [
                    _i63.RouteConfig(
                      NewPrivateEventDetailsTabRoute.name,
                      path: '',
                      parent: NewPrivateEventPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      NewPrivateEventTypeTabRoute.name,
                      path: 'type',
                      parent: NewPrivateEventPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      NewPrivateEventSearchTabRoute.name,
                      path: 'search',
                      parent: NewPrivateEventPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      NewPrivateEventDateTabRoute.name,
                      path: 'date',
                      parent: NewPrivateEventPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      NewPrivateEventLocationTabRoute.name,
                      path: 'location',
                      parent: NewPrivateEventPageRoute.name,
                      guards: [authGuard],
                    ),
                    _i63.RouteConfig(
                      '*#redirect',
                      path: '*',
                      parent: NewPrivateEventPageRoute.name,
                      redirectTo: '',
                      fullMatch: true,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        _i63.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/chats',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.LoginPage]
class LoginPageRoute extends _i63.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i2.ResetPasswordPage]
class ResetPasswordPageRoute
    extends _i63.PageRouteInfo<ResetPasswordPageRouteArgs> {
  ResetPasswordPageRoute({
    _i69.Key? key,
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

  final _i69.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordPageRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterPageRoute extends _i63.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(
          RegisterPageRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i4.AuthorizedPage]
class AuthorizedPageRoute extends _i63.PageRouteInfo<void> {
  const AuthorizedPageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          AuthorizedPageRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'AuthorizedPageRoute';
}

/// generated route for
/// [_i5.VerifyEmailPage]
class VerifyEmailPageRoute extends _i63.PageRouteInfo<void> {
  const VerifyEmailPageRoute()
      : super(
          VerifyEmailPageRoute.name,
          path: 'verify-email-page',
        );

  static const String name = 'VerifyEmailPageRoute';
}

/// generated route for
/// [_i6.CreateUserPage]
class CreateUserPageRoute extends _i63.PageRouteInfo<void> {
  const CreateUserPageRoute()
      : super(
          CreateUserPageRoute.name,
          path: 'create-user-page',
        );

  static const String name = 'CreateUserPageRoute';
}

/// generated route for
/// [_i7.BlocInitPage]
class BlocInitPageRoute extends _i63.PageRouteInfo<void> {
  const BlocInitPageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          BlocInitPageRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'BlocInitPageRoute';
}

/// generated route for
/// [_i8.HomePage]
class HomePageRoute extends _i63.PageRouteInfo<void> {
  const HomePageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsPageRoute extends _i63.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(
          SettingsPageRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i10.ThemeModePage]
class ThemeModePageRoute extends _i63.PageRouteInfo<void> {
  const ThemeModePageRoute()
      : super(
          ThemeModePageRoute.name,
          path: 'settings/theme',
        );

  static const String name = 'ThemeModePageRoute';
}

/// generated route for
/// [_i11.UpdatePasswordPage]
class UpdatePasswordPageRoute extends _i63.PageRouteInfo<void> {
  const UpdatePasswordPageRoute()
      : super(
          UpdatePasswordPageRoute.name,
          path: 'settings/update-password',
        );

  static const String name = 'UpdatePasswordPageRoute';
}

/// generated route for
/// [_i12.SettingsInfoPage]
class SettingsInfoPageRoute extends _i63.PageRouteInfo<void> {
  const SettingsInfoPageRoute()
      : super(
          SettingsInfoPageRoute.name,
          path: 'settings/info',
        );

  static const String name = 'SettingsInfoPageRoute';
}

/// generated route for
/// [_i13.RightOnInsightPage]
class RightOnInsightPageRoute extends _i63.PageRouteInfo<void> {
  const RightOnInsightPageRoute()
      : super(
          RightOnInsightPageRoute.name,
          path: 'settings/info/right-on-insight',
        );

  static const String name = 'RightOnInsightPageRoute';
}

/// generated route for
/// [_i14.RightOnDeletionPage]
class RightOnDeletionPageRoute extends _i63.PageRouteInfo<void> {
  const RightOnDeletionPageRoute()
      : super(
          RightOnDeletionPageRoute.name,
          path: 'settings/info/right-on-deletion',
        );

  static const String name = 'RightOnDeletionPageRoute';
}

/// generated route for
/// [_i15.ImprintPage]
class ImprintPageRoute extends _i63.PageRouteInfo<void> {
  const ImprintPageRoute()
      : super(
          ImprintPageRoute.name,
          path: 'settings/info/imprint',
        );

  static const String name = 'ImprintPageRoute';
}

/// generated route for
/// [_i16.SettingsPrivacyPage]
class SettingsPrivacyPageRoute extends _i63.PageRouteInfo<void> {
  const SettingsPrivacyPageRoute()
      : super(
          SettingsPrivacyPageRoute.name,
          path: 'settings/privacy',
        );

  static const String name = 'SettingsPrivacyPageRoute';
}

/// generated route for
/// [_i17.FutureEventsPage]
class FutureEventsPageRoute extends _i63.PageRouteInfo<void> {
  const FutureEventsPageRoute()
      : super(
          FutureEventsPageRoute.name,
          path: 'future-events',
        );

  static const String name = 'FutureEventsPageRoute';
}

/// generated route for
/// [_i18.PastEventsPage]
class PastEventsPageRoute extends _i63.PageRouteInfo<void> {
  const PastEventsPageRoute()
      : super(
          PastEventsPageRoute.name,
          path: 'past-events',
        );

  static const String name = 'PastEventsPageRoute';
}

/// generated route for
/// [_i19.ShoppingListWrapperPage]
class ShoppingListWrapperPageRoute extends _i63.PageRouteInfo<void> {
  const ShoppingListWrapperPageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          ShoppingListWrapperPageRoute.name,
          path: 'shopping-list',
          initialChildren: children,
        );

  static const String name = 'ShoppingListWrapperPageRoute';
}

/// generated route for
/// [_i20.ChatPageWrapper]
class ChatPageWrapperRoute
    extends _i63.PageRouteInfo<ChatPageWrapperRouteArgs> {
  ChatPageWrapperRoute({
    _i69.Key? key,
    required String groupchatId,
    _i70.GroupchatEntity? groupchat,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          ChatPageWrapperRoute.name,
          path: 'groupchat/:id',
          args: ChatPageWrapperRouteArgs(
            key: key,
            groupchatId: groupchatId,
            groupchat: groupchat,
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
    this.groupchat,
  });

  final _i69.Key? key;

  final String groupchatId;

  final _i70.GroupchatEntity? groupchat;

  @override
  String toString() {
    return 'ChatPageWrapperRouteArgs{key: $key, groupchatId: $groupchatId, groupchat: $groupchat}';
  }
}

/// generated route for
/// [_i21.PrivateEventWrapperPage]
class PrivateEventWrapperPageRoute
    extends _i63.PageRouteInfo<PrivateEventWrapperPageRouteArgs> {
  PrivateEventWrapperPageRoute({
    required String privateEventId,
    _i71.CurrentPrivateEventState? privateEventStateToSet,
    _i69.Key? key,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          PrivateEventWrapperPageRoute.name,
          path: 'private-event/:id',
          args: PrivateEventWrapperPageRouteArgs(
            privateEventId: privateEventId,
            privateEventStateToSet: privateEventStateToSet,
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
    this.privateEventStateToSet,
    this.key,
  });

  final String privateEventId;

  final _i71.CurrentPrivateEventState? privateEventStateToSet;

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventWrapperPageRouteArgs{privateEventId: $privateEventId, privateEventStateToSet: $privateEventStateToSet, key: $key}';
  }
}

/// generated route for
/// [_i22.ProfileWrapperPage]
class ProfileWrapperPageRoute
    extends _i63.PageRouteInfo<ProfileWrapperPageRouteArgs> {
  ProfileWrapperPageRoute({
    _i69.Key? key,
    _i72.UserEntity? user,
    required String userId,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          ProfileWrapperPageRoute.name,
          path: 'profile/:id',
          args: ProfileWrapperPageRouteArgs(
            key: key,
            user: user,
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
    this.user,
    required this.userId,
  });

  final _i69.Key? key;

  final _i72.UserEntity? user;

  final String userId;

  @override
  String toString() {
    return 'ProfileWrapperPageRouteArgs{key: $key, user: $user, userId: $userId}';
  }
}

/// generated route for
/// [_i23.NewGroupchatWrapperPage]
class NewGroupchatWrapperPageRoute extends _i63.PageRouteInfo<void> {
  const NewGroupchatWrapperPageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperPageRoute.name,
          path: 'new-groupchat',
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperPageRoute';
}

/// generated route for
/// [_i24.NewPrivateEventPage]
class NewPrivateEventPageRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventPageRoute({List<_i63.PageRouteInfo>? children})
      : super(
          NewPrivateEventPageRoute.name,
          path: 'new-private-event',
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPageRoute';
}

/// generated route for
/// [_i25.HomeChatPage]
class HomeChatPageRoute extends _i63.PageRouteInfo<void> {
  const HomeChatPageRoute()
      : super(
          HomeChatPageRoute.name,
          path: 'chats',
        );

  static const String name = 'HomeChatPageRoute';
}

/// generated route for
/// [_i26.HomeEventPage]
class HomeEventPageRoute extends _i63.PageRouteInfo<void> {
  const HomeEventPageRoute()
      : super(
          HomeEventPageRoute.name,
          path: 'events',
        );

  static const String name = 'HomeEventPageRoute';
}

/// generated route for
/// [_i27.HomeMapPage]
class HomeMapPageRoute extends _i63.PageRouteInfo<void> {
  const HomeMapPageRoute()
      : super(
          HomeMapPageRoute.name,
          path: 'map',
        );

  static const String name = 'HomeMapPageRoute';
}

/// generated route for
/// [_i28.HomeSearchPage]
class HomeSearchPageRoute extends _i63.PageRouteInfo<void> {
  const HomeSearchPageRoute()
      : super(
          HomeSearchPageRoute.name,
          path: 'search',
        );

  static const String name = 'HomeSearchPageRoute';
}

/// generated route for
/// [_i29.HomeProfilePage]
class HomeProfilePageRoute
    extends _i63.PageRouteInfo<HomeProfilePageRouteArgs> {
  HomeProfilePageRoute({
    _i69.Key? key,
    String? userId,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          HomeProfilePageRoute.name,
          path: 'current-profile/:id',
          args: HomeProfilePageRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'HomeProfilePageRoute';
}

class HomeProfilePageRouteArgs {
  const HomeProfilePageRouteArgs({
    this.key,
    this.userId,
  });

  final _i69.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'HomeProfilePageRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i30.ProfilePage]
class ProfilePageRoute extends _i63.PageRouteInfo<ProfilePageRouteArgs> {
  ProfilePageRoute({_i69.Key? key})
      : super(
          ProfilePageRoute.name,
          path: '',
          args: ProfilePageRouteArgs(key: key),
        );

  static const String name = 'ProfilePageRoute';
}

class ProfilePageRouteArgs {
  const ProfilePageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'ProfilePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i31.ProfileUserRelationsTabPage]
class ProfileUserRelationsTabPageRoute
    extends _i63.PageRouteInfo<ProfileUserRelationsTabPageRouteArgs> {
  ProfileUserRelationsTabPageRoute({
    _i69.Key? key,
    List<_i63.PageRouteInfo>? children,
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

  final _i69.Key? key;

  @override
  String toString() {
    return 'ProfileUserRelationsTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i32.ProfileFollowerTab]
class ProfileFollowerTabRoute extends _i63.PageRouteInfo<void> {
  const ProfileFollowerTabRoute()
      : super(
          ProfileFollowerTabRoute.name,
          path: 'follower',
        );

  static const String name = 'ProfileFollowerTabRoute';
}

/// generated route for
/// [_i33.ProfileFollowedTab]
class ProfileFollowedTabRoute extends _i63.PageRouteInfo<void> {
  const ProfileFollowedTabRoute()
      : super(
          ProfileFollowedTabRoute.name,
          path: 'followed',
        );

  static const String name = 'ProfileFollowedTabRoute';
}

/// generated route for
/// [_i34.ProfileFollowRequestsTab]
class ProfileFollowRequestsTabRoute extends _i63.PageRouteInfo<void> {
  const ProfileFollowRequestsTabRoute()
      : super(
          ProfileFollowRequestsTabRoute.name,
          path: 'follow-requests',
        );

  static const String name = 'ProfileFollowRequestsTabRoute';
}

/// generated route for
/// [_i35.ShoppingListPage]
class ShoppingListPageRoute extends _i63.PageRouteInfo<void> {
  const ShoppingListPageRoute()
      : super(
          ShoppingListPageRoute.name,
          path: '',
        );

  static const String name = 'ShoppingListPageRoute';
}

/// generated route for
/// [_i36.ShoppingListItemWrapperPage]
class ShoppingListItemWrapperPageRoute
    extends _i63.PageRouteInfo<ShoppingListItemWrapperPageRouteArgs> {
  ShoppingListItemWrapperPageRoute({
    _i69.Key? key,
    required String shoppingListItemId,
    required _i73.CurrentShoppingListItemState
        currentShoppingListItemStateToSet,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          ShoppingListItemWrapperPageRoute.name,
          path: ':shoppingListItemId',
          args: ShoppingListItemWrapperPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            currentShoppingListItemStateToSet:
                currentShoppingListItemStateToSet,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemWrapperPageRoute';
}

class ShoppingListItemWrapperPageRouteArgs {
  const ShoppingListItemWrapperPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.currentShoppingListItemStateToSet,
  });

  final _i69.Key? key;

  final String shoppingListItemId;

  final _i73.CurrentShoppingListItemState currentShoppingListItemStateToSet;

  @override
  String toString() {
    return 'ShoppingListItemWrapperPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, currentShoppingListItemStateToSet: $currentShoppingListItemStateToSet}';
  }
}

/// generated route for
/// [_i37.ShoppingListItemPage]
class ShoppingListItemPageRoute extends _i63.PageRouteInfo<void> {
  const ShoppingListItemPageRoute()
      : super(
          ShoppingListItemPageRoute.name,
          path: '',
        );

  static const String name = 'ShoppingListItemPageRoute';
}

/// generated route for
/// [_i38.ShoppingListItemChangeUserPage]
class ShoppingListItemChangeUserPageRoute extends _i63.PageRouteInfo<void> {
  const ShoppingListItemChangeUserPageRoute()
      : super(
          ShoppingListItemChangeUserPageRoute.name,
          path: 'change-user-to-buy-item',
        );

  static const String name = 'ShoppingListItemChangeUserPageRoute';
}

/// generated route for
/// [_i39.ChatPage]
class ChatPageRoute extends _i63.PageRouteInfo<ChatPageRouteArgs> {
  ChatPageRoute({_i69.Key? key})
      : super(
          ChatPageRoute.name,
          path: '',
          args: ChatPageRouteArgs(key: key),
        );

  static const String name = 'ChatPageRoute';
}

class ChatPageRouteArgs {
  const ChatPageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'ChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i40.ChatInfoPage]
class ChatInfoPageRoute extends _i63.PageRouteInfo<ChatInfoPageRouteArgs> {
  ChatInfoPageRoute({_i69.Key? key})
      : super(
          ChatInfoPageRoute.name,
          path: 'info',
          args: ChatInfoPageRouteArgs(key: key),
        );

  static const String name = 'ChatInfoPageRoute';
}

class ChatInfoPageRouteArgs {
  const ChatInfoPageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'ChatInfoPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i41.ChatChangeChatUsernamePage]
class ChatChangeChatUsernamePageRoute extends _i63.PageRouteInfo<void> {
  const ChatChangeChatUsernamePageRoute()
      : super(
          ChatChangeChatUsernamePageRoute.name,
          path: 'change-chat-username',
        );

  static const String name = 'ChatChangeChatUsernamePageRoute';
}

/// generated route for
/// [_i42.ChatFuturePrivateEventsPage]
class ChatFuturePrivateEventsPageRoute extends _i63.PageRouteInfo<void> {
  const ChatFuturePrivateEventsPageRoute()
      : super(
          ChatFuturePrivateEventsPageRoute.name,
          path: 'private-events',
        );

  static const String name = 'ChatFuturePrivateEventsPageRoute';
}

/// generated route for
/// [_i43.ChatAddUserPage]
class ChatAddUserPageRoute
    extends _i63.PageRouteInfo<ChatAddUserPageRouteArgs> {
  ChatAddUserPageRoute({_i69.Key? key})
      : super(
          ChatAddUserPageRoute.name,
          path: 'add-user',
          args: ChatAddUserPageRouteArgs(key: key),
        );

  static const String name = 'ChatAddUserPageRoute';
}

class ChatAddUserPageRouteArgs {
  const ChatAddUserPageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'ChatAddUserPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i44.PrivateEventTabPage]
class PrivateEventTabPageRoute
    extends _i63.PageRouteInfo<PrivateEventTabPageRouteArgs> {
  PrivateEventTabPageRoute({
    _i69.Key? key,
    List<_i63.PageRouteInfo>? children,
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

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i45.PrivateEventUpdateLocationPage]
class PrivateEventUpdateLocationPageRoute extends _i63.PageRouteInfo<void> {
  const PrivateEventUpdateLocationPageRoute()
      : super(
          PrivateEventUpdateLocationPageRoute.name,
          path: 'update-location',
        );

  static const String name = 'PrivateEventUpdateLocationPageRoute';
}

/// generated route for
/// [_i46.PrivateEventInviteUserPage]
class PrivateEventInviteUserPageRoute extends _i63.PageRouteInfo<void> {
  const PrivateEventInviteUserPageRoute()
      : super(
          PrivateEventInviteUserPageRoute.name,
          path: 'invite',
        );

  static const String name = 'PrivateEventInviteUserPageRoute';
}

/// generated route for
/// [_i47.PrivateEventCreateShoppingListItemPage]
class PrivateEventCreateShoppingListItemPageRoute extends _i63
    .PageRouteInfo<PrivateEventCreateShoppingListItemPageRouteArgs> {
  PrivateEventCreateShoppingListItemPageRoute({_i69.Key? key})
      : super(
          PrivateEventCreateShoppingListItemPageRoute.name,
          path: 'create-shopping-list-item',
          args: PrivateEventCreateShoppingListItemPageRouteArgs(key: key),
        );

  static const String name = 'PrivateEventCreateShoppingListItemPageRoute';
}

class PrivateEventCreateShoppingListItemPageRouteArgs {
  const PrivateEventCreateShoppingListItemPageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventCreateShoppingListItemPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i48.PrivateEventShoppingListItemWrapperPage]
class PrivateEventShoppingListItemWrapperPageRoute extends _i63
    .PageRouteInfo<PrivateEventShoppingListItemWrapperPageRouteArgs> {
  PrivateEventShoppingListItemWrapperPageRoute({
    _i69.Key? key,
    required String shoppingListItemId,
    required _i73.CurrentShoppingListItemState shoppingListItemStateToSet,
    bool setCurrentPrivateEvent = false,
    List<_i63.PageRouteInfo>? children,
  }) : super(
          PrivateEventShoppingListItemWrapperPageRoute.name,
          path: 'shopping-list/:shoppingListItemId',
          args: PrivateEventShoppingListItemWrapperPageRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemStateToSet: shoppingListItemStateToSet,
            setCurrentPrivateEvent: setCurrentPrivateEvent,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
          initialChildren: children,
        );

  static const String name = 'PrivateEventShoppingListItemWrapperPageRoute';
}

class PrivateEventShoppingListItemWrapperPageRouteArgs {
  const PrivateEventShoppingListItemWrapperPageRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.setCurrentPrivateEvent = false,
  });

  final _i69.Key? key;

  final String shoppingListItemId;

  final _i73.CurrentShoppingListItemState shoppingListItemStateToSet;

  final bool setCurrentPrivateEvent;

  @override
  String toString() {
    return 'PrivateEventShoppingListItemWrapperPageRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemStateToSet: $shoppingListItemStateToSet, setCurrentPrivateEvent: $setCurrentPrivateEvent}';
  }
}

/// generated route for
/// [_i49.PrivateEventTabInfo]
class PrivateEventTabInfoRoute
    extends _i63.PageRouteInfo<PrivateEventTabInfoRouteArgs> {
  PrivateEventTabInfoRoute({_i69.Key? key})
      : super(
          PrivateEventTabInfoRoute.name,
          path: 'info',
          args: PrivateEventTabInfoRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabInfoRoute';
}

class PrivateEventTabInfoRouteArgs {
  const PrivateEventTabInfoRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabInfoRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i50.PrivateEventTabChat]
class PrivateEventTabChatRoute
    extends _i63.PageRouteInfo<PrivateEventTabChatRouteArgs> {
  PrivateEventTabChatRoute({_i69.Key? key})
      : super(
          PrivateEventTabChatRoute.name,
          path: 'chat',
          args: PrivateEventTabChatRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabChatRoute';
}

class PrivateEventTabChatRouteArgs {
  const PrivateEventTabChatRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabChatRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i51.PrivateEventTabUserList]
class PrivateEventTabUserListRoute extends _i63.PageRouteInfo<void> {
  const PrivateEventTabUserListRoute()
      : super(
          PrivateEventTabUserListRoute.name,
          path: 'users',
        );

  static const String name = 'PrivateEventTabUserListRoute';
}

/// generated route for
/// [_i52.PrivateEventTabShoppingList]
class PrivateEventTabShoppingListRoute
    extends _i63.PageRouteInfo<PrivateEventTabShoppingListRouteArgs> {
  PrivateEventTabShoppingListRoute({_i69.Key? key})
      : super(
          PrivateEventTabShoppingListRoute.name,
          path: 'shopping-list',
          args: PrivateEventTabShoppingListRouteArgs(key: key),
        );

  static const String name = 'PrivateEventTabShoppingListRoute';
}

class PrivateEventTabShoppingListRouteArgs {
  const PrivateEventTabShoppingListRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'PrivateEventTabShoppingListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i53.PrivateEventShoppingListItemPage]
class PrivateEventShoppingListItemPageRoute extends _i63.PageRouteInfo<void> {
  const PrivateEventShoppingListItemPageRoute()
      : super(
          PrivateEventShoppingListItemPageRoute.name,
          path: '',
        );

  static const String name = 'PrivateEventShoppingListItemPageRoute';
}

/// generated route for
/// [_i54.PrivateEventShoppingListItemChangeUserPage]
class PrivateEventShoppingListItemChangeUserPageRoute
    extends _i63.PageRouteInfo<void> {
  const PrivateEventShoppingListItemChangeUserPageRoute()
      : super(
          PrivateEventShoppingListItemChangeUserPageRoute.name,
          path: 'change-user-to-buy-item',
        );

  static const String name = 'PrivateEventShoppingListItemChangeUserPageRoute';
}

/// generated route for
/// [_i55.ProfileChatPage]
class ProfileChatPageRoute
    extends _i63.PageRouteInfo<ProfileChatPageRouteArgs> {
  ProfileChatPageRoute({_i69.Key? key})
      : super(
          ProfileChatPageRoute.name,
          path: 'chat',
          args: ProfileChatPageRouteArgs(key: key),
        );

  static const String name = 'ProfileChatPageRoute';
}

class ProfileChatPageRouteArgs {
  const ProfileChatPageRouteArgs({this.key});

  final _i69.Key? key;

  @override
  String toString() {
    return 'ProfileChatPageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i56.NewGroupchatDetailsTab]
class NewGroupchatDetailsTabRoute extends _i63.PageRouteInfo<void> {
  const NewGroupchatDetailsTabRoute()
      : super(
          NewGroupchatDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewGroupchatDetailsTabRoute';
}

/// generated route for
/// [_i57.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTabRoute extends _i63.PageRouteInfo<void> {
  const NewGroupchatSelectUserTabRoute()
      : super(
          NewGroupchatSelectUserTabRoute.name,
          path: 'users',
        );

  static const String name = 'NewGroupchatSelectUserTabRoute';
}

/// generated route for
/// [_i58.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTabRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventDetailsTabRoute()
      : super(
          NewPrivateEventDetailsTabRoute.name,
          path: '',
        );

  static const String name = 'NewPrivateEventDetailsTabRoute';
}

/// generated route for
/// [_i59.NewPrivateEventTypeTab]
class NewPrivateEventTypeTabRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventTypeTabRoute()
      : super(
          NewPrivateEventTypeTabRoute.name,
          path: 'type',
        );

  static const String name = 'NewPrivateEventTypeTabRoute';
}

/// generated route for
/// [_i60.NewPrivateEventSearchTab]
class NewPrivateEventSearchTabRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventSearchTabRoute()
      : super(
          NewPrivateEventSearchTabRoute.name,
          path: 'search',
        );

  static const String name = 'NewPrivateEventSearchTabRoute';
}

/// generated route for
/// [_i61.NewPrivateEventDateTab]
class NewPrivateEventDateTabRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventDateTabRoute()
      : super(
          NewPrivateEventDateTabRoute.name,
          path: 'date',
        );

  static const String name = 'NewPrivateEventDateTabRoute';
}

/// generated route for
/// [_i62.NewPrivateEventLocationTab]
class NewPrivateEventLocationTabRoute extends _i63.PageRouteInfo<void> {
  const NewPrivateEventLocationTabRoute()
      : super(
          NewPrivateEventLocationTabRoute.name,
          path: 'location',
        );

  static const String name = 'NewPrivateEventLocationTabRoute';
}
