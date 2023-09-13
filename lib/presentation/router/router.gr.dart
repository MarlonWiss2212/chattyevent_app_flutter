// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i75;
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart'
    as _i76;
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart'
    as _i78;
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart'
    as _i80;
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart'
    as _i81;
import 'package:chattyevent_app_flutter/presentation/screens/authorized_page/authorized_page.dart'
    as _i1;
import 'package:chattyevent_app_flutter/presentation/screens/bloc_init_page.dart'
    as _i2;
import 'package:chattyevent_app_flutter/presentation/screens/create_user_page.dart'
    as _i3;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/event_create_shopping_list_item_page.dart'
    as _i4;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/event_invite_user_page.dart'
    as _i5;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/event_update_loaction_page.dart'
    as _i6;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/event_update_permissions_page.dart'
    as _i7;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/event_wrapper_page.dart'
    as _i8;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/shopping_list_item_page/event_shopping_list_change_user_page.dart'
    as _i9;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/shopping_list_item_page/event_shopping_list_item_page.dart'
    as _i10;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/shopping_list_item_page/event_shopping_list_item_wrapper_page.dart'
    as _i11;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/tab_page/event_tab_page.dart'
    as _i12;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/tab_page/pages/event_tab_chat.dart'
    as _i13;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/tab_page/pages/event_tab_info.dart'
    as _i14;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/tab_page/pages/event_tab_shopping_list.dart'
    as _i15;
import 'package:chattyevent_app_flutter/presentation/screens/event_page/tab_page/pages/event_tab_user_list.dart'
    as _i16;
import 'package:chattyevent_app_flutter/presentation/screens/future_events_page/future_events_page.dart'
    as _i17;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_add_user_page.dart'
    as _i18;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_change_chat_username_page.dart'
    as _i19;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_future_private_events_page.dart'
    as _i20;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_info_page.dart'
    as _i21;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page.dart'
    as _i22;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_page_wrapper.dart'
    as _i23;
import 'package:chattyevent_app_flutter/presentation/screens/groupchat_page/groupchat_update_permissions_page.dart'
    as _i24;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart'
    as _i25;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart'
    as _i26;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_event_page.dart'
    as _i27;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_profile_page.dart'
    as _i28;
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_search_page.dart'
    as _i29;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_feature_introduction_pages/app_feature_introduction_pages_message_page.dart'
    as _i33;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_feature_introduction_pages/app_features_introduction_pages_groupchat_page.dart'
    as _i30;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_feature_introduction_pages/app_features_introduction_pages_private_event_page.dart'
    as _i31;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_feature_introduction_pages/app_features_introduction_pages_users_page.dart'
    as _i32;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_permission_introduction_pages/app_permission_introduction_pages_microphone_page.dart'
    as _i34;
import 'package:chattyevent_app_flutter/presentation/screens/introduction_pages/app_permission_introduction_pages/app_permission_introduction_pages_notification_page.dart'
    as _i35;
import 'package:chattyevent_app_flutter/presentation/screens/login_page.dart'
    as _i36;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/new_groupchat_wrapper_page.dart'
    as _i37;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_details_tab.dart'
    as _i38;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_permissions_tab.dart'
    as _i39;
import 'package:chattyevent_app_flutter/presentation/screens/new_groupchat/pages/new_groupchat_select_user_tab.dart'
    as _i40;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/new_private_event_page.dart'
    as _i41;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_date_tab.dart'
    as _i42;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_details_tab.dart'
    as _i43;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_location_tab.dart'
    as _i44;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_permissions_tab.dart'
    as _i45;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tab.dart'
    as _i46;
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_type_tab.dart'
    as _i47;
import 'package:chattyevent_app_flutter/presentation/screens/past_events_page/past_events_page.dart'
    as _i48;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_chat_page.dart'
    as _i49;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_page.dart'
    as _i50;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follow_requests_tab.dart'
    as _i53;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_followed_tab.dart'
    as _i51;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_follower_tab.dart'
    as _i52;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_user_relations_tabs/profile_user_relations_tab_page.dart'
    as _i54;
import 'package:chattyevent_app_flutter/presentation/screens/profile_page/profile_wrapper_page.dart'
    as _i55;
import 'package:chattyevent_app_flutter/presentation/screens/register_page.dart'
    as _i56;
import 'package:chattyevent_app_flutter/presentation/screens/reset_password_page.dart'
    as _i57;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_page.dart'
    as _i58;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/info_pages/right_on_deletion_page.dart'
    as _i59;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_page.dart'
    as _i60;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/calendar_watch_i_have_time_page.dart'
    as _i61;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/groupchat_add_me_page.dart'
    as _i62;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/private_event_add_me_page.dart'
    as _i63;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/update_birthdate_page.dart'
    as _i64;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/update_email_page.dart'
    as _i65;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/privacy_pages/update_password_page.dart'
    as _i66;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/pages/theme_mode_page.dart'
    as _i67;
