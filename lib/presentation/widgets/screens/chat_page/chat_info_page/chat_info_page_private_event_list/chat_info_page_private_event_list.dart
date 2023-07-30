import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/event_list/private_event_list_item.dart';

class ChatInfoPagePrivateEventList extends StatelessWidget {
  const ChatInfoPagePrivateEventList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              "Zukünftige Verbundene Events: ",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (state.futureConnectedPrivateEvents.isEmpty &&
                state.loadingPrivateEvents == true) ...[
              const SizedBox(height: 8),
              SkeletonListTile(
                padding: const EdgeInsets.all(8),
                hasSubtitle: true,
                titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                subtitleStyle: const SkeletonLineStyle(
                  width: double.infinity,
                  height: 16,
                ),
                leadingStyle: const SkeletonAvatarStyle(
                  shape: BoxShape.circle,
                ),
              ),
            ] else if (state.futureConnectedPrivateEvents.isNotEmpty) ...[
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PrivateEventListItem(
                    privateEventState: CurrentEventState.fromPrivateEvent(
                      event: state.futureConnectedPrivateEvents[index],
                    ),
                  );
                },
                itemCount: state.futureConnectedPrivateEvents.length > 10
                    ? 10
                    : state.futureConnectedPrivateEvents.length,
              ),
            ],
            ListTile(
              title: Text(
                "Alle Anzeigen",
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Ionicons.arrow_forward),
              onTap: () {
                AutoRouter.of(context).push(
                  const GroupchatFuturePrivateEventsRoute(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
