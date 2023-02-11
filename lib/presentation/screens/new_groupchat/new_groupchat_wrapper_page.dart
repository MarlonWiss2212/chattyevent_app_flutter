import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/chat/add_chat_cubit.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class NewGroupchatWrapperPage extends StatelessWidget {
  const NewGroupchatWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddChatCubit, AddChatState>(
      listener: (context, state) async {
        if (state is AddChatLoaded) {
          AutoRouter.of(context).root.replace(
                ChatPageWrapperRoute(
                  groupchatId: state.addedChat.id,
                  loadChatFromApiToo: false,
                  chatToSet: state.addedChat,
                ),
              );
        } else if (state is AddChatError) {
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
