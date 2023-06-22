import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatMessageContainer extends StatelessWidget {
  final MessageAndUser messageAndUser;
  final String currentUserId;
  final MessageAndUser Function()? messageAndUserToReactTo;
  const ChatMessageContainer({
    super.key,
    required this.messageAndUser,
    this.messageAndUserToReactTo,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = messageAndUser.user.id == currentUserId;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SwipeTo(
      iconColor: Theme.of(context).colorScheme.onBackground,
      onRightSwipe: () => BlocProvider.of<AddMessageCubit>(context).emitState(
        messageToReactToWithUser: messageAndUser,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment:
              isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: isCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser) ...[
                    Text(
                      messageAndUser.user.username ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
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
                        if (messageAndUserToReactTo != null) ...{
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ChatMessageReactMessageContainer(
                              messageAndUser: messageAndUserToReactTo!(),
                              currentUserId: currentUserId,
                              isInput: false,
                            ),
                          ),
                        },
                        if (messageAndUser.message.fileLinks != null &&
                            messageAndUser.message.fileLinks!.isNotEmpty) ...{
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
                                  messageAndUser.message.fileLinks![0],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        },
                        if (messageAndUser.message.message != null) ...{
                          if (messageAndUser.message.fileLinks != null &&
                              messageAndUser.message.fileLinks!.isNotEmpty) ...{
                            const SizedBox(height: 8),
                          },
                          Text(
                            messageAndUser.message.message!,
                            overflow: TextOverflow.clip,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        },
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.jm().format(messageAndUser.message.createdAt),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