import 'package:chattyevent_app_flutter/presentation/screens/settings_page/settings_page.dart'
    as _i68;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_change_user_page.dart'
    as _i69;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_page.dart'
    as _i70;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_item_page/shopping_list_item_wrapper_page.dart'
    as _i71;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_page.dart'
    as _i72;
import 'package:chattyevent_app_flutter/presentation/screens/shopping_list_page/shopping_list_wrapper_page.dart'
    as _i73;
import 'package:chattyevent_app_flutter/presentation/screens/verify_email_page.dart'
    as _i74;
import 'package:flutter/cupertino.dart' as _i79;
import 'package:flutter/material.dart' as _i77;

abstract class $AppRouter extends _i75.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i75.PageFactory> pagesMap = {
    AuthorizedRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthorizedPage(),
      );
    },
    BlocInitRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BlocInitPage(),
      );
    },
    CreateUserRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CreateUserPage(),
      );
    },
    EventCreateShoppingListItemRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EventCreateShoppingListItemPage(),
      );
    },
    EventInviteUserRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EventInviteUserPage(),
      );
    },
    EventUpdateLocationRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EventUpdateLocationPage(),
      );
    },
    EventUpdatePermissionsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.EventUpdatePermissionsPage(),
      );
    },
    EventWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventWrapperRouteArgs>(
          orElse: () =>
              EventWrapperRouteArgs(eventId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.EventWrapperPage(
          eventId: args.eventId,
          eventStateToSet: args.eventStateToSet,
          key: args.key,
        ),
      );
    },
    EventShoppingListItemChangeUserRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.EventShoppingListItemChangeUserPage(),
      );
    },
    EventShoppingListItemRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.EventShoppingListItemPage(),
      );
    },
    EventShoppingListItemWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<EventShoppingListItemWrapperRouteArgs>();
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.EventShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          shoppingListItemStateToSet: args.shoppingListItemStateToSet,
          setCurrentPrivateEvent: args.setCurrentPrivateEvent,
        ),
      );
    },
    EventTabRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventTabRouteArgs>(
          orElse: () => EventTabRouteArgs(eventId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.EventTabPage(
          key: args.key,
          eventId: args.eventId,
        ),
      );
    },
    EventTabChat.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EventTabChatArgs>(
          orElse: () => EventTabChatArgs(eventId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.EventTabChat(
          eventId: args.eventId,
          key: args.key,
        ),
      );
    },
    EventTabInfo.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.EventTabInfo(),
      );
    },
    EventTabShoppingList.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.EventTabShoppingList(),
      );
    },
    EventTabUserList.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.EventTabUserList(),
      );
    },
    FutureEventsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.FutureEventsPage(),
      );
    },
    GroupchatAddUserRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatAddUserRouteArgs>(
          orElse: () => GroupchatAddUserRouteArgs(
              groupchatId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.GroupchatAddUserPage(
          groupchatId: args.groupchatId,
          key: args.key,
        ),
      );
    },
    GroupchatChangeUsernameRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.GroupchatChangeUsernamePage(),
      );
    },
    GroupchatfutureEventsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.GroupchatfutureEventsPage(),
      );
    },
    GroupchatInfoRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GroupchatInfoRouteArgs>(
          orElse: () =>
              GroupchatInfoRouteArgs(groupchatId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.GroupchatInfoPage(
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
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.GroupchatPage(
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
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.GroupchatPageWrapper(
          key: args.key,
          groupchatId: args.groupchatId,
          groupchat: args.groupchat,
        ),
      );
    },
    GroupchatUpdatePermissionsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.GroupchatUpdatePermissionsPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.HomePage(),
      );
    },
    HomeChatRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.HomeChatPage(),
      );
    },
    HomeEventRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.HomeEventPage(),
      );
    },
    HomeProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeProfileRouteArgs>(
          orElse: () =>
              HomeProfileRouteArgs(userId: pathParams.optString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.HomeProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    HomeSearchRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.HomeSearchPage(),
      );
    },
    AppFeatureIntroductionRoutesGroupchatRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.AppFeatureIntroductionPagesGroupchatPage(),
      );
    },
    AppFeatureIntroductionRoutesPrivateEventRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.AppFeatureIntroductionPagesPrivateEventPage(),
      );
    },
    AppFeatureIntroductionRoutesUsersRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.AppFeatureIntroductionPagesUsersPage(),
      );
    },
    AppFeatureIntroductionRoutesMessageRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.AppFeatureIntroductionPagesMessagePage(),
      );
    },
    AppPermissionIntroductionRoutesMicrophoneRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.AppPermissionIntroductionPagesMicrophonePage(),
      );
    },
    AppPermissionIntroductionRoutesNotificationRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.AppPermissionIntroductionPagesNotificationPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.LoginPage(),
      );
    },
    NewGroupchatWrapperRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.NewGroupchatWrapperPage(),
      );
    },
    NewGroupchatDetailsTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.NewGroupchatDetailsTab(),
      );
    },
    NewGroupchatPermissionsTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.NewGroupchatPermissionsTab(),
      );
    },
    NewGroupchatSelectUserTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i40.NewGroupchatSelectUserTab(),
      );
    },
    NewPrivateEventRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.NewPrivateEventPage(),
      );
    },
    NewPrivateEventDateTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.NewPrivateEventDateTab(),
      );
    },
    NewPrivateEventDetailsTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i43.NewPrivateEventDetailsTab(),
      );
    },
    NewPrivateEventLocationTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.NewPrivateEventLocationTab(),
      );
    },
    NewPrivateEventPermissionsTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.NewPrivateEventPermissionsTab(),
      );
    },
    NewPrivateEventSearchTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i46.NewPrivateEventSearchTab(),
      );
    },
    NewPrivateEventTypeTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i47.NewPrivateEventTypeTab(),
      );
    },
    PastEventsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i48.PastEventsPage(),
      );
    },
    ProfileChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileChatRouteArgs>(
          orElse: () =>
              ProfileChatRouteArgs(userId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i49.ProfileChatPage(
          userId: args.userId,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () => ProfileRouteArgs(userId: pathParams.optString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i50.ProfilePage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ProfileFollowedTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i51.ProfileFollowedTab(),
      );
    },
    ProfileFollowerTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i52.ProfileFollowerTab(),
      );
    },
    ProfileFollowRequestsTab.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i53.ProfileFollowRequestsTab(),
      );
    },
    ProfileUserRelationsTabRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i54.ProfileUserRelationsTabPage(),
      );
    },
    ProfileWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileWrapperRouteArgs>(
          orElse: () =>
              ProfileWrapperRouteArgs(userId: pathParams.getString('id')));
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i55.ProfileWrapperPage(
          key: args.key,
          user: args.user,
          userId: args.userId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i56.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i57.ResetPasswordPage(
          key: args.key,
          standardEmail: args.standardEmail,
        ),
      );
    },
    SettingsInfoRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i58.SettingsInfoPage(),
      );
    },
    RightOnDeletionRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i59.RightOnDeletionPage(),
      );
    },
    SettingsPrivacyRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i60.SettingsPrivacyPage(),
      );
    },
    CalendarWatchIHaveTimeRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i61.CalendarWatchIHaveTimePage(),
      );
    },
    GroupchatAddMeRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i62.GroupchatAddMePage(),
      );
    },
    PrivateEventAddMeRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i63.PrivateEventAddMePage(),
      );
    },
    UpdateBirthdateRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i64.UpdateBirthdatePage(),
      );
    },
    UpdateEmailRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i65.UpdateEmailPage(),
      );
    },
    UpdatePasswordRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i66.UpdatePasswordPage(),
      );
    },
    ThemeModeRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i67.ThemeModePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i68.SettingsPage(),
      );
    },
    ShoppingListItemChangeUserRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i69.ShoppingListItemChangeUserPage(),
      );
    },
    ShoppingListItemRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i70.ShoppingListItemPage(),
      );
    },
    ShoppingListItemWrapperRoute.name: (routeData) {
      final args = routeData.argsAs<ShoppingListItemWrapperRouteArgs>();
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i71.ShoppingListItemWrapperPage(
          key: args.key,
          shoppingListItemId: args.shoppingListItemId,
          currentShoppingListItemStateToSet:
              args.currentShoppingListItemStateToSet,
        ),
      );
    },
    ShoppingListRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i72.ShoppingListPage(),
      );
    },
    ShoppingListWrapperRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i73.ShoppingListWrapperPage(),
      );
    },
    VerifyEmailRoute.name: (routeData) {
      return _i75.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i74.VerifyEmailPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthorizedPage]
