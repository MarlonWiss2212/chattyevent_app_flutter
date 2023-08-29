import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/groupchat/groupchat_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_groupchat/current_chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';

@RoutePage()
class GroupchatPageWrapper extends StatelessWidget {
  final String groupchatId;
  final GroupchatEntity? groupchat;

  const GroupchatPageWrapper({
    super.key,
    @PathParam('id') required this.groupchatId,
    this.groupchat,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrentGroupchatCubit(
            CurrentGroupchatState.fromGroupchat(
              groupchat: groupchat ?? GroupchatEntity(id: groupchatId),
            ),
            messageStreamCubit: BlocProvider.of<MessageStreamCubit>(context),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
            authCubit: BlocProvider.of<AuthCubit>(context),
            messageUseCases: authenticatedLocator(),
            eventUseCases: authenticatedLocator(),
            chatCubit: BlocProvider.of<ChatCubit>(context),
            groupchatUseCases: authenticatedLocator(),
          )..reloadGroupchatAndGroupchatUsersViaApi(),
        ),
        BlocProvider(
          create: (context) => UserSearchCubit(
            authCubit: BlocProvider.of<AuthCubit>(context),
            userRelationUseCases: authenticatedLocator(),
            userUseCases: authenticatedLocator(),
            notificationCubit: BlocProvider.of<NotificationCubit>(context),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentGroupchatCubit, CurrentGroupchatState>(
                listener: (context, state) async {
                  if (state.currentUserLeftChat == true) {
                    AutoRouter.of(context).popUntilRoot();
                    AutoRouter.of(context).pop();
                  }
                },
              ),
            ],
            child: HeroControllerScope(
              controller: HeroController(),
              child: const AutoRouter(),
            ),
          );
        },
      ),
    );
  }
}
