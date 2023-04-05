import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

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
      ),
      child: Builder(
        builder: (context) {
          BlocProvider.of<CurrentShoppingListItemCubit>(context)
              .getBoughtAmounts();
          BlocProvider.of<CurrentShoppingListItemCubit>(context)
              .getShoppingListItemViaApi();

          if (setCurrentPrivateEvent) {
            BlocProvider.of<CurrentPrivateEventCubit>(context).emitState(
              privateEvent: PrivateEventEntity(
                id: shoppingListItemStateToSet
                        .shoppingListItem.privateEventId ??
                    "",
              ),
            );
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .setCurrentChatFromChatCubit();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .setPrivateEventFromPrivateEventCubit();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getPrivateEventUsersAndLeftUsersViaApi();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getCurrentPrivateEvent();
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
                            .shoppingListItem.privateEventId ??
                        "",
                  ),
                );
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .setCurrentChatFromChatCubit();
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .setPrivateEventFromPrivateEventCubit();
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .getPrivateEventUsersAndLeftUsersViaApi();
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .getCurrentPrivateEvent();
              }
              if (state.status == CurrentShoppingListItemStateStatus.error &&
                  state.error != null) {
                return await showDialog(
                  context: context,
                  builder: (c) {
                    return CustomAlertDialog(
                      message: state.error!.message,
                      title: state.error!.title,
                      context: c,
                    );
                  },
                );
              } else if (state.status ==
                  CurrentShoppingListItemStateStatus.deleted) {
                AutoRouter.of(context).pop();
              }
            },
            child: const AutoRouter(),
          );
        },
      ),
    );
  }
}
