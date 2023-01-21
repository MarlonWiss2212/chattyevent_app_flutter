import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/chat_page/chat_info_page/chat_info_page_details.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    // should get the private events for this chat in future for more effeciancy
    BlocProvider.of<PrivateEventCubit>(context).getPrivateEventsViaApi();

    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        GroupchatEntity? foundGroupchat =
            BlocProvider.of<ChatCubit>(context).getGroupchatById(
          groupchatId: groupchatId,
        );

        Widget body;

        if (foundGroupchat == null) {
          body = Expanded(
            child: Center(
              child:
                  Text("Fehler beim Laden des Chats mit der Id $groupchatId"),
            ),
          );
        } else {
          body = ChatInfoPageDetails(groupchat: foundGroupchat);
        }

        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Hero(
              tag: "$groupchatId title",
              child: Text(
                foundGroupchat != null && foundGroupchat.title != null
                    ? foundGroupchat.title!
                    : "Kein Titel",
              ),
            ),
          ),
          body: BlocBuilder<CurrentChatCubit, CurrentChatState>(
            builder: (context, state) {
              if (state is CurrentChatLoading) {
                return Center(child: PlatformCircularProgressIndicator());
              }
              return body;
            },
          ),
        );
      },
    );
  }
}
