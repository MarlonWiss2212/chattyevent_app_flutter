import 'package:chattyevent_app_flutter/application/bloc/add_private_event/add_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tabs/new_private_event_search_groupchat_tab.dart';
import 'package:chattyevent_app_flutter/presentation/screens/new_private_event/pages/new_private_event_search_tabs/new_private_event_search_user_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
