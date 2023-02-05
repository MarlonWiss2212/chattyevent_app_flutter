import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_groupchat_cubit.dart';
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
    return BlocBuilder<CurrentPrivateEventGroupchatCubit,
        CurrentPrivateEventGroupchatState>(builder: (context, state) {
      if (state is CurrentPrivateEventGroupchatLoaded) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: state.groupchat.profileImageLink != null
                ? NetworkImage(
                    state.groupchat.profileImageLink!,
                  )
                : null,
            backgroundColor: state.groupchat.profileImageLink == null
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
          ),
          title: state.groupchat.title != null
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
            AutoRouter.of(context).root.push(
                  ChatPageWrapperRoute(
                    chatToSet: state.groupchat,
                    loadChatFromApiToo: true,
                    groupchatId: state.groupchat.id,
                  ),
                );
          },
        );
      } else if (state is CurrentPrivateEventGroupchatLoading) {
        return SkeletonListTile(
          hasSubtitle: true,
          titleStyle: const SkeletonLineStyle(width: 100, height: 22),
          subtitleStyle:
              const SkeletonLineStyle(width: double.infinity, height: 16),
          leadingStyle: const SkeletonAvatarStyle(
            shape: BoxShape.circle,
          ),
        );
      } else {
        return Center(
          child: TextButton(
            child: Text(
              state is CurrentPrivateEventGroupchatError
                  ? state.message
                  : "Daten Laden",
            ),
            onPressed: () =>
                BlocProvider.of<CurrentPrivateEventGroupchatCubit>(context)
                    .setCurrentGroupchatViaApi(
              groupchatId: privateEvent.connectedGroupchat!,
            ), // could throw an error
          ),
        );
      }
    });
  }
}
