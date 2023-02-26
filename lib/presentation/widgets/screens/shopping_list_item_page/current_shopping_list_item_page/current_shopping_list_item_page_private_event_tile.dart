import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class CurrentShopppingListItemPagePrivateEventTile extends StatelessWidget {
  const CurrentShopppingListItemPagePrivateEventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        if (state.privateEvent.id != "") {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: state.privateEvent.coverImageLink != null
                  ? NetworkImage(
                      state.privateEvent.coverImageLink!,
                    )
                  : null,
              backgroundColor: state.privateEvent.coverImageLink == null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
            ),
            title: state.privateEvent.title != null
                ? Hero(
                    tag: "${state.privateEvent.title} title",
                    child: Text(
                      state.privateEvent.title!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : Text(
                    "Kein Titel",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
            subtitle: const Text(
              "Verbundenes Event",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              AutoRouter.of(context).root.push(
                    PrivateEventWrapperPageRoute(
                      privateEventId: state.privateEvent.id,
                      loadPrivateEventFromApiToo: false,
                      privateEventToSet: state.privateEvent,
                    ),
                  );
            },
          );
        } else if (state.privateEvent.id == "" && state.loadingPrivateEvent) {
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
      },
    );
  }
}