import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/core/extensions/list_space_between_extension.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageReactMessageContainer extends StatelessWidget {
  final bool isInput;
  final String currentUserId;
  final MessageToReactToEntity messageToReactTo;
  final UserEntity user;

  const ChatMessageReactMessageContainer({
    Key? key,
    required this.user,
    required this.messageToReactTo,
    required this.currentUserId,
    required this.isInput,
  }) : super(key: key);

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
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  color: user.id == currentUserId
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.username ?? "",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                DateFormat.jm().format(
                                  messageToReactTo.createdAt,
                                ),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
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
                      if (messageToReactTo.fileLinks != null &&
                          messageToReactTo.fileLinks!.isNotEmpty) ...[
                        Row(
                          children: [
                            const Icon(Icons.file_copy),
                            const SizedBox(width: 2),
                            Text(
                              "general.chatMessage.reactMessageContainer.filesText",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ],
                        ),
                      ],
                      if (messageToReactTo.currentLocation != null) ...[
                        Row(
                          children: [
                            const Icon(Ionicons.map),
                            const SizedBox(width: 2),
                            Text(
                              "general.chatMessage.reactMessageContainer.currentLocationText",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ],
                        ),
                      ],
                      if (messageToReactTo.voiceMessageLink != null) ...{
                        Row(
                          children: [
                            const Icon(Ionicons.play),
                            const SizedBox(width: 2),
                            Text(
                              "general.chatMessage.reactMessageContainer.audioText",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ).tr(),
                          ],
                        ),
                      },
                      if (messageToReactTo.message != null) ...{
                        Text(
                          messageToReactTo.message!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      },
                    ].withSpaceBetween(height: 8),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
