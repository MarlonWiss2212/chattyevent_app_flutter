import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_to_react_to_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_react_message_container.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageInputReactMessageContainer extends StatelessWidget {
  const ChatMessageInputReactMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMessageCubit, AddMessageState>(
      builder: (context, state) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: state.messageToReactToWithUser != null
              ? Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: ChatMessageReactMessageContainer(
                    messageToReactTo: MessageToReactToEntity.fromMessageEntity(
                      message: state.messageToReactToWithUser!.message,
                    ),
                    usersOrNotificationText: Right(
                      state.messageToReactToWithUser?.notificationText,
                    ),
                    user: state.messageToReactToWithUser!.user,
                    isInput: true,
                    currentUserId: BlocProvider.of<AuthCubit>(context)
                        .state
                        .currentUser
                        .id,
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
