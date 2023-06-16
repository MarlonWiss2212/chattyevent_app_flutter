import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_left_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class ChatPageReactMessageContainer extends StatelessWidget {
  const ChatPageReactMessageContainer({
    Key? key,
    required this.message,
    required this.currentUserId,
    required this.users,
    required this.leftUsers,
    required this.isInput,
  }) : super(key: key);

  final bool isInput;
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: isInput
                ? const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )
                : BorderRadius.circular(8),
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? const Color.fromARGB(40, 255, 255, 255)
                : const Color.fromARGB(40, 0, 0, 0),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                color: user.id == currentUserId
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize:
                          isInput ? MainAxisSize.max : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.username != null ? user.username! : "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(DateFormat.jm().format(message.createdAt)),
                            const SizedBox(width: 8),
                            if (isInput) ...{
                              GestureDetector(
                                onTap: () =>
                                    BlocProvider.of<AddMessageCubit>(context)
                                        .emitState(
                                  removeMessageToReactTo: true,
                                ),
                                child: const Icon(Ionicons.close),
                              )
                            }
                          ],
                        )
                      ],
                    ),
                    if (message.fileLinks != null &&
                        message.fileLinks!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.file_copy),
                          SizedBox(width: 2),
                          Text("Dateien"),
                        ],
                      ),
                    ],
                    if (message.fileLinks != null &&
                        message.fileLinks!.isNotEmpty) ...{
                      const SizedBox(height: 8),
                    },
                    if (message.message != null) ...{
                      Text(message.message!, overflow: TextOverflow.ellipsis),
                    },
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
