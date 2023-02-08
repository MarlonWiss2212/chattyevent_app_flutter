import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class ConnectedGroupchatTilePrivateEvent extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const ConnectedGroupchatTilePrivateEvent({
    super.key,
    required this.privateEventState,
  });

  @override
  Widget build(BuildContext context) {
    if (privateEventState.groupchat.id != "") {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: privateEventState.groupchat.profileImageLink != null
              ? NetworkImage(
                  privateEventState.groupchat.profileImageLink!,
                )
              : null,
          backgroundColor: privateEventState.groupchat.profileImageLink == null
              ? Theme.of(context).colorScheme.secondaryContainer
              : null,
        ),
        title: privateEventState.groupchat.title != null
            ? Hero(
                tag: "${privateEventState.groupchat.id} title",
                child: Text(
                  privateEventState.groupchat.title!,
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
                  chatToSet: privateEventState.groupchat,
                  loadChatFromApiToo: true,
                  groupchatId: privateEventState.groupchat.id,
                ),
              );
        },
      );
    } else if (privateEventState.groupchat.id == "" &&
        privateEventState is CurrentPrivateEventLoading &&
        (privateEventState as CurrentPrivateEventLoading).loadingGroupchat) {
      return SkeletonListTile(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        hasSubtitle: true,
        titleStyle: const SkeletonLineStyle(width: 100, height: 22),
        subtitleStyle:
            const SkeletonLineStyle(width: double.infinity, height: 16),
        leadingStyle: const SkeletonAvatarStyle(
          shape: BoxShape.circle,
        ),
      );
    }
    return Container();
  }
}
