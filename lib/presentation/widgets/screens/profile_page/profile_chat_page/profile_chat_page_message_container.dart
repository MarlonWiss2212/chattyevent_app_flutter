import 'package:chattyevent_app_flutter/application/bloc/add_message/add_message_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/message/message_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/chat_message/chat_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileChatPageMessageContainer extends StatelessWidget {
  const ProfileChatPageMessageContainer({
    Key? key,
    required this.message,
    required this.currentUserId,
  }) : super(key: key);

  final String currentUserId;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageCubit, ProfilePageState>(
      builder: (context, state) {
        return ChatMessageContainer(
          currentUserId: currentUserId,
          messageAndUser: MessageAndUser(
              message: message,
              user: message.createdBy == currentUserId
                  ? BlocProvider.of<AuthCubit>(context).state.currentUser
                  : state.user),
          messageAndUserToReactTo: message.messageToReactTo != null
              ? () {
                  final foundMessageToReactTo = state.messages.firstWhere(
                    (element) => element.id == message.messageToReactTo,
                    orElse: () => MessageEntity(
                      id: message.messageToReactTo ?? "",
                      createdAt: DateTime.now(),
                    ),
                  );
                  return MessageAndUser(
                    message: foundMessageToReactTo,
                    user: foundMessageToReactTo.createdBy == currentUserId
                        ? BlocProvider.of<AuthCubit>(context).state.currentUser
                        : state.user,
                  );
                }
              : null,
        );
      },
    );
  }
}
