import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPageMessageContainer extends StatelessWidget {
  const ChatPageMessageContainer({
    Key? key,
    required this.message,
    required this.currentUserId,
    required this.users,
    required this.leftUsers,
  }) : super(key: key);

  final String currentUserId;
  final List<UserEntity> users;
  final List<UserEntity> leftUsers;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    late UserEntity user;
    final foundUser = users.firstWhereOrNull(
      (element) => element.id == message.createdBy,
    );
    if (foundUser == null) {
      final foundLeftUser = leftUsers.firstWhereOrNull(
        (element) => element.id == message.createdBy,
      );
      if (foundLeftUser != null) {
        user = foundLeftUser;
      } else {
        user = UserEntity(id: message.createdBy ?? "", authId: "");
      }
    } else {
      user = foundUser;
    }

    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isCurrentUser = user.id == currentUserId;

    return SwipeTo(
      iconColor: Theme.of(context).colorScheme.onBackground,
      onRightSwipe: () => BlocProvider.of<AddMessageCubit>(context).emitState(
        messageToReactTo: message,
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
                      user.username ?? "",
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
                        if (message.messageToReactTo != null) ...{
                          BlocBuilder<CurrentGroupchatCubit,
                              CurrentGroupchatState>(
                            builder: (context, state) {
                              final foundMessage =
                                  state.messages.firstWhereOrNull(
                                (element) =>
                                    element.id == message.messageToReactTo,
                              );
                              if (foundMessage != null) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ChatPageReactMessageContainer(
                                    message: foundMessage,
                                    users: users,
                                    leftUsers: leftUsers,
                                    currentUserId: currentUserId,
                                    isInput: false,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        },
                        if (message.fileLinks != null &&
                            message.fileLinks!.isNotEmpty) ...{
                          Container(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height / 2,
                            ),
                            child: Image.network(
                              message.fileLinks![0],
                              fit: BoxFit.contain,
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
