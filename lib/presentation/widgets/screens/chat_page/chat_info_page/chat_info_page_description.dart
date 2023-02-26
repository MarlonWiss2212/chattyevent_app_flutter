import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';

class ChatInfoPageDescription extends StatelessWidget {
  const ChatInfoPageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      buildWhen: (previous, current) {
        if (previous.currentChat.description !=
            current.currentChat.description) {
          return true;
        }
        if (previous.loadingChat != current.loadingChat) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state.currentChat.description == null && state.loadingChat) {
          return const SkeletonLine();
        }

        final String? description = state.currentChat.description;
        return Text(
          description != null && description.isNotEmpty
              ? description
              : "Keine Beschreibung",
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
