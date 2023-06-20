import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:chattyevent_app_flutter/core/injection.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_entity.dart';

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
    return BlocProvider.value(
      value: CurrentShoppingListItemCubit(
        shoppingListItemStateToSet,
        boughtAmountUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        shoppingListCubitOrPrivateEventCubit: setCurrentPrivateEvent
            ? Left(BlocProvider.of<MyShoppingListCubit>(context))
            : Right(BlocProvider.of<CurrentPrivateEventCubit>(context)),
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        notificationCubit: BlocProvider.of<NotificationCubit>(context),
      )..reloadShoppingListItemStandardDataViaApi(),
      child: Builder(
        builder: (context) {
          if (setCurrentPrivateEvent) {
            BlocProvider.of<CurrentPrivateEventCubit>(context).emitState(
              privateEvent: PrivateEventEntity(
                id: shoppingListItemStateToSet
                        .shoppingListItem.privateEventTo ??
                    "",
                eventDate: DateTime.now(),
              ),
            );
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .setGroupchatFromChatCubit();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .reloadPrivateEventStandardDataViaApi();
          }

          return BlocListener<CurrentShoppingListItemCubit,
              CurrentShoppingListItemState>(
            listener: (context, state) async {
              if (BlocProvider.of<CurrentPrivateEventCubit>(context)
                      .state
                      .privateEvent
                      .id ==
                  "") {
                BlocProvider.of<CurrentPrivateEventCubit>(context).emitState(
                  privateEvent: PrivateEventEntity(
                    id: shoppingListItemStateToSet
                            .shoppingListItem.privateEventTo ??
                        "",
                    eventDate: DateTime.now(),
                  ),
                );
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .setGroupchatFromChatCubit();
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .reloadPrivateEventStandardDataViaApi();
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
