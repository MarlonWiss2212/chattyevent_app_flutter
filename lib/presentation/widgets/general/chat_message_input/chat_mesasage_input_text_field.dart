import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ChatMessageInputTextField extends StatefulWidget {
  const ChatMessageInputTextField({super.key});

  @override
  State<ChatMessageInputTextField> createState() =>
      _ChatMessageInputTextFieldState();
}

class _ChatMessageInputTextFieldState extends State<ChatMessageInputTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMessageCubit, AddMessageState>(
      listener: (context, state) =>
          state.status == AddMessageStateStatus.success
              ? textEditingController.clear()
              : null,
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(minHeight: 40),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: state.messageToReactTo != null
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )
                : BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: PlatformTextField(
            controller: textEditingController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 6,
            style: Theme.of(context).textTheme.bodyMedium,
            material: (context, platform) => MaterialTextFieldData(
              decoration: const InputDecoration.collapsed(
                hintText: "Nachricht",
              ),
            ),
            onChanged: (p0) {
              BlocProvider.of<AddMessageCubit>(context).emitState(message: p0);
            },
            hintText: 'Nachricht',
          ),
        );
      },
    );
  }
}
