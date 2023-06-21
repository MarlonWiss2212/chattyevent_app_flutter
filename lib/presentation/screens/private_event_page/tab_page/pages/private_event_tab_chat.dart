import 'package:auto_route/annotations.dart';
import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message_input/chat_message_input.dart';
//import 'package:chattyevent_app_flutter/presentation/widgets/screens/chat_page/chat_page/chat_page_message_area.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';

class PrivateEventTabChat extends StatelessWidget {
  final String privateEventId;
  const PrivateEventTabChat({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AddMessageCubit(AddMessageState(privateEventTo: privateEventId),
          notificationCubit: BlocProvider.of<NotificationCubit>(context),
          messageUseCases: serviceLocator(
            param1: BlocProvider.of<AuthCubit>(context).state,
          ),
          imagePickerUseCases: serviceLocator(),
          cubitToAddMessageTo: Left(Left(
            BlocProvider.of<CurrentPrivateEventCubit>(context),
          ))),
      child: const Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Placeholder(), //ChatPageMessageArea(),
            ),
          ),
          ChatMessageInput(),
        ],
      ),
    );
  }
}
