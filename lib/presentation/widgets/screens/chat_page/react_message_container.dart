import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/message/message_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/message_container.dart';

class ReactMessageContainer extends StatelessWidget {
  final String messageToReactTo;
  final bool? showImage;

  const ReactMessageContainer({
    super.key,
    required this.messageToReactTo,
    this.showImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return MessageContainer(
          showImage: showImage ?? true,
          message: state.currentChat.messages != null
              ? state.currentChat.messages!.firstWhere(
                  (element) => element.id == messageToReactTo,
                  orElse: () => MessageEntity(id: messageToReactTo),
                )
              : MessageEntity(id: messageToReactTo),
          currentUserId: Jwt.parseJwt(
              (BlocProvider.of<AuthCubit>(context).state as AuthLoaded)
                  .token)["sub"],
          usersWithGroupchatUserData: state.usersWithGroupchatUserData,
          usersWithLeftGroupchatUserData: state.usersWithLeftGroupchatUserData,
          showMessageReactTo: false,
        );
      },
    );
  }
}
