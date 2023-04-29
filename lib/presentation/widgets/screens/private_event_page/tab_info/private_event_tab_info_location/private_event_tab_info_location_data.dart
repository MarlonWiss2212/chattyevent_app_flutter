import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventTabInfoLocationData extends StatelessWidget {
  const PrivateEventTabInfoLocationData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.getCurrentPrivateEventUser()?.organizer == true
              ? () => AutoRouter.of(context).push(
                    const PrivateEventUpdateLocationPageRoute(),
                  )
              : null,
          child: Column(
            children: [
              if (state.privateEvent.eventLocation!.city != null &&
                  state.privateEvent.eventLocation!.street != null &&
                  state.privateEvent.eventLocation!.housenumber != null &&
                  state.privateEvent.eventLocation!.zip != null &&
                  state.privateEvent.eventLocation!.country != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Addresse: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "${state.privateEvent.eventLocation!.country}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text("Zur Addresse navigieren"),
                  onTap: () {
                    BlocProvider.of<CurrentPrivateEventCubit>(context)
                        .openMaps();
                  },
                ),
              ] else if (state.loadingPrivateEvent) ...[
                const SkeletonLine(),
                const SizedBox(height: 8),
                SkeletonListTile(
                  hasSubtitle: false,
                  titleStyle: const SkeletonLineStyle(width: 100, height: 22),
                  subtitleStyle: const SkeletonLineStyle(
                    width: double.infinity,
                    height: 16,
                  ),
                  leadingStyle: const SkeletonAvatarStyle(
                    shape: BoxShape.circle,
                  ),
                )
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Addresse: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Addresse ändern")
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