class AuthorizedRoute extends _i75.PageRouteInfo<void> {
  const AuthorizedRoute({List<_i75.PageRouteInfo>? children})
      : super(
          AuthorizedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizedRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BlocInitPage]
class BlocInitRoute extends _i75.PageRouteInfo<void> {
  const BlocInitRoute({List<_i75.PageRouteInfo>? children})
      : super(
          BlocInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlocInitRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CreateUserPage]
class CreateUserRoute extends _i75.PageRouteInfo<void> {
  const CreateUserRoute({List<_i75.PageRouteInfo>? children})
      : super(
          CreateUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateUserRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EventCreateShoppingListItemPage]
class EventCreateShoppingListItemRoute extends _i75.PageRouteInfo<void> {
  const EventCreateShoppingListItemRoute({List<_i75.PageRouteInfo>? children})
      : super(
          EventCreateShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventCreateShoppingListItemRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EventInviteUserPage]
class EventInviteUserRoute extends _i75.PageRouteInfo<void> {
  const EventInviteUserRoute({List<_i75.PageRouteInfo>? children})
      : super(
          EventInviteUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventInviteUserRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EventUpdateLocationPage]
class EventUpdateLocationRoute extends _i75.PageRouteInfo<void> {
  const EventUpdateLocationRoute({List<_i75.PageRouteInfo>? children})
      : super(
          EventUpdateLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventUpdateLocationRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i7.EventUpdatePermissionsPage]
class EventUpdatePermissionsRoute extends _i75.PageRouteInfo<void> {
  const EventUpdatePermissionsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          EventUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventUpdatePermissionsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i8.EventWrapperPage]
class EventWrapperRoute extends _i75.PageRouteInfo<EventWrapperRouteArgs> {
  EventWrapperRoute({
    required String eventId,
    _i76.CurrentEventState? eventStateToSet,
    _i77.Key? key,
    List<_i75.PageRouteInfo>? children,
  }) : super(
          EventWrapperRoute.name,
          args: EventWrapperRouteArgs(
            eventId: eventId,
            eventStateToSet: eventStateToSet,
            key: key,
          ),
          rawPathParams: {'id': eventId},
          initialChildren: children,
        );

