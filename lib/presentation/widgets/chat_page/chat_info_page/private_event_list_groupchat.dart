import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_bloc.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';

class PrivateEventListGroupchat extends StatelessWidget {
  final String groupchatId;
  const PrivateEventListGroupchat({super.key, required this.groupchatId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateEventBloc, PrivateEventState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];
        if (state is PrivateEventStateLoaded) {
          for (final privateEvent in state.privateEvents) {
            if (privateEvent.connectedGroupchat != null &&
                privateEvent.connectedGroupchat == groupchatId) {
              widgetsToReturn.add(
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  title: Hero(
                    tag: "${privateEvent.id} title",
                    child: Text(
                      privateEvent.title ?? "Kein Titel",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  subtitle: Text(
                    privateEvent.eventDate != null
                        ? DateFormat.yMd()
                            .add_jm()
                            .format(privateEvent.eventDate!)
                        : "Kein Datum",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    AutoRouter.of(context).push(
                      PrivateEventPageRoute(
                        privateEventId: privateEvent.id,
                      ),
                    );
                  },
                ),
              );
            }
          }
        }

        return Column(
          children: [
            Text(
              "Private Events: ${widgetsToReturn.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (widgetsToReturn.isNotEmpty) ...{const SizedBox(height: 8)},
            ...widgetsToReturn
          ],
        );
      },
    );
  }
}
