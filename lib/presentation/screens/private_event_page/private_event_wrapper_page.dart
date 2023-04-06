import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/user/user_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class PrivateEventWrapperPage extends StatelessWidget {
  final String privateEventId;
  final PrivateEventEntity? privateEventToSet;
  final bool loadPrivateEventFromApiToo;

  const PrivateEventWrapperPage({
    @PathParam('id') required this.privateEventId,
    this.privateEventToSet,
    this.loadPrivateEventFromApiToo = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CurrentPrivateEventCubit currentPrivateEventCubit =
        CurrentPrivateEventCubit(
      CurrentPrivateEventState(
        privateEventLeftUsers: [],
        currentUserIndex: -1,
        shoppingListItemStates: [],
        loadingShoppingList: false,
        privateEventUsers: const [],
        privateEvent: privateEventToSet ??
            PrivateEventEntity(
              id: privateEventId,
            ),
        loadingGroupchat: false,
        loadingPrivateEvent: false,
      ),
      authCubit: BlocProvider.of<AuthCubit>(context),
      userCubit: BlocProvider.of<UserCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      notificationCubit: BlocProvider.of<NotificationCubit>(context),
      locationUseCases: serviceLocator(),
      chatUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      shoppingListItemUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      privateEventCubit: BlocProvider.of<PrivateEventCubit>(context),
      privateEventUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: currentPrivateEventCubit),
      ],
      child: Builder(
        builder: (context) {
          BlocProvider.of<CurrentPrivateEventCubit>(context)
              .setCurrentChatFromChatCubit();
          BlocProvider.of<CurrentPrivateEventCubit>(context)
              .getPrivateEventUsersAndLeftUsersViaApi();

          if (privateEventToSet != null &&
              privateEventToSet!.groupchatTo == null &&
              !loadPrivateEventFromApiToo) {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getCurrentChatViaApi();
          } else {
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .setPrivateEventFromPrivateEventCubit();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getPrivateEventAndGroupchatFromApi();
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<CurrentPrivateEventCubit, CurrentPrivateEventState>(
                listener: (context, state) async {
                  if (state.status == CurrentPrivateEventStateStatus.deleted) {
                    AutoRouter.of(context).pop();
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
