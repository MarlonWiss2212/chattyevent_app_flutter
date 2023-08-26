import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/profile_page/profile_page_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';

@RoutePage()
class HomeProfilePage extends StatelessWidget {
  final String? userId;

  const HomeProfilePage({
    super.key,
    @PathParam('id') this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit(
        ProfilePageState.fromUser(
          user: BlocProvider.of<AuthCubit>(context).state.currentUser,
        ),
        chatCubit: BlocProvider.of<ChatCubit>(context),
        userUseCases: serviceLocator(),
        userRelationUseCases: serviceLocator(),
        messageUseCases: serviceLocator(),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
        authCubit: BlocProvider.of<AuthCubit>(context),
      ),
      child: Builder(
        builder: (context) {
          BlocProvider.of<ProfilePageCubit>(context).getCurrentUserViaApi();
          return HeroControllerScope(
            controller: HeroController(),
            child: const AutoRouter(),
          );
        },
      ),
    );
  }
}
