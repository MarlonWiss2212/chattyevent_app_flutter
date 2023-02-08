import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';

class LocationWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const LocationWidgetInfoTab({
    super.key,
    required this.privateEventState,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (privateEventState.privateEvent.eventLocation != null) {
      return Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: min(size.width, 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FlutterMap(
                options: MapOptions(
                  interactiveFlags: InteractiveFlag.none,
                  center: LatLng(
                    privateEventState.privateEvent.eventLocation!.latitude,
                    privateEventState.privateEvent.eventLocation!.longitude,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          privateEventState
                              .privateEvent.eventLocation!.latitude,
                          privateEventState
                              .privateEvent.eventLocation!.longitude,
                        ),
                        builder: (context) {
                          return CircleImage(
                            width: 40,
                            height: 40,
                            imageLink:
                                privateEventState.privateEvent.coverImageLink,
                            icon:
                                privateEventState.privateEvent.coverImageLink ==
                                        null
                                    ? const Icon(Icons.celebration)
                                    : null,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const CustomDivider(),
        ],
      );
    } else if (privateEventState.privateEvent.eventLocation == null &&
        privateEventState is CurrentPrivateEventLoading &&
        (privateEventState as CurrentPrivateEventLoading).loadingPrivateEvent) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: size.width,
                height: min(size.width, 300),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const CustomDivider(),
        ],
      );
    } else {
      return Container();
    }
  }
}