  static const String name = 'EventWrapperRoute';

  static const _i75.PageInfo<EventWrapperRouteArgs> page =
      _i75.PageInfo<EventWrapperRouteArgs>(name);
}

class EventWrapperRouteArgs {
  const EventWrapperRouteArgs({
    required this.eventId,
    this.eventStateToSet,
    this.key,
  });

  final String eventId;

  final _i76.CurrentEventState? eventStateToSet;

  final _i77.Key? key;

  @override
  String toString() {
    return 'EventWrapperRouteArgs{eventId: $eventId, eventStateToSet: $eventStateToSet, key: $key}';
  }
}

/// generated route for
/// [_i9.EventShoppingListItemChangeUserPage]
class EventShoppingListItemChangeUserRoute extends _i75.PageRouteInfo<void> {
  const EventShoppingListItemChangeUserRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          EventShoppingListItemChangeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventShoppingListItemChangeUserRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i10.EventShoppingListItemPage]
class EventShoppingListItemRoute extends _i75.PageRouteInfo<void> {
  const EventShoppingListItemRoute({List<_i75.PageRouteInfo>? children})
      : super(
          EventShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventShoppingListItemRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i11.EventShoppingListItemWrapperPage]
class EventShoppingListItemWrapperRoute
    extends _i75.PageRouteInfo<EventShoppingListItemWrapperRouteArgs> {
  EventShoppingListItemWrapperRoute({
    _i77.Key? key,
    required String shoppingListItemId,
    required _i78.CurrentShoppingListItemState shoppingListItemStateToSet,
    bool setCurrentPrivateEvent = false,
    List<_i75.PageRouteInfo>? children,
  }) : super(
          EventShoppingListItemWrapperRoute.name,
          args: EventShoppingListItemWrapperRouteArgs(
            key: key,
            shoppingListItemId: shoppingListItemId,
            shoppingListItemStateToSet: shoppingListItemStateToSet,
            setCurrentPrivateEvent: setCurrentPrivateEvent,
          ),
          rawPathParams: {'shoppingListItemId': shoppingListItemId},
          initialChildren: children,
        );

  static const String name = 'EventShoppingListItemWrapperRoute';

  static const _i75.PageInfo<EventShoppingListItemWrapperRouteArgs> page =
      _i75.PageInfo<EventShoppingListItemWrapperRouteArgs>(name);
}

class EventShoppingListItemWrapperRouteArgs {
  const EventShoppingListItemWrapperRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.setCurrentPrivateEvent = false,
  });

  final _i77.Key? key;

  final String shoppingListItemId;

  final _i78.CurrentShoppingListItemState shoppingListItemStateToSet;

  final bool setCurrentPrivateEvent;

  @override
  String toString() {
    return 'EventShoppingListItemWrapperRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, shoppingListItemStateToSet: $shoppingListItemStateToSet, setCurrentPrivateEvent: $setCurrentPrivateEvent}';
  }
}

/// generated route for
/// [_i12.EventTabPage]
class EventTabRoute extends _i75.PageRouteInfo<EventTabRouteArgs> {
  EventTabRoute({
    _i77.Key? key,
    required String eventId,
    List<_i75.PageRouteInfo>? children,
  }) : super(
          EventTabRoute.name,
          args: EventTabRouteArgs(
            key: key,
            eventId: eventId,
          ),
          rawPathParams: {'id': eventId},
          initialChildren: children,
        );

  static const String name = 'EventTabRoute';

  static const _i75.PageInfo<EventTabRouteArgs> page =
      _i75.PageInfo<EventTabRouteArgs>(name);
}

class EventTabRouteArgs {
  const EventTabRouteArgs({
    this.key,
    required this.eventId,
  });

  final _i77.Key? key;

  final String eventId;

