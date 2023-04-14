import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class PrivateEventTabUsersLeftUserListItem extends StatelessWidget {
  final PrivateEventLeftUserEntity leftPrivateEventUser;
  final PrivateEventUserEntity? currentPrivatEventUser;
  final PrivateEventEntity privateEvent;
  const PrivateEventTabUsersLeftUserListItem({
    super.key,
    required this.leftPrivateEventUser,
    required this.privateEvent,
    this.currentPrivatEventUser,
  });

  @override
  Widget build(BuildContext context) {
    return UserListTile(
      subtitle: leftPrivateEventUser.createdAt != null
          ? Text(
              DateFormat.yMd().add_jm().format(
                    leftPrivateEventUser.createdAt!,
                  ),
              overflow: TextOverflow.ellipsis,
            )
          : const Text(
              "Kein Datum",
              overflow: TextOverflow.ellipsis,
            ),
      user: leftPrivateEventUser,
      items: [
        if (currentPrivatEventUser != null &&
                currentPrivatEventUser!.organizer == true &&
                privateEvent.groupchatTo == null ||
            currentPrivatEventUser != null &&
                currentPrivatEventUser!.organizer == true &&
                privateEvent.groupchatTo == "") ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("Hinzufügen"),
            onTap: () {
              BlocProvider.of<CurrentPrivateEventCubit>(context)
                  .addUserToPrivateEventViaApi(
                userId: leftPrivateEventUser.id,
              );
            },
          ),
        },
      ],
    );
  }
}
