import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageReactMessageContainer extends StatelessWidget {
  const ChatMessageReactMessageContainer({
    Key? key,
    required this.messageAndUser,
    required this.currentUserId,
    required this.isInput,
  }) : super(key: key);

  final bool isInput;
  final String currentUserId;
  final MessageAndUser messageAndUser;

  @override
  Widget build(BuildContext context) {
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
                color: messageAndUser.user.id == currentUserId
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
                          messageAndUser.user.username != null
                              ? messageAndUser.user.username!
                              : "",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(DateFormat.jm()
                                .format(messageAndUser.message.createdAt)),
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
                    if (messageAndUser.message.fileLinks != null &&
                        messageAndUser.message.fileLinks!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.file_copy),
                          SizedBox(width: 2),
                          Text("Dateien"),
                        ],
                      ),
                    ],
                    if (messageAndUser.message.fileLinks != null &&
                        messageAndUser.message.fileLinks!.isNotEmpty) ...{
                      const SizedBox(height: 8),
                    },
                    if (messageAndUser.message.message != null) ...{
                      Text(
                        messageAndUser.message.message!,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
