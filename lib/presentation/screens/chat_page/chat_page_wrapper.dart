import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/home_page.dart';
import 'package:chattyevent_app_flutter/presentation/screens/home_page/pages/home_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';

class ChatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final CurrentChatState chatStateToSet;

  const ChatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    required this.chatStateToSet,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentChatCubit(
            chatStateToSet,
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            authCubit: BlocProvider.of<AuthCubit>(context),
            groupchatMessageUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            privateEventUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            chatCubit: BlocProvider.of<ChatCubit>(context),
            groupchatUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
          )..reloadGroupchatAndGroupchatUsersViaApi(),
        ),
        BlocProvider.value(
          value: UserSearchCubit(
            authCubit: BlocProvider.of<AuthCubit>(context),
            userRelationUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            userUseCases: serviceLocator(
              param1: BlocProvider.of<AuthCubit>(context).state,
            ),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentChatCubit, CurrentChatState>(
                listener: (context, state) async {
                  if (state.currentUserLeftChat == true) {
                    AutoRouter.of(context).root.replace(const HomePageRoute());
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
