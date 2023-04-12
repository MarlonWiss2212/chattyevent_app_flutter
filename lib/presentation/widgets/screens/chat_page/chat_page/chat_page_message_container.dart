import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app_flutter/application/bloc/message/add_message_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';

class ChatPageMessageContainer extends StatelessWidget {
  const ChatPageMessageContainer({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.users,
    required this.leftUsers,
    this.messageIsReactMessage = false,
    this.isInputMessage = false,
  });

  final bool messageIsReactMessage;
  final bool isInputMessage;

  final String currentUserId;
  final List<GroupchatUserEntity> users;
  final List<GroupchatLeftUserEntity> leftUsers;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    UserEntity? user;
    final foundUser = users.firstWhere(
      (element) => element.id == message.createdBy,
      orElse: () => GroupchatUserEntity(
        id: message.createdBy ?? "",
        authId: "",
        groupchatUserId: "",
      ),
    );
    if (foundUser.id == "") {
      final foundLeftUser = leftUsers.firstWhere(
        (element) => element.id == message.createdBy,
        orElse: () => GroupchatLeftUserEntity(
          id: message.createdBy ?? "",
          authId: "",
          groupchatUserLeftId: "",
        ),
      );

      if (foundLeftUser.id != "") {
        user = foundLeftUser;
      }
    } else {
      user = foundUser;
    }

    return Row(
      mainAxisAlignment: user?.id == currentUserId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Slidable(
          enabled: messageIsReactMessage == false,
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(8),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                foregroundColor: Colors.white,
                onPressed: (context) {
                  BlocProvider.of<AddMessageCubit>(context).emitState(
                    messageToReactTo: message.id,
                  );
                },
                icon: Icons.arrow_circle_left_sharp,
              ),
            ],
          ),
          child: Container(
            constraints: messageIsReactMessage == false
                ? BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.1,
                  )
                : null,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: user?.id == currentUserId
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
              color: messageIsReactMessage == false || isInputMessage
                  ? user?.id == currentUserId
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface
                  : const Color.fromARGB(40, 0, 0, 0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user != null && user.username != null
                          ? user.username!
                          : "",
                    ),
                    const SizedBox(width: 8),
                    Text(message.createdAt != null
                        ? DateFormat.jm().format(message.createdAt!)
                        : ""),
                  ],
                ),
                if (message.fileLink != null &&
                    messageIsReactMessage == false) ...[
                  const SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: (MediaQuery.of(context).size.height / 2),
                    ),
                    child: Image.network(
                      message.fileLink!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ] else if (message.fileLink != null &&
                    messageIsReactMessage) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.file_copy),
                      SizedBox(width: 2),
                      Text("Datei"),
                    ],
                  ),
                ],
                if (message.messageToReactTo != null &&
                    messageIsReactMessage == false) ...{
                  ChatPageReactMessageContainer(
                    messageToReactTo: message.messageToReactTo!,
                  ),
                },
                if (message.fileLink != null) ...{
                  const SizedBox(height: 8),
                },
                if (message.message != null) ...{
                  Text(message.message!, overflow: TextOverflow.clip),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }
}
