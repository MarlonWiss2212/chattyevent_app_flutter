import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_bloc.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/details.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      GroupchatEntity? foundGroupchat;
      if (state is ChatStateLoaded) {
        for (final chat in state.chats) {
          if (chat.id == groupchatId) {
            foundGroupchat = chat;
            break;
          }
        }
      }

      Widget body;

      if (foundGroupchat == null) {
        body = Expanded(
          child: Center(
            child: Text("Fehler beim Laden des Chats mit der Id $groupchatId"),
          ),
        );
      } else {
        body = Details(groupchat: foundGroupchat);
      }

      return PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text("Info Page"),
        ),
        body: body,
      );
    });
  }
}