  @override
  String toString() {
    return 'EventTabRouteArgs{key: $key, eventId: $eventId}';
  }
}

/// generated route for
/// [_i13.EventTabChat]
class EventTabChat extends _i75.PageRouteInfo<EventTabChatArgs> {
  EventTabChat({
    required String eventId,
    _i79.Key? key,
    List<_i75.PageRouteInfo>? children,
  }) : super(
          EventTabChat.name,
          args: EventTabChatArgs(
            eventId: eventId,
            key: key,
          ),
          rawPathParams: {'id': eventId},
          initialChildren: children,
        );

  static const String name = 'EventTabChat';

  static const _i75.PageInfo<EventTabChatArgs> page =
      _i75.PageInfo<EventTabChatArgs>(name);
}

class EventTabChatArgs {
  const EventTabChatArgs({
    required this.eventId,
    this.key,
  });

  final String eventId;

  final _i79.Key? key;

  @override
  String toString() {
    return 'EventTabChatArgs{eventId: $eventId, key: $key}';
  }
}

/// generated route for
/// [_i14.EventTabInfo]
class EventTabInfo extends _i75.PageRouteInfo<void> {
  const EventTabInfo({List<_i75.PageRouteInfo>? children})
      : super(
          EventTabInfo.name,
          initialChildren: children,
        );

  static const String name = 'EventTabInfo';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i15.EventTabShoppingList]
class EventTabShoppingList extends _i75.PageRouteInfo<void> {
  const EventTabShoppingList({List<_i75.PageRouteInfo>? children})
      : super(
          EventTabShoppingList.name,
          initialChildren: children,
        );

  static const String name = 'EventTabShoppingList';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i16.EventTabUserList]
class EventTabUserList extends _i75.PageRouteInfo<void> {
  const EventTabUserList({List<_i75.PageRouteInfo>? children})
      : super(
          EventTabUserList.name,
          initialChildren: children,
        );

