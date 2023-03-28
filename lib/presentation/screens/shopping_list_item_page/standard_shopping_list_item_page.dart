import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_entity.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_bought_amount_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_create_bought_amount_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_private_event_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_progress_bar.dart';

class StandardShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final ShoppingListItemEntity shoppingListItemToSet;
  final bool loadShoppingListItemFromApiToo;
  final bool setCurrentPrivateEvent;

  const StandardShoppingListItemPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    required this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
    this.setCurrentPrivateEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentShoppingListItemCubit(
        CurrentShoppingListItemState(
          loadingShoppingListItem: false,
          shoppingListItem: shoppingListItemToSet,
        ),
        boughtAmountUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
        shoppingListCubit: BlocProvider.of<ShoppingListCubit>(context),
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(
        builder: (context) {
          if (loadShoppingListItemFromApiToo) {
            BlocProvider.of<CurrentShoppingListItemCubit>(context)
                .getShoppingListItemViaApi();
          }

          if (setCurrentPrivateEvent) {
            BlocProvider.of<CurrentPrivateEventCubit>(context).emitState(
              privateEvent: PrivateEventEntity(
                id: shoppingListItemToSet.privateEventId ?? "",
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
                      BlocProvider.of<CurrentPrivateEventCubit>(context)
                          .getPrivateEventUsersViaApi();
                      BlocProvider.of<CurrentPrivateEventCubit>(context)
                          .getPrivateEventAndGroupchatFromApi();
                    },
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(const [
                      CurrentShoppingListItemPageWithProgressBar(),
                      SizedBox(height: 20),
                      CurrentShopppingListItemPagePrivateEventTile(),
                      CustomDivider(),
                      CurrentShoppingListItemPageCreateBoughtAmountTile(),
                      CurrentShoppingListItemPageBoughtAmountList(),
                    ]),
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