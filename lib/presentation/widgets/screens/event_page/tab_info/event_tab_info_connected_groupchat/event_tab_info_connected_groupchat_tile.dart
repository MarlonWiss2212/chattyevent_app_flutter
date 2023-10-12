import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';

class EventTabInfoGroupchatToTile extends StatelessWidget {
  final GroupchatEntity groupchat;
  const EventTabInfoGroupchatToTile({
    super.key,
    required this.groupchat,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).root.push(
              GroupchatRouteWrapper(
                groupchat: groupchat,
                groupchatId: groupchat.id,
              ),
            );
      },
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: groupchat.profileImageLink != null
                    ? CachedNetworkImageProvider(
                        groupchat.profileImageLink!,
                        cacheKey: groupchat.profileImageLink!.split("?")[0],
                      )
                    : null,
                backgroundColor: groupchat.profileImageLink == null
                    ? Theme.of(context).colorScheme.surface
                    : null,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${groupchat.id} title",
                    child: Text(
                      groupchat.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Text(
                    "eventPage.tabs.infoTab.connectedGroupchatText",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ).tr(),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
