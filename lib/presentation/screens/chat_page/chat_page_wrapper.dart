import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class ChatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final GroupchatEntity? chatToSet;
  final bool loadChatFromApiToo;

  const ChatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    this.chatToSet,
    this.loadChatFromApiToo = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentChatCubit(
        CurrentChatState(
          currentUserLeftChat: false,
          currentUserIndex: -1,
          loadingPrivateEvents: false,
          loadingMessages: false,
          futureConnectedPrivateEvents: [],
          users: const [],
          leftUsers: const [],
          currentChat: chatToSet ?? GroupchatEntity(id: groupchatId),
          loadingChat: false,
        ),
        authCubit: BlocProvider.of<AuthCubit>(context),
        messageUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        privateEventUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        userCubit: BlocProvider.of<UserCubit>(context),
        chatCubit: BlocProvider.of<ChatCubit>(context),
        chatUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: BlocListener<CurrentChatCubit, CurrentChatState>(
        listener: (context, state) async {
          if (state.currentUserLeftChat == true) {
            AutoRouter.of(context).root.pop();
          }
          if (state.error != null && state.showError) {
            return await showDialog(
              context: context,
              builder: (c) {
                return CustomAlertDialog(
                  title: state.error!.title,
                  message: state.error!.message,
                  context: c,
                );
              },
            );
          }
        },
        child: Builder(builder: (context) {
          BlocProvider.of<CurrentChatCubit>(context).setGroupchatUsers();
          // TODO too get the users from the api too but more efficient soon
          BlocProvider.of<CurrentChatCubit>(context).getGroupchatUsersViaApi();

          if (chatToSet == null || loadChatFromApiToo) {
            BlocProvider.of<CurrentChatCubit>(context).getCurrentChatViaApi();
          }

          return const AutoRouter();
        }),
      ),
    );
  }
}
