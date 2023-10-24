import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:chattyevent_app_flutter/domain/usecases/message_usecases.dart';
import 'package:chattyevent_app_flutter/domain/usecases/vibration_usecases.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container_bottom_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_read_by_bottom_dialog.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_and_user_entity.dart';

class ChatMessageNotificationContainer extends StatefulWidget {
  final List<UserEntity> users;
  final MessageEntity message;
  final int usersCount;
  final String currentUserId;

  const ChatMessageNotificationContainer({
    super.key,
    required this.users,
    required this.usersCount,
    required this.message,
    required this.currentUserId,
  });

  @override
  State<ChatMessageNotificationContainer> createState() =>
      _ChatMessageNotificationContainerState();
}

class _ChatMessageNotificationContainerState
    extends State<ChatMessageNotificationContainer> {
  final MessageUseCases messageUseCases = authenticatedLocator();

  double scale = 1;

  UserEntity? findUser(String id) => widget.users.firstWhereOrNull(
        (element) => element.id == id,
      );

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.8;

    final UserEntity? createdBy = findUser(widget.message.createdBy);

    late String notificationText = messageUseCases.translateCustomMessage(
      message: dz.Left(widget.message),
      isGroupchatMessage: widget.message.groupchatTo != null,
      users: widget.users,
      createdBy: createdBy,
      affectedId: widget.message.typeActionAffectedUserId,
    );

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: SwipeTo(
          iconColor: Theme.of(context).colorScheme.onBackground,
          onRightSwipe: () {
            if (createdBy != null) {
              BlocProvider.of<AddMessageCubit>(context).reactToMessage(
                messageToReactToWithUser: MessageAndUserEntity(
                  message: widget.message,
                  user: createdBy,
                  notificationText: notificationText,
                ),
              );
            }
          },
          child: Column(
            children: [
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
                    amplitude: 80,
                  );
                  // ignore: use_build_context_synchronously
                  showModalBottomSheet(
                    context: context,
                    builder: (closeContext) => ChatMessageReadByBottomDialog(
                      closeContext: closeContext,
                      users: widget.users,
                      readByIds: widget.message.readBy,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Text(
                    notificationText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ChatMessageContainerBottomContainer(
                usersCount: widget.usersCount,
                isCurrentUser: true,
                message: widget.message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
