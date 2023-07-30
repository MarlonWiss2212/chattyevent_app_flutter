import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_remove_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class EventTabInfoLocationData extends StatelessWidget {
  const EventTabInfoLocationData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return InkWell(
          onTap: state.currentUserAllowedWithPermission(
            permissionCheckValue: state.event.permissions?.changeAddress,
          )
              ? () => AutoRouter.of(context).push(
                    const EventUpdateLocationRoute(),
                  )
              : null,
          child: Column(
            children: [
              if (state.event.eventLocation?.address != null &&
                  state.event.eventLocation!.address!.city != null &&
                  state.event.eventLocation!.address!.street != null &&
                  state.event.eventLocation!.address!.housenumber != null &&
                  state.event.eventLocation!.address!.zip != null &&
                  state.event.eventLocation!.address!.country != null) ...[
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
                            "${state.event.eventLocation!.address!.country}, ${state.event.eventLocation!.address!.city}, ${state.event.eventLocation!.address!.zip}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            "${state.event.eventLocation!.address!.street} ${state.event.eventLocation!.address!.housenumber}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          if (state.currentUserAllowedWithPermission(
                            permissionCheckValue:
                                state.event.permissions?.changeAddress,
                          )) ...{
                            const EventTabInfoLocationRemoveIcon(),
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
                    BlocProvider.of<CurrentEventCubit>(context).openMaps();
                  },
                ),
              ] else if (state.loadingEvent) ...[
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
