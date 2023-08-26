import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/calendar_watch_i_have_time_page/calendar_watch_i_have_time_page_chip_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/calendar_watch_i_have_time_page/calendar_watch_i_have_time_page_searchbar.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/settings_page/pages/privacy_pages/calendar_watch_i_have_time_page/calendar_watch_i_have_time_page_user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CalendarWatchIHaveTimePage extends StatelessWidget {
  const CalendarWatchIHaveTimePage({super.key});

  Widget initBloc(BuildContext context, {required Widget child}) {
    return BlocProvider(
      create: (context) => UserSearchCubit(
        authCubit: BlocProvider.of<AuthCubit>(context),
        userRelationUseCases: serviceLocator(),
        userUseCases: serviceLocator(),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getFollowersViaApi(
          sortForCalendarWatchIHaveTimeAllowedUsersFirst: true),
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
          title: const Text("Kalendar sehen Berechtigung"),
        ),
        body: const Column(
          children: [
            CalendarWatchIHaveTimePageChipList(),
            SizedBox(height: 8),
            CalendarWatchIHaveTimePageSearchbar(),
            SizedBox(height: 8),
            CalendarWatchIHaveTimePageUserList(),
          ],
        ),
      ),
    );
  }
}
