import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/open_maps_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_info/event_tab_info_location/event_tab_info_location_remove_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class EventTabInfoLocationData extends StatelessWidget {
  const EventTabInfoLocationData({super.key});

  Widget _updateRouteButton({
    required Widget child,
    required CurrentEventState state,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: state.currentUserAllowedWithPermission(
        permissionCheckValue: state.event.permissions?.changeAddress,
      )
          ? () => AutoRouter.of(context).push(
                const EventUpdateLocationRoute(),
              )
          : null,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Ionicons.location,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  "eventPage.tabs.infoTab.addressButton.text",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ).tr()
              ],
            ),
            const SizedBox(height: 8),
            if (state.event.eventLocation?.address != null &&
                state.event.eventLocation!.address!.city != null &&
                state.event.eventLocation!.address!.street != null &&
                state.event.eventLocation!.address!.housenumber != null &&
                state.event.eventLocation!.address!.zip != null &&
                state.event.eventLocation!.address!.country != null) ...[
              _updateRouteButton(
                context: context,
                state: state,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          "${state.event.eventLocation!.address!.country}, ${state.event.eventLocation!.address!.city}, ${state.event.eventLocation!.address!.zip}, ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${state.event.eventLocation!.address!.street} ${state.event.eventLocation!.address!.housenumber}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    if (state.currentUserAllowedWithPermission(
                      permissionCheckValue:
                          state.event.permissions?.changeAddress,
                    )) ...{
                      const EventTabInfoLocationRemoveIcon(),
                    },
                  ],
                ),
              ),
              const SizedBox(height: 8),
              OpenMapsButton(
                query: BlocProvider.of<CurrentEventCubit>(context)
                    .state
                    .getLocationQueryForMaps(),
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
              _updateRouteButton(
                context: context,
                state: state,
                child: Row(
                  children: [
                    Text(
                      "eventPage.tabs.infoTab.addressButton.rightEmptyText",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ).tr(),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
