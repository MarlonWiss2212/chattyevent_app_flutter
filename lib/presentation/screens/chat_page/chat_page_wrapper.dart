import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_one_groupchat_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

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
      BlocProvider.of<CurrentChatCubit>(context).getOneChatViaApi(
        getOneGroupchatFilter: GetOneGroupchatFilter(id: groupchatId),
      );
    }

    return BlocListener<CurrentChatCubit, CurrentChatState>(
      listener: (context, state) async {
        if (state is CurrentChatError) {
          return await showPlatformDialog(
            context: context,
            builder: (context) {
              return PlatformAlertDialog(
                title: Text(state.title),
                content: Text(state.message),
                actions: const [OKButton()],
              );
            },
          );
        }
      },
      child: const AutoRouter(),
    );
  }
}
