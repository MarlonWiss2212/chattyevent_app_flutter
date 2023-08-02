import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/chat/chat_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/home_page/home_event/home_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/user_search/user_search_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';

@RoutePage()
class EventWrapperPage extends StatelessWidget {
  final String eventId;
  final CurrentEventState? eventStateToSet;

  const EventWrapperPage({
    @PathParam('id') required this.eventId,
    this.eventStateToSet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CurrentEventCubit currentPrivateEventCubit = CurrentEventCubit(
      eventStateToSet ??
          CurrentEventState.fromEvent(
            event: EventEntity(
              id: eventId,
              eventDate: DateTime.now(),
            ),
          ),
      authCubit: BlocProvider.of<AuthCubit>(context),
      chatCubit: BlocProvider.of<ChatCubit>(context),
      notificationCubit: BlocProvider.of<NotificationCubit>(context),
      locationUseCases: serviceLocator(),
      messageUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      groupchatUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      shoppingListItemUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
      homeEventCubit: BlocProvider.of<HomeEventCubit>(context),
      eventUseCases: serviceLocator(
        param1: BlocProvider.of<AuthCubit>(context).state,
      ),
    )
      ..setGroupchatFromChatCubit()
      ..reloadEventStandardDataViaApi()
      ..listenToMessages();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => currentPrivateEventCubit,
        ),
        BlocProvider(
          create: (context) => UserSearchCubit(
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
              BlocListener<CurrentEventCubit, CurrentEventState>(
                listener: (context, state) async {
                  if (state.status == CurrentPrivateEventStateStatus.deleted) {
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
