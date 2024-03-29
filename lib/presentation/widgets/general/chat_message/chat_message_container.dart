import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container_bottom_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container_main_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_bottom_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';

class ChatMessageContainer extends StatefulWidget {
  final List<UserEntity> users;
  final MessageEntity message;
  final int usersCount;
  final String currentUserId;
  final Future<void> Function(String id) deleteMessage;

  const ChatMessageContainer({
    super.key,
    required this.users,
    required this.deleteMessage,
    required this.usersCount,
    required this.message,
    required this.currentUserId,
  });

  @override
  State<ChatMessageContainer> createState() => _ChatMessageContainerState();
}

class _ChatMessageContainerState extends State<ChatMessageContainer> {
  double scale = 1;
  UserEntity? findUser(String id) => widget.users.firstWhereOrNull(
        (element) => element.id == id,
      );

  @override
  Widget build(BuildContext context) {
    final UserEntity? foundUser = findUser(widget.message.createdBy);

    final isCurrentUser = foundUser?.id == widget.currentUserId;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 100),
      child: SwipeTo(
        iconColor: Theme.of(context).colorScheme.onBackground,
        onRightSwipe: () {
          if (foundUser != null) {
            BlocProvider.of<AddMessageCubit>(context).reactToMessage(
              messageToReactToWithUser: MessageAndUserEntity(
                message: widget.message,
                user: foundUser,
              ),
            );
          }
        },
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
              GestureDetector(
                onTapDown: (details) async {
                  setState(() {
                    scale = .9;
                  });
                },
                onTapUp: (details) => setState(() {
                  scale = 1;
                }),
                onTapCancel: () => setState(() {
                  scale = 1;
                }),
                onLongPress: () async {
                  await serviceLocator<VibrationUseCases>().vibrate(
                    duration: 50,
                    intensity: 80,
                  );
                  // ignore: use_build_context_synchronously
                  showModalBottomSheet(
                    context: context,
                    builder: (closeContext) => ChatMessageBottomDialog(
                      closeContext: closeContext,
                      users: widget.users,
                      message: widget.message,
                      currentUserId: widget.currentUserId,
                      deleteMessage: widget.deleteMessage,
                    ),
                  );
                },
                child: ChatMessageContainerMainContainer(
                  currentUserId: widget.currentUserId,
                  isCurrentUser: isCurrentUser,
                  message: widget.message,
                  users: widget.users,
                ),
              ),
              const SizedBox(height: 4),
              ChatMessageContainerBottomContainer(
                usersCount: widget.usersCount,
                isCurrentUser: isCurrentUser,
                message: widget.message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
