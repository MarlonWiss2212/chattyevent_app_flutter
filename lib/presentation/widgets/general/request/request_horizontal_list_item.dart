import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattyevent_app_flutter/application/bloc/requests/requests_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RequestHorizontalListItem extends StatelessWidget {
  final RequestEntity request;

  const RequestHorizontalListItem({
    super.key,
    required this.request,
  });

  static String _getInvitationText(RequestEntity request) =>
      "Der User ${request.createdBy.username} hat dir eine Einladung ${request.invitationData!.eventUser != null ? "zum Event ${request.invitationData!.eventUser!.event.title} gesendet. Das Event findet an den flogendem Datum statt: ${DateFormat.yMd().add_jm().format(request.invitationData!.eventUser!.event.eventDate)}${request.invitationData!.eventUser!.event.eventEndDate != null ? "-${request.invitationData!.eventUser!.event.eventEndDate}" : ""}" : request.invitationData!.groupchatUser != null ? "zu dem Gruppenchat ${request.invitationData!.groupchatUser!.groupchat.title} gesendet" : "Fehler"}";

  @override
  Widget build(BuildContext context) {
    final String? imageLink = request.invitationData!.eventUser != null
        ? request.invitationData!.eventUser!.event.coverImageLink
        : request.invitationData!.groupchatUser != null
            ? request.invitationData!.groupchatUser!.groupchat.profileImageLink
            : null;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageLink != null) ...{
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: imageLink,
                cacheKey: imageLink.split("?")[0],
                fit: BoxFit.cover,
              ),
            ),
          },
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(150, 0, 0, 0),
                  Color.fromARGB(100, 0, 0, 0),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (request.invitationData != null) ...{
                  Text(
                    // TODO join request
                    _getInvitationText(request),
                    softWrap: true,

                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                },
                Row(
                  children: [
                    Flexible(
                      child: Button(
                        onTap: () => BlocProvider.of<RequestsCubit>(context)
                            .deleteRequestViaApiAndReloadRequests(
                          request: request,
                        ),
                        text: request.invitationData != null
                            ? "Ablehnen"
                            : "Löschen",
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (request.invitationData != null) ...{
                      Flexible(
                        child: Button(
                          onTap: () => BlocProvider.of<RequestsCubit>(context)
                              .acceptInvitationViaApiAndReloadRequests(
                            invitation: request,
                          ),
                          text: "Akzeptieren",
                        ),
                      ),
                    },
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
