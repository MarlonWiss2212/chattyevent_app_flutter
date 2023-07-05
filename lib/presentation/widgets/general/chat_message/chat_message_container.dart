import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_read_by_bottom_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';

class ChatMessageContainer extends StatelessWidget {
  final List<UserEntity> users;
  final MessageEntity message;
  final String currentUserId;
  final MessageEntity? messageToReactTo;

  const ChatMessageContainer({
    super.key,
    required this.users,
    required this.message,
    required this.currentUserId,
    this.messageToReactTo,
  });

  UserEntity? findUser(String id) =>
      users.firstWhereOrNull((element) => element.id == id);

  @override
  Widget build(BuildContext context) {
    final UserEntity? foundUser =
        message.createdBy != null ? findUser(message.createdBy!) : null;

    final isCurrentUser = foundUser?.id == currentUserId;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return CupertinoContextMenu(
      actions: [
        CupertinoContextMenuAction(
          trailingIcon: Ionicons.book,
          child: const Text("gelesen von"),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            await showModalBottomSheet(
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              builder: (context) {
                return ChatMessageReadByBottomSheet(
                  users: users,
                  readByIds: message.readBy ?? [],
                );
              },
            );
          },
        ),
      ],
      child: SwipeTo(
        iconColor: Theme.of(context).colorScheme.onBackground,
        onRightSwipe: () {
          if (foundUser != null) {
            BlocProvider.of<AddMessageCubit>(context).reactToMessage(
              messageToReactToWithUser: MessageAndUserEntity(
                message: message,
                user: foundUser,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser) ...[
                  Text(
                    foundUser?.username ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                ],
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isCurrentUser
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (messageToReactTo != null) ...{
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ChatMessageReactMessageContainer(
                            messageAndUser: MessageAndUserEntity(
                              message: messageToReactTo!,
                              user: findUser(
                                    messageToReactTo!.createdBy ?? "",
                                  ) ??
                                  UserEntity(
                                    id: "",
                                    authId: "",
                                  ),
                            ),
                            currentUserId: currentUserId,
                            isInput: false,
                          ),
                        ),
                      },
                      if (message.fileLinks != null &&
                          message.fileLinks!.isNotEmpty) ...{
                        //TODO: as list of documents
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 2,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                message.fileLinks![0],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      },
                      if (message.message != null) ...{
                        if (message.fileLinks != null &&
                            message.fileLinks!.isNotEmpty) ...{
                          const SizedBox(height: 8),
                        },
                        Text(
                          message.message!,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      },
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat.jm().format(message.createdAt),
                  style: Theme.of(context).textTheme.labelMedium?.apply(
                      color: isDarkMode ? Colors.white54 : Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
