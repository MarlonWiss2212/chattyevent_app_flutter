import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventMapMarker extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const PrivateEventMapMarker({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () => AutoRouter.of(context).push(
            PrivateEventWrapperPageRoute(
              privateEventId: privateEventState.privateEvent.id,
              privateEventStateToSet: privateEventState,
            ),
          ),
          child: Row(
            children: [
              if (privateEventState.privateEvent.coverImageLink != null) ...{
                Container(
                  height: 66.66667,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Hero(
                      tag: "${privateEventState.privateEvent.id} coverImage",
                      child: Image.network(
                        privateEventState.privateEvent.coverImageLink!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              },
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Hero(
                    tag: "${privateEventState.privateEvent.id} title",
                    child: Text(
                      privateEventState.privateEvent.title ?? "",
                      style: Theme.of(context).textTheme.labelMedium,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
