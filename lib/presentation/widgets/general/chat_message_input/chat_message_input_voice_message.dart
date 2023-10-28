import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container_voice_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dartz/dartz.dart' as dz;

class ChatMessageInputVoiceMessage extends StatelessWidget {
  const ChatMessageInputVoiceMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: BlocBuilder<AddMessageCubit, AddMessageState>(
        buildWhen: (p, c) => p.voiceMessage?.path != c.voiceMessage?.path,
        builder: (context, state) {
          if (state.voiceMessage != null) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 110,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "general.chatMessageInput.voiceMessage.title",
                                style: Theme.of(context).textTheme.labelLarge,
                              ).tr(),
                              Expanded(
                                child: ChatMessageContainerVoiceMessage(
                                  key: ObjectKey(state.voiceMessage),
                                  voiceMessage:
                                      dz.Right(state.voiceMessage!.path),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () =>
                                  BlocProvider.of<AddMessageCubit>(context)
                                      .emitState(removeVoiceMessage: true),
                              child: const Icon(Ionicons.close),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
