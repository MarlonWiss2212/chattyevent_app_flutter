import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ConnectedGroupchatTilePrivateEvent extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const ConnectedGroupchatTilePrivateEvent({
    super.key,
    required this.privateEvent,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
        builder: (context, state) {
      if (state is CurrentPrivateEventLoadedGroupchat) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: state is CurrentPrivateEventLoadedGroupchat &&
                    state.groupchat.profileImageLink != null
                ? NetworkImage(
                    state.groupchat.profileImageLink!,
                  )
                : null,
            backgroundColor: state is! CurrentPrivateEventLoadedGroupchat ||
                    state.groupchat.profileImageLink == null
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
          ),
          title: state is CurrentPrivateEventLoadedGroupchat &&
                  state.groupchat.title != null
              ? Hero(
                  tag: "${state.groupchat.id} title",
                  child: Text(
                    state.groupchat.title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              : Text(
                  "Kein Titel",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
          subtitle: const Text(
            "Verbundener Gruppenchat",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            if (state is CurrentPrivateEventLoadedGroupchat) {
              AutoRouter.of(context).root.push(
                    ChatPageWrapperRoute(
                      groupchatId: state.groupchat.id,
                    ),
                  );
            }
          },
        );
      } else if (state is CurrentPrivateEventLoadingGroupchat) {
        return Center(child: PlatformCircularProgressIndicator());
      } else {
        return Center(
          child: TextButton(
            child: Text(
              state is CurrentPrivateEventErrorGroupchat
                  ? state.message
                  : "Daten Laden",
            ),
            onPressed: () =>
                BlocProvider.of<ChatCubit>(context).getChatsViaApi(),
          ),
        );
      }
    });
  }
}
