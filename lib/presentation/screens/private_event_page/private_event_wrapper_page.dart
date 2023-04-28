import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';

class PrivateEventWrapperPage extends StatelessWidget {
  final String privateEventId;
  final CurrentPrivateEventState privateEventStateToSet;

  const PrivateEventWrapperPage({
    @PathParam('id') required this.privateEventId,
    required this.privateEventStateToSet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
      privateEventStateToSet,
      authCubit: BlocProvider.of<AuthCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      notificationCubit: BlocProvider.of<NotificationCubit>(context),
      locationUseCases: serviceLocator(),
      chatUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      shoppingListItemUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
      privateEventUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
    )
          ..setCurrentChatFromChatCubit()
          ..reloadPrivateEventStandardDataViaApi();

    return BlocProvider.value(
      value: currentPrivateEventCubit,
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentPrivateEventCubit, CurrentPrivateEventState>(
                listener: (context, state) async {
                  if (state.status == CurrentPrivateEventStateStatus.deleted) {
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
