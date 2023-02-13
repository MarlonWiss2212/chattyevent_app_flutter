import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/groupchat/create_groupchat_user_dto.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/user_with_groupchat_user_data.dart';
import 'package:social_media_app_flutter/presentation/widgets/user_list_tile.dart';

class UserLeftListGroupchat extends StatelessWidget {
  final CurrentChatState chatState;
  final UserWithGroupchatUserData currentUserWithGroupchatUserData;
  const UserLeftListGroupchat({
    super.key,
    required this.chatState,
    required this.currentUserWithGroupchatUserData,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToReturn = [];
    for (final userWithLeftGroupchatUserData
        in chatState.usersWithLeftGroupchatUserData) {
      widgetsToReturn.add(
        UserListTile(
          profileImageLink: userWithLeftGroupchatUserData.profileImageLink,
          subtitle: userWithLeftGroupchatUserData.leftAt != null
              ? Text(
                  DateFormat.yMd().add_jm().format(
                        userWithLeftGroupchatUserData.leftAt!,
                      ),
                  overflow: TextOverflow.ellipsis,
                )
              : const Text(
                  "Kein Datum",
                  overflow: TextOverflow.ellipsis,
                ),
          username: userWithLeftGroupchatUserData.username != null
              ? userWithLeftGroupchatUserData.username!
              : "Kein Username",
          userId: userWithLeftGroupchatUserData.id,
          longPress: currentUserWithGroupchatUserData.admin != null &&
                  currentUserWithGroupchatUserData.admin == true &&
                  currentUserWithGroupchatUserData.id !=
                      userWithLeftGroupchatUserData.id
              ? (userId) {
                  showMenu(
                    position:
                        const RelativeRect.fromLTRB(0, double.infinity, 0, 0),
                    context: context,
                    items: [
                      PopupMenuItem(
                        child: const Text("Hinzufügen"),
                        onTap: () => BlocProvider.of<CurrentChatCubit>(context)
                            .addUserToChat(
                          createGroupchatUserDto: CreateGroupchatUserDto(
                            admin: false,
                            userId: userId,
                            groupchatTo: chatState.currentChat.id,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              : null,
        ),
      );
    }
    return Column(children: widgetsToReturn);
  }
}
