import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/event_tab_users_leave_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_invitation_list/event_tab_invitation_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_left_user_list/event_tab_users_left_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_users/tab_users_user_list/event_tab_users_user_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class EventTabUserList extends StatelessWidget {
  const EventTabUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          expandedHeight: 100,
          centerTitle: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              "eventPage.tabs.userListTab.title",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ).tr(),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => Future.wait([
            BlocProvider.of<CurrentEventCubit>(context)
                .getEventUsersAndLeftUsersViaApi(),
            BlocProvider.of<CurrentEventCubit>(context).getInvitationsViaApi(),
          ]),
        ),
        BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  const EventTabUsersUserList(),
                  const CustomDivider(),
                  const EventTabUsersLeftUserList(),
                  const CustomDivider(),
                  const EventTabInvitationList(),
                  const CustomDivider(),
                  const EventTabUsersLeaveButton(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
