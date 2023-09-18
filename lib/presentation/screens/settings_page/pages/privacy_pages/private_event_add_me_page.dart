import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/private_event_add_me_page/private_event_add_me_page_chip_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/private_event_add_me_page/private_event_add_me_page_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/private_event_add_me_page/private_event_add_me_page_searchbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class PrivateEventAddMePage extends StatelessWidget {
  const PrivateEventAddMePage({super.key});

  Widget initBloc(BuildContext context, {required Widget child}) {
    return BlocProvider(
      create: (context) => UserSearchCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userRelationUseCases: authenticatedLocator(),
        userUseCases: authenticatedLocator(),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getFollowersViaApi(sortForPrivateEventAddMeAllowedUsersFirst: true),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return initBloc(
      context,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "settingsPage.privacyPage.privateEventAddMePage.title",
          ).tr(),
        ),
        body: const Column(
          children: [
            PrivateEventAddMePageChipList(),
            SizedBox(height: 8),
            PrivateEventAddMePageSearchbar(),
            SizedBox(height: 8),
            PrivateEventAddMePageUserList(),
          ],
        ),
      ),
    );
  }
}
