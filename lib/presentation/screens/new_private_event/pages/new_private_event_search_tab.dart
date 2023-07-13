import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_search_tab/new_private_event_search_groupchat_tab.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_search_tab/new_private_event_search_user_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NewPrivateEventSearchTab extends StatelessWidget {
  const NewPrivateEventSearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPrivateEventCubit, AddPrivateEventState>(
      buildWhen: (p, c) => p.isGroupchatEvent != c.isGroupchatEvent,
      builder: (context, state) {
        if (state.isGroupchatEvent == false) {
          return const NewPrivateEventSearchUserTab();
        } else {
          return const NewPrivateEventSearchGroupchatTab();
        }
      },
    );
  }
}
