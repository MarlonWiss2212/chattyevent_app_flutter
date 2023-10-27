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
        onLongPressEnd: (_) {
          BlocProvider.of<AddMessageCubit>(context)
              .stopRecordingVoiceMessageAndEmitIt();
        },
        behavior: HitTestBehavior.translucent,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Material(color: Colors.transparent, child: _animatedStuff()),
          ),
        ),
      ),
    );
  }

  Widget _animatedStuff() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: BlocBuilder<AddMessageCubit, AddMessageState>(
        builder: (context, state) {
          return StreamBuilder(
            stream: state.isRecordingVoiceMessageStream,
            builder: (context, snapshot) {
              final Duration duration =
                  snapshot.hasData ? snapshot.data!.duration : Duration.zero;

              String twoDigits(int n) => n.toString().padLeft(2);
              final twoDigitsMin = twoDigits(duration.inMinutes.remainder(60));
              final twoDigitsSec = twoDigits(duration.inSeconds.remainder(60));

              return Ink(
                width: snapshot.connectionState == ConnectionState.waiting
                    ? 100
                    : 50,
                height: snapshot.connectionState == ConnectionState.waiting
                    ? 100
                    : 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: snapshot.connectionState == ConnectionState.waiting
                      ? Theme.of(context).colorScheme.surface.withOpacity(.8)
                      : Theme.of(context).colorScheme.surface.withOpacity(.6),
                ),
                child: snapshot.connectionState == ConnectionState.waiting
                    ? Column(
                        children: [
                          const Icon(Ionicons.mic, size: 50),
                          const SizedBox(height: 10),
                          Text("$twoDigitsMin:$twoDigitsSec"),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
    );
  }
}
