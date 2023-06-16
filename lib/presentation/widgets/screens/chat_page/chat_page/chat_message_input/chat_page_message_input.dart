import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_message_input/chat_page_mesasage_input_text_field.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_message_input/chat_page_message_input_files.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_message_input/chat_page_message_input_react_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/bottom_sheet/image_picker_list.dart';
import 'package:ionicons/ionicons.dart';

class ChatPageMessageInput extends StatelessWidget {
  const ChatPageMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      buildWhen: (previous, current) =>
          current.status == AddMessageStateStatus.success,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                child: Column(
                  children: [
                    ChatPageMessageInputFiles(),
                    ChatPageMessageInputReactMessageContainer(),
                    ChatPageMessageInputTextField(),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    builder: (modalContext) {
                      return ImagePickerList(
                        imageChanged: (newImage) {
                          BlocProvider.of<AddMessageCubit>(context)
                              .emitState(file: newImage);
                          Navigator.of(modalContext).pop();
                        },
                      );
                    },
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Ionicons.camera,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () =>
                    BlocProvider.of<AddMessageCubit>(context).createMessage(),
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Ionicons.send,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
