import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/add_groupchat_message_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_react_message_container.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPageMessageContainer extends StatelessWidget {
  const ChatPageMessageContainer({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.users,
    required this.leftUsers,
  });

  final String currentUserId;
  final List<UserEntity> users;
  final List<UserEntity> leftUsers;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    late UserEntity user;
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
      mainAxisAlignment: user.id == currentUserId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        SwipeTo(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onRightSwipe: () =>
              BlocProvider.of<AddGroupchatMessageCubit>(context).emitState(
            messageToReactTo: message,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.1,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: user.id == currentUserId
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
              color: user.id == currentUserId
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // OPTIMIZE
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user.username != null ? user.username! : "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(DateFormat.jm().format(message.createdAt)),
                  ],
                ),
                if (message.fileLinks != null &&
                    message.fileLinks!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: (MediaQuery.of(context).size.height / 2),
                    ),
                    //TODO show as list because of multiple messages
                    child: Image.network(
                      message.fileLinks![0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
                if (message.messageToReactTo != null) ...{
                  BlocBuilder<CurrentChatCubit, CurrentChatState>(
                    builder: (context, state) {
                      final foundMessage = state.messages.firstWhereOrNull(
                        (element) => element.id == message.messageToReactTo,
                      );
                      if (foundMessage != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
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
                if (message.message != null) ...[
                  if (message.fileLinks != null &&
                      message.fileLinks!.isNotEmpty) ...{
                    const SizedBox(height: 8),
                  },
                  Text(message.message!, overflow: TextOverflow.clip),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
