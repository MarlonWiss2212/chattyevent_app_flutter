import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPageMessageContainer extends StatelessWidget {
  const ChatPageMessageContainer({
    Key? key,
    required this.message,
    required this.currentUserId,
  }) : super(key: key);

  final String currentUserId;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupchatCubit, CurrentGroupchatState>(
      builder: (context, state) {
        late UserEntity user;
        final foundUser = state.users.firstWhereOrNull(
          (element) => element.id == message.createdBy,
        );
        if (foundUser == null) {
          final foundLeftUser = state.leftUsers.firstWhereOrNull(
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

        return ChatMessageContainer(
          currentUserId: currentUserId,
          messageAndUser: MessageAndUser(message: message, user: user),
          messageAndUserToReactTo: message.messageToReactTo != null
              ? () {
                  final foundMessageToReactTo = state.messages.firstWhere(
                    (element) => element.id == message.messageToReactTo,
                    orElse: () => MessageEntity(
                      id: message.messageToReactTo ?? "",
                      createdAt: DateTime.now(),
                    ),
                  );
                  late UserEntity userToReactTo;
                  var foundUserToReactTo = state.users.firstWhereOrNull(
                    (element) => element.id == foundMessageToReactTo.createdBy,
                  );
                  if (foundUserToReactTo == null) {
                    final foundLeftUserToReactTo =
                        state.leftUsers.firstWhereOrNull(
                      (element) =>
                          element.id == foundMessageToReactTo.createdBy,
                    );
                    if (foundLeftUserToReactTo != null) {
                      userToReactTo = foundLeftUserToReactTo;
                    } else {
                      userToReactTo = UserEntity(
                        id: foundMessageToReactTo.createdBy ?? "",
                        authId: "",
                      );
                    }
                  } else {
                    userToReactTo = foundUserToReactTo;
                  }

                  return MessageAndUser(
                    message: foundMessageToReactTo,
                    user: userToReactTo,
                  );
                }
              : null,
        );
      },
    );
  }
}
