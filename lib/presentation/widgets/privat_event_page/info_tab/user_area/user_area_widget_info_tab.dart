import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/user_area/private_event_info_tab_user_list.dart';

class UserAreaWidgetInfoTab extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  const UserAreaWidgetInfoTab({super.key, required this.privateEventState});

  @override
  Widget build(BuildContext context) {
/*    List<GroupchatUserEntity>? invitedUsers;

    if (privateEventState.groupchat.users != null) {
      for (final chatUser in privateEventState.groupchat.users!) {
        bool pushUser = true;

        // to check if user already accapted invitation
        if (privateEventState.privateEvent.usersThatWillBeThere != null) {
          for (final userThatWillBeThere
              in privateEventState.privateEvent.usersThatWillBeThere!) {
            if (userThatWillBeThere == chatUser.userId) {
              pushUser = false;
              break;
            }
          }
        }

        // to check if user already declined invitation
        if (privateEventState.privateEvent.usersThatWillNotBeThere != null) {
          for (final userThatWillNotBeThere
              in privateEventState.privateEvent.usersThatWillNotBeThere!) {
            if (userThatWillNotBeThere == chatUser.userId) {
              pushUser = false;
              break;
            }
          }
        }

        if (pushUser) {
          invitedUsers ??= [];
          invitedUsers.add(chatUser);
        }
      }
    }*/

    return Column(
      children: [
        // show this text if the private event users ares not there and when its not loading
        if (privateEventState.loadingPrivateEvent == false) ...[
          if (privateEventState.privateEvent.usersThatWillBeThere == null) ...{
            const Text(
              "Fehler beim darstellen der User die da sein werden",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          },
          if (privateEventState.privateEvent.usersThatWillNotBeThere ==
              null) ...{
            const Text(
              "Fehler beim darstellen der User die nicht da sein werden",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          },
        ],
        // show this text if the groupchat is not there and when its not loading
        if (privateEventState.loadingGroupchat == false &&
            privateEventState.groupchat.id == "") ...{
          const Text(
            "Fehler beim darstellen der User die eingeladen sind",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        },
        if (privateEventState.privateEvent.usersThatWillBeThere != null) ...[
          Text(
            "Mitglieder die da sein werden: ${privateEventState.privateEvent.usersThatWillBeThere!.length.toString()}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (privateEventState.privateEventUsers.isNotEmpty) ...{
            const SizedBox(height: 8),
          }
        ],
        PrivateEventInfoTabUserList(
          privateEventState: privateEventState,
        ),
      ],
    );
  }
}
