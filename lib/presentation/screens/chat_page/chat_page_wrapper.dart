import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';

class ChatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final bool loadChat;

  const ChatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    this.loadChat = true,
  });

  @override
  Widget build(BuildContext context) {
    if (loadChat) {
      BlocProvider.of<ChatCubit>(context).getOneChat(
        getOneGroupchatFilter: GetOneGroupchatFilter(id: groupchatId),
      );
    }

    return const AutoRouter();
  }
}
