import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/message_stream/message_stream_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_state.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/user/user_entity.dart';

@RoutePage()
class ProfileWrapperPage extends StatelessWidget {
  final String userId;
  final UserEntity? user;

  const ProfileWrapperPage({
    super.key,
    this.user,
    @PathParam('id') required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageState.fromUser(
          user: user ?? UserEntity(id: userId, authId: ""),
        ),
        messageStreamCubit: BlocProvider.of<MessageStreamCubit>(context),
        chatCubit: BlocProvider.of<ChatCubit>(context),
        userRelationUseCases: authenticatedLocator(),
        messageUseCases: authenticatedLocator(),
        userUseCases: authenticatedLocator(),
        authCubit: BlocProvider.of<AuthCubit>(context),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getCurrentUserViaApi(),
      child: HeroControllerScope(
        controller: HeroController(),
        child: const AutoRouter(),
      ),
    );
  }
}
