import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_cubit.dart';
import 'package:social_media_app_flutter/domain/dto/create_message_dto.dart';

class MessageInput extends StatefulWidget {
  final String groupchatTo;
  const MessageInput({super.key, required this.groupchatTo});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final messageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          // input area
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: PlatformTextField(
                material: (context, platform) => MaterialTextFieldData(
                  decoration:
                      const InputDecoration.collapsed(hintText: "Nachricht"),
                ),
                controller: messageInputController,
                hintText: 'Nachricht',
              ),
            ),
          ),
          const SizedBox(width: 8),
          // send button
          PlatformTextButton(
            // ios style missing
            material: ((context, platform) => MaterialTextButtonData(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                      (states) => const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) =>
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                )),
            onPressed: () {
              BlocProvider.of<MessageCubit>(context).createMessage(
                createMessageDto: CreateMessageDto(
                  groupchatTo: widget.groupchatTo,
                  message: messageInputController.text,
                ),
              );
            },
            child: const Center(
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
