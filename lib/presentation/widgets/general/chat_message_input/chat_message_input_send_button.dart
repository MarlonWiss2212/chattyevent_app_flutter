import 'dart:ui';

import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageInputSendButton extends StatelessWidget {
  const ChatMessageInputSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      customBorder: const CircleBorder(),
      child: GestureDetector(
        onTap: () => BlocProvider.of<AddMessageCubit>(context).createMessage(),
        onLongPress: () {
          BlocProvider.of<AddMessageCubit>(context)
              .startRecordingVoiceMessage();
        },
        onLongPressUp: () {
          BlocProvider.of<AddMessageCubit>(context)
              .stopRecordingVoiceMessageAndEmitIt();
        },
        onLongPressEnd: (details) {
          BlocProvider.of<AddMessageCubit>(context)
              .stopRecordingVoiceMessageAndEmitIt();
        },
        behavior: HitTestBehavior.translucent,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Material(
              color: Colors.transparent,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: BlocBuilder<AddMessageCubit, AddMessageState>(
                  builder: (context, state) {
                    return StreamBuilder(
                      stream: state.isRecordingVoiceMessageStream,
                      builder: (context, snapshot) {
                        return Ink(
                          width: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? 100
                              : 50,
                          height: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? 100
                              : 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context)
                                .colorScheme
                                .surface
                                .withOpacity(.6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: snapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const [
                                    Icon(Ionicons.mic, size: 50),
                                  ]
                                : const [
                                    Icon(Ionicons.send, size: 10),
                                    Text("/"),
                                    Icon(Ionicons.mic, size: 10),
                                  ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