  static const String name = 'EventTabUserList';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i17.FutureEventsPage]
class FutureEventsRoute extends _i75.PageRouteInfo<void> {
  const FutureEventsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          FutureEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FutureEventsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i18.GroupchatAddUserPage]
class GroupchatAddUserRoute
    extends _i75.PageRouteInfo<GroupchatAddUserRouteArgs> {
  GroupchatAddUserRoute({
    required String groupchatId,
    _i77.Key? key,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<GroupchatAddUserRouteArgs> page =
      _i75.PageInfo<GroupchatAddUserRouteArgs>(name);
}

class GroupchatAddUserRouteArgs {
  const GroupchatAddUserRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i77.Key? key;

  @override
  String toString() {
    return 'GroupchatAddUserRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i19.GroupchatChangeUsernamePage]
class GroupchatChangeUsernameRoute extends _i75.PageRouteInfo<void> {
  const GroupchatChangeUsernameRoute({List<_i75.PageRouteInfo>? children})
      : super(
          GroupchatChangeUsernameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatChangeUsernameRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i20.GroupchatfutureEventsPage]
class GroupchatfutureEventsRoute extends _i75.PageRouteInfo<void> {
  const GroupchatfutureEventsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          GroupchatfutureEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatfutureEventsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i21.GroupchatInfoPage]
class GroupchatInfoRoute extends _i75.PageRouteInfo<GroupchatInfoRouteArgs> {
  GroupchatInfoRoute({
    required String groupchatId,
    _i79.Key? key,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<GroupchatInfoRouteArgs> page =
      _i75.PageInfo<GroupchatInfoRouteArgs>(name);
}

class GroupchatInfoRouteArgs {
  const GroupchatInfoRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i79.Key? key;

  @override
  String toString() {
    return 'GroupchatInfoRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i22.GroupchatPage]
class GroupchatRoute extends _i75.PageRouteInfo<GroupchatRouteArgs> {
  GroupchatRoute({
    required String groupchatId,
    _i77.Key? key,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<GroupchatRouteArgs> page =
      _i75.PageInfo<GroupchatRouteArgs>(name);
}

class GroupchatRouteArgs {
  const GroupchatRouteArgs({
    required this.groupchatId,
    this.key,
  });

  final String groupchatId;

  final _i77.Key? key;

  @override
  String toString() {
    return 'GroupchatRouteArgs{groupchatId: $groupchatId, key: $key}';
  }
}

/// generated route for
/// [_i23.GroupchatPageWrapper]
class GroupchatRouteWrapper
    extends _i75.PageRouteInfo<GroupchatRouteWrapperArgs> {
  GroupchatRouteWrapper({
    _i77.Key? key,
    required String groupchatId,
    _i80.GroupchatEntity? groupchat,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<GroupchatRouteWrapperArgs> page =
      _i75.PageInfo<GroupchatRouteWrapperArgs>(name);
}

class GroupchatRouteWrapperArgs {
  const GroupchatRouteWrapperArgs({
    this.key,
    required this.groupchatId,
    this.groupchat,
  });

  final _i77.Key? key;

  final String groupchatId;

  final _i80.GroupchatEntity? groupchat;

  @override
  String toString() {
    return 'GroupchatRouteWrapperArgs{key: $key, groupchatId: $groupchatId, groupchat: $groupchat}';
  }
}

/// generated route for
/// [_i24.GroupchatUpdatePermissionsPage]
class GroupchatUpdatePermissionsRoute extends _i75.PageRouteInfo<void> {
  const GroupchatUpdatePermissionsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          GroupchatUpdatePermissionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatUpdatePermissionsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i25.HomePage]
class HomeRoute extends _i75.PageRouteInfo<void> {
  const HomeRoute({List<_i75.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i26.HomeChatPage]
class HomeChatRoute extends _i75.PageRouteInfo<void> {
  const HomeChatRoute({List<_i75.PageRouteInfo>? children})
      : super(
          HomeChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeChatRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i27.HomeEventPage]
class HomeEventRoute extends _i75.PageRouteInfo<void> {
  const HomeEventRoute({List<_i75.PageRouteInfo>? children})
      : super(
          HomeEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeEventRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i28.HomeProfilePage]
class HomeProfileRoute extends _i75.PageRouteInfo<HomeProfileRouteArgs> {
  HomeProfileRoute({
    _i77.Key? key,
    String? userId,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<HomeProfileRouteArgs> page =
      _i75.PageInfo<HomeProfileRouteArgs>(name);
}

class HomeProfileRouteArgs {
  const HomeProfileRouteArgs({
    this.key,
    this.userId,
  });

  final _i77.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'HomeProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i29.HomeSearchPage]
class HomeSearchRoute extends _i75.PageRouteInfo<void> {
  const HomeSearchRoute({List<_i75.PageRouteInfo>? children})
      : super(
          HomeSearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeSearchRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i30.AppFeatureIntroductionPagesGroupchatPage]
class AppFeatureIntroductionRoutesGroupchatRoute
    extends _i75.PageRouteInfo<void> {
  const AppFeatureIntroductionRoutesGroupchatRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppFeatureIntroductionRoutesGroupchatRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppFeatureIntroductionRoutesGroupchatRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i31.AppFeatureIntroductionPagesPrivateEventPage]
class AppFeatureIntroductionRoutesPrivateEventRoute
    extends _i75.PageRouteInfo<void> {
  const AppFeatureIntroductionRoutesPrivateEventRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppFeatureIntroductionRoutesPrivateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppFeatureIntroductionRoutesPrivateEventRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i32.AppFeatureIntroductionPagesUsersPage]
class AppFeatureIntroductionRoutesUsersRoute extends _i75.PageRouteInfo<void> {
  const AppFeatureIntroductionRoutesUsersRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppFeatureIntroductionRoutesUsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppFeatureIntroductionRoutesUsersRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i33.AppFeatureIntroductionPagesMessagePage]
class AppFeatureIntroductionRoutesMessageRoute
    extends _i75.PageRouteInfo<void> {
  const AppFeatureIntroductionRoutesMessageRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppFeatureIntroductionRoutesMessageRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppFeatureIntroductionRoutesMessageRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i34.AppPermissionIntroductionPagesMicrophonePage]
class AppPermissionIntroductionRoutesMicrophoneRoute
    extends _i75.PageRouteInfo<void> {
  const AppPermissionIntroductionRoutesMicrophoneRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppPermissionIntroductionRoutesMicrophoneRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppPermissionIntroductionRoutesMicrophoneRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i35.AppPermissionIntroductionPagesNotificationPage]
class AppPermissionIntroductionRoutesNotificationRoute
    extends _i75.PageRouteInfo<void> {
  const AppPermissionIntroductionRoutesNotificationRoute(
      {List<_i75.PageRouteInfo>? children})
      : super(
          AppPermissionIntroductionRoutesNotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppPermissionIntroductionRoutesNotificationRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i36.LoginPage]
class LoginRoute extends _i75.PageRouteInfo<void> {
  const LoginRoute({List<_i75.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i37.NewGroupchatWrapperPage]
class NewGroupchatWrapperRoute extends _i75.PageRouteInfo<void> {
  const NewGroupchatWrapperRoute({List<_i75.PageRouteInfo>? children})
      : super(
          NewGroupchatWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatWrapperRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i38.NewGroupchatDetailsTab]
class NewGroupchatDetailsTab extends _i75.PageRouteInfo<void> {
  const NewGroupchatDetailsTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewGroupchatDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatDetailsTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i39.NewGroupchatPermissionsTab]
class NewGroupchatPermissionsTab extends _i75.PageRouteInfo<void> {
  const NewGroupchatPermissionsTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewGroupchatPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatPermissionsTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i40.NewGroupchatSelectUserTab]
class NewGroupchatSelectUserTab extends _i75.PageRouteInfo<void> {
  const NewGroupchatSelectUserTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewGroupchatSelectUserTab.name,
          initialChildren: children,
        );

  static const String name = 'NewGroupchatSelectUserTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i41.NewPrivateEventPage]
class NewPrivateEventRoute extends _i75.PageRouteInfo<void> {
  const NewPrivateEventRoute({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i42.NewPrivateEventDateTab]
class NewPrivateEventDateTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventDateTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventDateTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDateTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i43.NewPrivateEventDetailsTab]
class NewPrivateEventDetailsTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventDetailsTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventDetailsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventDetailsTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i44.NewPrivateEventLocationTab]
class NewPrivateEventLocationTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventLocationTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventLocationTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventLocationTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i45.NewPrivateEventPermissionsTab]
class NewPrivateEventPermissionsTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventPermissionsTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventPermissionsTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventPermissionsTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i46.NewPrivateEventSearchTab]
class NewPrivateEventSearchTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventSearchTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventSearchTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventSearchTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i47.NewPrivateEventTypeTab]
class NewPrivateEventTypeTab extends _i75.PageRouteInfo<void> {
  const NewPrivateEventTypeTab({List<_i75.PageRouteInfo>? children})
      : super(
          NewPrivateEventTypeTab.name,
          initialChildren: children,
        );

  static const String name = 'NewPrivateEventTypeTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i48.PastEventsPage]
class PastEventsRoute extends _i75.PageRouteInfo<void> {
  const PastEventsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          PastEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PastEventsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i49.ProfileChatPage]
class ProfileChatRoute extends _i75.PageRouteInfo<ProfileChatRouteArgs> {
  ProfileChatRoute({
    required String userId,
    _i77.Key? key,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<ProfileChatRouteArgs> page =
      _i75.PageInfo<ProfileChatRouteArgs>(name);
}

class ProfileChatRouteArgs {
  const ProfileChatRouteArgs({
    required this.userId,
    this.key,
  });

  final String userId;

  final _i77.Key? key;

  @override
  String toString() {
    return 'ProfileChatRouteArgs{userId: $userId, key: $key}';
  }
}

/// generated route for
/// [_i50.ProfilePage]
class ProfileRoute extends _i75.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i79.Key? key,
    String? userId,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<ProfileRouteArgs> page =
      _i75.PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    this.userId,
  });

  final _i79.Key? key;

  final String? userId;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i51.ProfileFollowedTab]
class ProfileFollowedTab extends _i75.PageRouteInfo<void> {
  const ProfileFollowedTab({List<_i75.PageRouteInfo>? children})
      : super(
          ProfileFollowedTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowedTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i52.ProfileFollowerTab]
class ProfileFollowerTab extends _i75.PageRouteInfo<void> {
  const ProfileFollowerTab({List<_i75.PageRouteInfo>? children})
      : super(
          ProfileFollowerTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowerTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i53.ProfileFollowRequestsTab]
class ProfileFollowRequestsTab extends _i75.PageRouteInfo<void> {
  const ProfileFollowRequestsTab({List<_i75.PageRouteInfo>? children})
      : super(
          ProfileFollowRequestsTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileFollowRequestsTab';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i54.ProfileUserRelationsTabPage]
class ProfileUserRelationsTabRoute extends _i75.PageRouteInfo<void> {
  const ProfileUserRelationsTabRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ProfileUserRelationsTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileUserRelationsTabRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i55.ProfileWrapperPage]
class ProfileWrapperRoute extends _i75.PageRouteInfo<ProfileWrapperRouteArgs> {
  ProfileWrapperRoute({
    _i77.Key? key,
    _i81.UserEntity? user,
    required String userId,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<ProfileWrapperRouteArgs> page =
      _i75.PageInfo<ProfileWrapperRouteArgs>(name);
}

class ProfileWrapperRouteArgs {
  const ProfileWrapperRouteArgs({
    this.key,
    this.user,
    required this.userId,
  });

  final _i77.Key? key;

  final _i81.UserEntity? user;

  final String userId;

  @override
  String toString() {
    return 'ProfileWrapperRouteArgs{key: $key, user: $user, userId: $userId}';
  }
}

/// generated route for
/// [_i56.RegisterPage]
class RegisterRoute extends _i75.PageRouteInfo<void> {
  const RegisterRoute({List<_i75.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i57.ResetPasswordPage]
class ResetPasswordRoute extends _i75.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    _i77.Key? key,
    String? standardEmail,
    List<_i75.PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            standardEmail: standardEmail,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i75.PageInfo<ResetPasswordRouteArgs> page =
      _i75.PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    this.standardEmail,
  });

  final _i77.Key? key;

  final String? standardEmail;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, standardEmail: $standardEmail}';
  }
}

/// generated route for
/// [_i58.SettingsInfoPage]
class SettingsInfoRoute extends _i75.PageRouteInfo<void> {
  const SettingsInfoRoute({List<_i75.PageRouteInfo>? children})
      : super(
          SettingsInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsInfoRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i59.RightOnDeletionPage]
class RightOnDeletionRoute extends _i75.PageRouteInfo<void> {
  const RightOnDeletionRoute({List<_i75.PageRouteInfo>? children})
      : super(
          RightOnDeletionRoute.name,
          initialChildren: children,
        );

  static const String name = 'RightOnDeletionRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i60.SettingsPrivacyPage]
class SettingsPrivacyRoute extends _i75.PageRouteInfo<void> {
  const SettingsPrivacyRoute({List<_i75.PageRouteInfo>? children})
      : super(
          SettingsPrivacyRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsPrivacyRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i61.CalendarWatchIHaveTimePage]
class CalendarWatchIHaveTimeRoute extends _i75.PageRouteInfo<void> {
  const CalendarWatchIHaveTimeRoute({List<_i75.PageRouteInfo>? children})
      : super(
          CalendarWatchIHaveTimeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarWatchIHaveTimeRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i62.GroupchatAddMePage]
class GroupchatAddMeRoute extends _i75.PageRouteInfo<void> {
  const GroupchatAddMeRoute({List<_i75.PageRouteInfo>? children})
      : super(
          GroupchatAddMeRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupchatAddMeRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i63.PrivateEventAddMePage]
class PrivateEventAddMeRoute extends _i75.PageRouteInfo<void> {
  const PrivateEventAddMeRoute({List<_i75.PageRouteInfo>? children})
      : super(
          PrivateEventAddMeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivateEventAddMeRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i64.UpdateBirthdatePage]
class UpdateBirthdateRoute extends _i75.PageRouteInfo<void> {
  const UpdateBirthdateRoute({List<_i75.PageRouteInfo>? children})
      : super(
          UpdateBirthdateRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateBirthdateRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i65.UpdateEmailPage]
class UpdateEmailRoute extends _i75.PageRouteInfo<void> {
  const UpdateEmailRoute({List<_i75.PageRouteInfo>? children})
      : super(
          UpdateEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateEmailRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i66.UpdatePasswordPage]
class UpdatePasswordRoute extends _i75.PageRouteInfo<void> {
  const UpdatePasswordRoute({List<_i75.PageRouteInfo>? children})
      : super(
          UpdatePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdatePasswordRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i67.ThemeModePage]
class ThemeModeRoute extends _i75.PageRouteInfo<void> {
  const ThemeModeRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ThemeModeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeModeRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i68.SettingsPage]
class SettingsRoute extends _i75.PageRouteInfo<void> {
  const SettingsRoute({List<_i75.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i69.ShoppingListItemChangeUserPage]
class ShoppingListItemChangeUserRoute extends _i75.PageRouteInfo<void> {
  const ShoppingListItemChangeUserRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ShoppingListItemChangeUserRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemChangeUserRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i70.ShoppingListItemPage]
class ShoppingListItemRoute extends _i75.PageRouteInfo<void> {
  const ShoppingListItemRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ShoppingListItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListItemRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i71.ShoppingListItemWrapperPage]
class ShoppingListItemWrapperRoute
    extends _i75.PageRouteInfo<ShoppingListItemWrapperRouteArgs> {
  ShoppingListItemWrapperRoute({
    _i77.Key? key,
    required String shoppingListItemId,
    required _i78.CurrentShoppingListItemState
        currentShoppingListItemStateToSet,
    List<_i75.PageRouteInfo>? children,
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

  static const _i75.PageInfo<ShoppingListItemWrapperRouteArgs> page =
      _i75.PageInfo<ShoppingListItemWrapperRouteArgs>(name);
}

class ShoppingListItemWrapperRouteArgs {
  const ShoppingListItemWrapperRouteArgs({
    this.key,
    required this.shoppingListItemId,
    required this.currentShoppingListItemStateToSet,
  });

  final _i77.Key? key;

  final String shoppingListItemId;

  final _i78.CurrentShoppingListItemState currentShoppingListItemStateToSet;

  @override
  String toString() {
    return 'ShoppingListItemWrapperRouteArgs{key: $key, shoppingListItemId: $shoppingListItemId, currentShoppingListItemStateToSet: $currentShoppingListItemStateToSet}';
  }
}

/// generated route for
/// [_i72.ShoppingListPage]
class ShoppingListRoute extends _i75.PageRouteInfo<void> {
  const ShoppingListRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ShoppingListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i73.ShoppingListWrapperPage]
class ShoppingListWrapperRoute extends _i75.PageRouteInfo<void> {
  const ShoppingListWrapperRoute({List<_i75.PageRouteInfo>? children})
      : super(
          ShoppingListWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingListWrapperRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}

/// generated route for
/// [_i74.VerifyEmailPage]
class VerifyEmailRoute extends _i75.PageRouteInfo<void> {
  const VerifyEmailRoute({List<_i75.PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static const _i75.PageInfo<void> page = _i75.PageInfo<void>(name);
}
