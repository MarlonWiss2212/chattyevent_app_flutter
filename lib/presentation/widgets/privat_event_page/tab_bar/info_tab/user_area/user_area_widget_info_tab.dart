import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/info_tab/user_area/private_event_info_tab_user_list.dart';

class UserAreaWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const UserAreaWidgetInfoTab({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // show this text if the private event users ares not there and when its not loading
        if (privateEventState.loadingPrivateEvent == false &&
            privateEventState.privateEvent.users == null) ...[
          const Text(
            "Fehler beim darstellen der User",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (privateEventState.privateEvent.users != null) ...[
          Text(
            "Mitglieder die da sein werden: ${privateEventState.privateEvent.users!.where((element) => element.status == "accapted").length.toString()}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (privateEventState.privateEventUsers.isNotEmpty) ...{
            const SizedBox(height: 8),
          }
        ],
        PrivateEventInfoTabUserList(
          privateEventState: privateEventState,
        ),
      ],
    );
  }
}
