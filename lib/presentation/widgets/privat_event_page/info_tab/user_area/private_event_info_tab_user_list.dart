import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event/current_private_event_groupchat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/accept_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/decline_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/info_tab/icon_buttons_my_user_list_tile/neutral_invite_icon_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class PrivateEventInfoTabUserList extends StatelessWidget {
  final CurrentPrivateEventState privateEventState;
  final CurrentPrivateEventGroupchatState currentPrivateEventGroupchatState;
  final List<GroupchatUserEntity>? invitedUsers;

  const PrivateEventInfoTabUserList({
    super.key,
    required this.privateEventState,
    required this.currentPrivateEventGroupchatState,
    this.invitedUsers,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserId = Jwt.parseJwt(
        (BlocProvider.of<AuthCubit>(context).state as AuthLoaded).token)["sub"];
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        List<Widget> widgetsToReturn = [];

        // users that will be there
        // message for when the user is null and state is not loading is in userareainfotab widget
        if (privateEventState.privateEvent.usersThatWillBeThere == null &&
            privateEventState is CurrentPrivateEventLoading) {
          widgetsToReturn.add(
            SkeletonListTile(
              padding: const EdgeInsets.all(8),
              hasSubtitle: true,
              titleStyle: const SkeletonLineStyle(width: 100, height: 22),
              subtitleStyle:
                  const SkeletonLineStyle(width: double.infinity, height: 16),
              leadingStyle: const SkeletonAvatarStyle(
                shape: BoxShape.circle,
              ),
            ),
          );
        } else if (privateEventState.privateEvent.usersThatWillBeThere !=
            null) {
          for (final privateEventUserIdThatWillBeThere
              in privateEventState.privateEvent.usersThatWillBeThere!) {
            UserEntity foundUser = state.users.firstWhere(
              (element) => element.id == privateEventUserIdThatWillBeThere,
              orElse: () => UserEntity(id: ""),
            );

            widgetsToReturn.add(
              UserListTile(
                profileImageLink: foundUser.profileImageLink,
                subtitle: const Text(
                  "Angenommen",
                  style: TextStyle(color: Colors.green),
                ),
                username: foundUser.username != null
                    ? foundUser.username!
                    : "Kein Username",
                userId: privateEventUserIdThatWillBeThere,
                trailing: privateEventUserIdThatWillBeThere == currentUserId
                    ? Wrap(
                        spacing: 8,
                        children: [
                          DeclineInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          ),
                          NeutralInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          )
                        ],
                      )
                    : null,
              ),
            );
          }
        }

        // users that will not be there
        // message for when the user is null and state is not loading is in userareainfotab widget
        if (privateEventState.privateEvent.usersThatWillNotBeThere == null &&
            privateEventState is CurrentPrivateEventLoading) {
          widgetsToReturn.add(
            SkeletonListTile(
              padding: const EdgeInsets.all(8),
              hasSubtitle: true,
              titleStyle: const SkeletonLineStyle(width: 100, height: 22),
              subtitleStyle:
                  const SkeletonLineStyle(width: double.infinity, height: 16),
              leadingStyle: const SkeletonAvatarStyle(
                shape: BoxShape.circle,
              ),
            ),
          );
        } else if (privateEventState.privateEvent.usersThatWillNotBeThere !=
            null) {
          for (final privateEventUserIdThatWillNotBeThere
              in privateEventState.privateEvent.usersThatWillNotBeThere!) {
            UserEntity foundUser = state.users.firstWhere(
              (element) => element.id == privateEventUserIdThatWillNotBeThere,
              orElse: () => UserEntity(id: ""),
            );

            widgetsToReturn.add(
              UserListTile(
                profileImageLink: foundUser.profileImageLink,
                subtitle: const Text(
                  "Abgelehnt",
                  style: TextStyle(color: Colors.red),
                ),
                username: foundUser.username != null
                    ? foundUser.username!
                    : "Kein Username",
                userId: privateEventUserIdThatWillNotBeThere,
                trailing: privateEventUserIdThatWillNotBeThere == currentUserId
                    ? Wrap(
                        spacing: 8,
                        children: [
                          AcceptInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          ),
                          NeutralInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          )
                        ],
                      )
                    : null,
              ),
            );
          }
        }

        // invited users
        // message for when the user is null and state is not loading is in userareainfotab widget
        if (currentPrivateEventGroupchatState
                is CurrentPrivateEventGroupchatLoading &&
            invitedUsers == null) {
          widgetsToReturn.add(
            SkeletonListTile(
              padding: const EdgeInsets.all(8),
              hasSubtitle: true,
              titleStyle: const SkeletonLineStyle(width: 100, height: 22),
              subtitleStyle:
                  const SkeletonLineStyle(width: double.infinity, height: 16),
              leadingStyle: const SkeletonAvatarStyle(
                shape: BoxShape.circle,
              ),
            ),
          );
        } else if (invitedUsers != null) {
          for (final invitedUser in invitedUsers!) {
            UserEntity foundUser = state.users.firstWhere(
              (element) => element.id == invitedUser.userId,
              orElse: () => UserEntity(id: ""),
            );

            widgetsToReturn.add(
              UserListTile(
                profileImageLink: foundUser.profileImageLink,
                subtitle: privateEventState.privateEvent.usersThatWillBeThere ==
                            null ||
                        privateEventState
                                .privateEvent.usersThatWillNotBeThere ==
                            null
                    ? const SkeletonLine()
                    : const Text("Eingeladen"),
                username: foundUser.username != null
                    ? foundUser.username!
                    : "Kein Username",
                userId: invitedUser.userId,
                trailing: invitedUser.userId == currentUserId
                    ? Wrap(
                        spacing: 8,
                        children: [
                          AcceptInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          ),
                          DeclineInviteIconButton(
                            privateEventId: privateEventState.privateEvent.id,
                          )
                        ],
                      )
                    : null,
              ),
            );
          }
        }

        return Column(children: widgetsToReturn);
      },
    );
  }
}
