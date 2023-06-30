import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/core/enums/private_event/private_event_user/private_event_user_role_enum.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_info/private_event_tab_info_location/private_event_tab_info_location_remove_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class PrivateEventTabInfoLocationData extends StatelessWidget {
  const PrivateEventTabInfoLocationData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.getCurrentPrivateEventUser()?.role ==
                  PrivateEventUserRoleEnum.organizer
              ? () => AutoRouter.of(context).push(
                    const PrivateEventUpdateLocationPageRoute(),
                  )
              : null,
          child: Column(
            children: [
              if (state.privateEvent.eventLocation != null &&
                  state.privateEvent.eventLocation!.city != null &&
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${state.privateEvent.eventLocation!.country}, ${state.privateEvent.eventLocation!.city}, ${state.privateEvent.eventLocation!.zip}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${state.privateEvent.eventLocation!.street} ${state.privateEvent.eventLocation!.housenumber}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          if (state.getCurrentPrivateEventUser()?.role ==
                              PrivateEventUserRoleEnum.organizer) ...{
                            const PrivateEventTabInfoLocationRemoveIcon(),
                          },
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Addresse: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Addresse hinzufügen")
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
