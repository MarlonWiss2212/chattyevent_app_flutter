import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:chattyevent_app_flutter/core/utils/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_entity.dart';

class StandardShoppingListItemWrapperPage extends StatelessWidget {
  final String shoppingListItemId;
  final CurrentShoppingListItemState shoppingListItemStateToSet;
  final bool setCurrentPrivateEvent;

  const StandardShoppingListItemWrapperPage({
    super.key,
    required this.shoppingListItemId,
    required this.shoppingListItemStateToSet,
    this.setCurrentPrivateEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrentShoppingListItemCubit(
        shoppingListItemStateToSet,
        boughtAmountUseCases: authenticatedLocator(),
        shoppingListCubitOrPrivateEventCubit: setCurrentPrivateEvent
            ? Left(BlocProvider.of<MyShoppingListCubit>(context))
            : Right(BlocProvider.of<CurrentEventCubit>(context)),
        shoppingListItemUseCases: authenticatedLocator(),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..getShoppingListItemViaApi(),
      child: Builder(
        builder: (context) {
          if (setCurrentPrivateEvent) {
            BlocProvider.of<CurrentEventCubit>(context)
                .setGroupchatFromChatCubit();
            BlocProvider.of<CurrentEventCubit>(context)
                .reloadEventStandardDataViaApi();
          }

          return BlocListener<CurrentShoppingListItemCubit,
              CurrentShoppingListItemState>(
            listener: (context, state) async {
              if (BlocProvider.of<CurrentEventCubit>(context).state.event.id ==
                  "") {
                BlocProvider.of<CurrentEventCubit>(context).emitState(
                  event: EventEntity(
                    id: shoppingListItemStateToSet.shoppingListItem.eventTo ??
                        "",
                    eventDate: DateTime.now(),
                  ),
                );
                BlocProvider.of<CurrentEventCubit>(context)
                    .setGroupchatFromChatCubit();
                BlocProvider.of<CurrentEventCubit>(context)
                    .reloadEventStandardDataViaApi();
              }
              if (state.status == CurrentShoppingListItemStateStatus.deleted) {
                AutoRouter.of(context).pop();
              }
            },
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
