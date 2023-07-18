import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/tab_chat/tab_chat_message_area.dart';
import 'package:dartz/dartz.dart' as dz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';

@RoutePage()
class PrivateEventTabChat extends StatefulWidget {
  final String privateEventId;
  const PrivateEventTabChat({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  State<PrivateEventTabChat> createState() => _PrivateEventTabChatState();
}

class _PrivateEventTabChatState extends State<PrivateEventTabChat> {
  @override
  void initState() {
    BlocProvider.of<CurrentPrivateEventCubit>(context).loadMessages(
      reload: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMessageCubit(
        AddMessageState(privateEventTo: widget.privateEventId),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
        microphoneUseCases: serviceLocator(),
        locationUseCases: serviceLocator(),
        vibrationUseCases: serviceLocator(),
        messageUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        imagePickerUseCases: serviceLocator(),
        cubitToAddMessageTo: dz.Left(dz.Left(
          BlocProvider.of<CurrentPrivateEventCubit>(context),
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
