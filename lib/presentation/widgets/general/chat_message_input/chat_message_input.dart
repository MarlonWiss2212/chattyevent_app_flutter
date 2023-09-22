import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_send_button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_text_field.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_current_location.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_files.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_react_message_container.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input_voice_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';

class ChatMessageInput extends StatelessWidget {
  const ChatMessageInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      buildWhen: (previous, current) =>
          current.status == AddMessageStateStatus.success,
      builder: (context, state) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatMessageInputFiles(),
                      ChatMessageInputCurrentLocation(),
                      ChatMessageInputVoiceMessage(),
                      ChatMessageInputReactMessageContainer(),
                      ChatMessageInputTextField(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8),
              ChatMessageInputSendButton(),
            ],
          ),
        );
      },
    );
  }
}
