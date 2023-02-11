import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          if (privateEventState.privateEvent.eventLocation!.city != null &&
              privateEventState.privateEvent.eventLocation!.street != null &&
              privateEventState.privateEvent.eventLocation!.housenumber !=
                  null &&
              privateEventState.privateEvent.eventLocation!.zip != null &&
              privateEventState.privateEvent.eventLocation!.country !=
                  null) ...[
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
                        "${privateEventState.privateEvent.eventLocation!.country}, ${privateEventState.privateEvent.eventLocation!.city}, ${privateEventState.privateEvent.eventLocation!.zip}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        "${privateEventState.privateEvent.eventLocation!.street} ${privateEventState.privateEvent.eventLocation!.housenumber}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            // start google maps navigation
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text("Zur Addresse navigieren"),
              onTap: () async {
                final String googleMapslocationUrl =
                    "https://www.google.com/maps/search/?api=1&query=${privateEventState.privateEvent.eventLocation!.street} ${privateEventState.privateEvent.eventLocation!.housenumber}, ${privateEventState.privateEvent.eventLocation!.city}, ${privateEventState.privateEvent.eventLocation!.zip}, ${privateEventState.privateEvent.eventLocation!.country}";

                if (await canLaunchUrlString(googleMapslocationUrl)) {
                  await launchUrlString(googleMapslocationUrl);
                } else {
                  return await showPlatformDialog(
                    context: context,
                    builder: (context) {
                      return PlatformAlertDialog(
                        title: const Text("Fehler beim öffnen"),
                        content: Text(
                          "Konnte den Link zu google maps nicht öffnen",
                        ),
                        actions: const [OKButton()],
                      );
                    },
                  );
                }
              },
            ),
          ] else if (privateEventState.loadingPrivateEvent) ...[
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
          ],
          const SizedBox(height: 8),
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
        privateEventState.loadingPrivateEvent) {
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
