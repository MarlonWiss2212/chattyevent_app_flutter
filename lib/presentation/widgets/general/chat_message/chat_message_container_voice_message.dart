import 'package:audioplayers/audioplayers.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/usecases/audio_player_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageContainerVoiceMessage extends StatefulWidget {
  final String voiceMessageLink;
  const ChatMessageContainerVoiceMessage({
    super.key,
    required this.voiceMessageLink,
  });

  @override
  State<ChatMessageContainerVoiceMessage> createState() =>
      _ChatMessageContainerVoiceMessageState();
}

class _ChatMessageContainerVoiceMessageState
    extends State<ChatMessageContainerVoiceMessage> {
  final AudioPlayerUseCases audioPlayerUseCases = serviceLocator();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    audioPlayerUseCases.setAudioViaUrl(
      url: widget.voiceMessageLink,
    );

    audioPlayerUseCases.onPlayerChanged().fold(
      (alert) {
        BlocProvider.of<NotificationCubit>(context).newAlert(
          notificationAlert: alert,
        );
      },
      (stream) => stream.listen((event) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }),
    );

    audioPlayerUseCases.onDurationChanged().fold(
      (alert) {
        BlocProvider.of<NotificationCubit>(context).newAlert(
          notificationAlert: alert,
        );
      },
      (stream) => stream.listen((newDuration) {
        setState(() => duration = newDuration);
      }),
    );

    audioPlayerUseCases.onPositionChanged().fold(
      (alert) {
        BlocProvider.of<NotificationCubit>(context).newAlert(
          notificationAlert: alert,
        );
      },
      (stream) => stream.listen((newPosition) {
        setState(() => position = newPosition);
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    audioPlayerUseCases.closePlayer();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(isPlaying ? Ionicons.pause : Ionicons.play),
          onPressed: () async {
            if (isPlaying) {
              final res = await audioPlayerUseCases.pausePlaying();
              res.fold(
                (alert) {
                  BlocProvider.of<NotificationCubit>(context).newAlert(
                    notificationAlert: alert,
                  );
                },
                (r) => null,
              );
            } else {
              final res = await audioPlayerUseCases.resume();
              res.fold(
                (alert) {
                  BlocProvider.of<NotificationCubit>(context).newAlert(
                    notificationAlert: alert,
                  );
                },
                (r) => null,
              );
            }
          },
        ),
        Column(
          children: [
            Slider.adaptive(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final res = await audioPlayerUseCases.seek(
                  position: Duration(seconds: value.toInt()),
                );
                res.fold(
                  (alert) {
                    BlocProvider.of<NotificationCubit>(context).newAlert(
                      notificationAlert: alert,
                    );
                  },
                  (r) => null,
                );
              },
            ),
            Wrap(
              spacing: 50,
              children: [
                Text(formatTime(position)),
                Text(formatTime(duration)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
