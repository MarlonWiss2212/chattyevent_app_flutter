import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/message/message_bloc.dart';
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
              child: TextField(
                controller: messageInputController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Nachricht',
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // send button
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith(
                (states) => const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            onPressed: () {
              BlocProvider.of<MessageBloc>(context).add(
                MessageCreateEvent(
                  createMessageDto: CreateMessageDto(
                    groupchatTo: widget.groupchatTo,
                    message: messageInputController.text,
                  ),
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
