import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/domain/entities/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/connected_groupchat_tile_private_event.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/user_area_private_event.dart';

class PrivateEventInfoPage extends StatelessWidget {
  final PrivateEventEntity privateEvent;
  const PrivateEventInfoPage({super.key, required this.privateEvent});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: [
            // Profile Image
            if (privateEvent.coverImageLink != null) ...{
              Container(
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
              SizedBox(
                width: size.width,
                height: (size.width / 4 * 3) - 16,
                child: Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            },
            const SizedBox(height: 20),
            // name
            Hero(
              tag: "${privateEvent.id} title",
              child: Text(
                privateEvent.title ?? "Kein Titel",
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const CustomDivider(),
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
            // event date
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
