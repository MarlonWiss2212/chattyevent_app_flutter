import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/current_chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class ChatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final CurrentChatState chatStateToSet;
  final bool loadChatFromApiToo;

  const ChatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    required this.chatStateToSet,
    this.loadChatFromApiToo = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentChatCubit(
        chatStateToSet,
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
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
      child: Builder(
        builder: (context) {
          BlocProvider.of<CurrentChatCubit>(context).getGroupchatUsersViaApi();
          if (loadChatFromApiToo) {
            BlocProvider.of<CurrentChatCubit>(context).getCurrentChatViaApi();
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentChatCubit, CurrentChatState>(
                listener: (context, state) async {
                  if (state.currentUserLeftChat == true) {
                    AutoRouter.of(context).root.pop();
                  }
                },
              ),
            ],
            child: const AutoRouter(),
          );
        },
      ),
    );
  }
}
