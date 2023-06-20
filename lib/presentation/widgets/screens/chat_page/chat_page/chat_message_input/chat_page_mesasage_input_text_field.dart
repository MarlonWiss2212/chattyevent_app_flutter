import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ChatPageMessageInputTextField extends StatefulWidget {
  const ChatPageMessageInputTextField({super.key});

  @override
  State<ChatPageMessageInputTextField> createState() =>
      _ChatPageMessageInputTextFieldState();
}

class _ChatPageMessageInputTextFieldState
    extends State<ChatPageMessageInputTextField> {
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
          decoration: BoxDecoration(
            borderRadius: state.messageToReactTo != null
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )
                : BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
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
                BlocProvider.of<AddMessageCubit>(context)
                    .emitState(message: p0);
              },
              hintText: 'Nachricht',
            ),
          ),
        );
      },
    );
  }
}
