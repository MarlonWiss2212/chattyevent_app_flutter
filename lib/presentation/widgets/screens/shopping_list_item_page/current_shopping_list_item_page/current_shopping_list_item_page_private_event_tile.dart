import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class CurrentShoppingListItemPagePrivateEventTile extends StatelessWidget {
  const CurrentShoppingListItemPagePrivateEventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Verbundenes Privates Event: ",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        BlocBuilder<CurrentEventCubit, CurrentEventState>(
          builder: (context, state) {
            if (state.event.id != "") {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: state.event.coverImageLink != null
                      ? CachedNetworkImageProvider(
                          state.event.coverImageLink!,
                          cacheKey: state.event.coverImageLink!.split("?")[0],
                        )
                      : null,
                  backgroundColor: state.event.coverImageLink == null
                      ? Theme.of(context).colorScheme.surface
                      : null,
                ),
                title: state.event.title != null
                    ? Hero(
                        tag: "${state.event.title} title",
                        child: Text(
                          state.event.title!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    : null,
                subtitle: const Text(
                  "Verbundenes Event",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  AutoRouter.of(context).root.push(
                        EventWrapperRoute(
                          eventId: state.event.id,
                          eventStateToSet: CurrentEventState.fromEvent(
                            event: state.event,
                          ),
                        ),
                      );
                },
              );
            } else if (state.event.id == "" && state.loadingEvent) {
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
        ),
      ],
    );
  }
}
