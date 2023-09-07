import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/request/request_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class EventTabInvitationListItem extends StatelessWidget {
  final RequestEntity invitation;

  const EventTabInvitationListItem({
    super.key,
    required this.invitation,
  });

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = invitation.invitationData?.invitedUser;
    if (user == null) {
      return const Text("Fehler beim Darstellen eines Eingeladenen Users");
    }
    return BlocBuilder<CurrentEventCubit, CurrentEventState>(
      builder: (context, state) {
        return UserListTile(
          user: user,
          subtitle: Text("Eingeladen von: ${invitation.createdBy.username}"),
          items: state.currentUserAllowedWithPermission(
            permissionCheckValue: state.event.permissions?.addUsers,
          )
              ? [
                  PopupMenuItem(
                    child: const Text("Einladung Löschen"),
                    onTap: () => BlocProvider.of<CurrentEventCubit>(context)
                        .deleteRequestViaApiAndReloadRequests(
                      request: invitation,
                    ),
                  ),
                ]
              : null,
        );
      },
    );
  }
}
