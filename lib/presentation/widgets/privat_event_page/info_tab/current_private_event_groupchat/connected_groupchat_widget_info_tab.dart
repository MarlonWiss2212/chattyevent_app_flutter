import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/current_private_event_groupchat/connected_groupchat_tile_private_event.dart';

class ConnectedGroupchatWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const ConnectedGroupchatWidgetInfoTab({
    super.key,
    required this.privateEventState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Verbundener Gruppenchat: ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        if (privateEventState.privateEvent.connectedGroupchat != null) ...{
          const SizedBox(height: 8)
        },
        ConnectedGroupchatTilePrivateEvent(
          privateEvent: privateEventState.privateEvent,
        ),
      ],
    );
  }
}
