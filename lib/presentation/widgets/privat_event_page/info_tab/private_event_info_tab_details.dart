import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/connected_groupchat_tile_private_event.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/user_area_private_event.dart';

class PrivateEventInfoTabDetails extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventInfoTabDetails({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Profile Image
            if (privateEvent.coverImageLink != null) ...{
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Hero(
                    tag: "${privateEvent.id} coverImage",
                    child: Image.network(
                      privateEvent.coverImageLink!,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              )
            } else ...{
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: size.width,
                  height: (size.width / 4 * 3) - 16,
                  child: Card(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
            },
            const SizedBox(height: 20),
            // connectedGroupchat
            Text(
              "Verbundener Gruppenchat: ",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (privateEvent.connectedGroupchat != null) ...{
              const SizedBox(height: 8)
            },
            ConnectedGroupchatTilePrivateEvent(privateEvent: privateEvent),
            const CustomDivider(),
            // title of users that will be there and list of users for the privat event
            UserAreaPrivateEvent(privateEvent: privateEvent),
            const CustomDivider(),
            // location
            if (privateEvent.eventLocation != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: min(size.width, 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FlutterMap(
                    options: MapOptions(
                      absorbPanEventsOnScrollables: false,
                      rotationThreshold: 400,
                      center: LatLng(
                        privateEvent.eventLocation!.latitude,
                        privateEvent.eventLocation!.longitude,
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
                              privateEvent.eventLocation!.latitude,
                              privateEvent.eventLocation!.longitude,
                            ),
                            builder: (context) {
                              return CircleImage(
                                width: 40,
                                height: 40,
                                imageLink: privateEvent.coverImageLink,
                                icon: privateEvent.coverImageLink == null
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
            // event date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Event Datum: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    privateEvent.eventDate != null
                        ? DateFormat.yMd()
                            .add_jm()
                            .format(privateEvent.eventDate!)
                        : "Kein Datum",
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
