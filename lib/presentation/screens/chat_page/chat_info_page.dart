import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/chat_page/chat_info_page/chat_info_page_details.dart';

class ChatInfoPage extends StatelessWidget {
  const ChatInfoPage({@PathParam('id') required this.groupchatId, super.key});
  final String groupchatId;

  @override
  Widget build(BuildContext context) {
    // should get the private events for this chat in future for more effeciancy
    BlocProvider.of<CurrentChatCubit>(context).getPrivateEventsViaApi();

    return BlocBuilder<CurrentChatCubit, CurrentChatState>(
      builder: (context, state) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            title: Hero(
              tag: "$groupchatId title",
              child: Text(
                state.currentChat.title != null
                    ? state.currentChat.title!
                    : "Kein Titel",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          body: state.loadingChat && state.currentChat.id == ""
              ? Center(child: PlatformCircularProgressIndicator())
              : state.currentChat.id != ""
                  ? Column(
                      children: [
                        if (state.loadingChat) ...{
                          const LinearProgressIndicator(),
                        },
                        Expanded(
                          child: ChatInfoPageDetails(chatState: state),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        "Fehler beim Laden des Chats mit der Id",
                        textAlign: TextAlign.center,
                      ),
                    ),
        );
      },
    );
  }
}
