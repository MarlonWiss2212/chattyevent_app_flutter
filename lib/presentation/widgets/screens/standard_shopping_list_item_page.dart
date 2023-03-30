import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_bought_amount_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_create_bought_amount_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_private_event_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_progress_bar.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_user_to_buy_item_tile.dart';

class StandardShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final CurrentShoppingListItemState shoppingListItemStateToSet;
  final bool setCurrentPrivateEvent;

  const StandardShoppingListItemPage({
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
                .getPrivateEventUsersViaApi();
            BlocProvider.of<CurrentPrivateEventCubit>(context)
                .getPrivateEventAndGroupchatFromApi();
          }

          return BlocListener<CurrentShoppingListItemCubit,
              CurrentShoppingListItemState>(
            listener: (context, state) async {
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
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      title: BlocBuilder<CurrentShoppingListItemCubit,
                          CurrentShoppingListItemState>(
                        buildWhen: (previous, current) =>
                            previous.shoppingListItem.itemName !=
                            current.shoppingListItem.itemName,
                        builder: (context, state) => Text(
                          state.shoppingListItem.itemName ?? "",
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<CurrentShoppingListItemCubit>(context)
                              .deleteShoppingListItemViaApi();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: () async {
                      BlocProvider.of<CurrentPrivateEventCubit>(context)
                          .setCurrentChatFromChatCubit();
                      BlocProvider.of<CurrentPrivateEventCubit>(context)
                          .setPrivateEventFromPrivateEventCubit();

                      await Future.wait([
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .getPrivateEventUsersViaApi(),
                        BlocProvider.of<CurrentPrivateEventCubit>(context)
                            .getPrivateEventAndGroupchatFromApi(),
                        BlocProvider.of<CurrentShoppingListItemCubit>(context)
                            .getBoughtAmounts(
                          reload: true,
                        ),
                        BlocProvider.of<CurrentShoppingListItemCubit>(context)
                            .getShoppingListItemViaApi()
                      ]);
                    },
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      const [
                        CurrentShoppingListItemPageWithProgressBar(),
                        SizedBox(height: 20),
                        CurrentShoppingListItemPagePrivateEventTile(),
                        CustomDivider(),
                        CurrentShoppingListItemPageUserToBuyItemTile(),
                        CustomDivider(),
                        CurrentShoppingListItemPageCreateBoughtAmountTile(),
                        CurrentShoppingListItemPageBoughtAmountList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
