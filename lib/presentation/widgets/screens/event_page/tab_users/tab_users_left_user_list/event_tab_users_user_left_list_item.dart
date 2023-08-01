import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_role_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class PrivateEventTabUsersLeftUserListItem extends StatelessWidget {
  final EventLeftUserEntity leftPrivateEventUser;
  final EventUserEntity? currentEventUser;
  final EventEntity event;
  const PrivateEventTabUsersLeftUserListItem({
    super.key,
    required this.leftPrivateEventUser,
    required this.event,
    this.currentEventUser,
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
        if (currentEventUser != null &&
                currentEventUser!.role == EventUserRoleEnum.organizer &&
                event.privateEventData?.groupchatTo == null ||
            currentEventUser != null &&
                currentEventUser!.role == EventUserRoleEnum.organizer &&
                event.privateEventData?.groupchatTo == "") ...{
          PopupMenuItem<void Function(void)>(
            child: const Text("Hinzufügen"),
            onTap: () {
              BlocProvider.of<CurrentEventCubit>(context).addUserToEventViaApi(
                userId: leftPrivateEventUser.id,
              );
            },
          ),
        },
      ],
    );
  }
}
