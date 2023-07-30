import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/private_event_tab_users_leave_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_left_user_list/private_event_tab_users_left_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_user_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class PrivateEventTabUserList extends StatelessWidget {
  const PrivateEventTabUserList({super.key});

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
              "Event User",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () => BlocProvider.of<CurrentEventCubit>(context)
              .getEventUsersAndLeftUsersViaApi(),
        ),
        BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  const PrivateEventTabUsersUserList(),
                  const CustomDivider(),
                  const PrivateEventTabUsersLeftUserList(),
                  const CustomDivider(),
                  const PrivateEventTabUsersLeaveButton(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
