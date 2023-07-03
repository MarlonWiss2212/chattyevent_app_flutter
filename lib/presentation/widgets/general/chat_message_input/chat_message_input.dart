import 'dart:ui';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_mesasage_input_text_field.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_files.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_react_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/add_chat_message_detail_dialog/add_chat_message_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageInput extends StatelessWidget {
  const ChatMessageInput({super.key});

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatMessageInputFiles(),
                      ChatMessageInputReactMessageContainer(),
                      ChatMessageInputTextField(),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              addButton(context),
              const SizedBox(width: 8),
              sendButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget addButton(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () async {
        await showAnimatedDialog(
          context: context,
          curve: Curves.fastOutSlowIn,
          animationType: DialogTransitionType.slideFromBottomFade,
          builder: (c) => AddChatMessageDetailDialog(c: context),
        );
      },
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface.withOpacity(.5),
            ),
            child: const Icon(Ionicons.add, size: 20),
          ),
        ),
      ),
    );
  }

  Widget sendButton(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => BlocProvider.of<AddMessageCubit>(context).createMessage(),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Ink(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface.withOpacity(.5),
            ),
            child: const Icon(Ionicons.send, size: 20),
          ),
        ),
      ),
    );
  }
}
