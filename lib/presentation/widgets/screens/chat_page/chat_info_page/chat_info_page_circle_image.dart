import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/circle_image/cirlce_image.dart';

class ChatInfoPageCircleImage extends StatelessWidget {
  const ChatInfoPageCircleImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (p, c) =>
          p.currentChat.profileImageLink != c.currentChat.profileImageLink,
      builder: (context, state) {
        return CircleImage(imageLink: state.currentChat.profileImageLink);
      },
    );
  }
}
