import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_date_tab/new_event_date_tab_calendar_user_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/new_private_event/new_private_event_date_tab/new_event_date_tab_select_date_buttons.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewPrivateEventDateTab extends StatelessWidget {
  const NewPrivateEventDateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        NewEventDateTabSelectDateButtons(),
        NewEventDateTabCalendarUserList(),
      ],
    );
  }
}
