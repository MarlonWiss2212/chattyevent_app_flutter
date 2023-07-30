import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/tab_chat/tab_chat_message_area.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';

@RoutePage()
class EventTabChat extends StatefulWidget {
  final String eventId;
  const EventTabChat({
    @PathParam('id') required this.eventId,
    super.key,
  });

  @override
  State<EventTabChat> createState() => _EventTabChatState();
}

class _EventTabChatState extends State<EventTabChat> {
  @override
  void initState() {
    BlocProvider.of<CurrentEventCubit>(context).loadMessages(
      reload: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMessageCubit(
        AddMessageState(eventTo: widget.eventId),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
        microphoneUseCases: serviceLocator(),
        locationUseCases: serviceLocator(),
        vibrationUseCases: serviceLocator(),
        messageUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        imagePickerUseCases: serviceLocator(),
        cubitToAddMessageTo: dz.Left(dz.Left(
          BlocProvider.of<CurrentEventCubit>(context),
        )),
      ),
      child: const Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TabChatMessageArea(),
          ),
          ChatMessageInput(),
        ],
      ),
    );
  }
}
