import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_left_user_list/private_event_tab_users_left_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_users/tab_users_user_list/private_event_tab_users_user_list.dart';

class PrivateEventTabUsersDetails extends StatelessWidget {
  const PrivateEventTabUsersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              const PrivateEventTabUsersUserList(),
              const CustomDivider(),
              const PrivateEventTabUsersLeftUserList(),
            ],
          ),
        );
      },
    );
  }
}
