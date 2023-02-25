import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/injection.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_bought_amount_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_private_event_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_progress_bar.dart';

class CurrentShoppingListItemPage extends StatelessWidget {
  final String shoppingListItemId;
  final ShoppingListItemEntity? shoppingListItemToSet;
  final bool loadShoppingListItemFromApiToo;

  const CurrentShoppingListItemPage({
    super.key,
    @PathParam('shoppingListItemId') required this.shoppingListItemId,
    this.shoppingListItemToSet,
    this.loadShoppingListItemFromApiToo = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CurrentShoppingListItemCubit(
        CurrentShoppingListItemState(
          shoppingListItem: shoppingListItemToSet ??
              ShoppingListItemEntity(id: shoppingListItemId),
        ),
        shoppingListCubit: BlocProvider.of<ShoppingListCubit>(context),
        shoppingListItemUseCases: serviceLocator(
          param1: BlocProvider.of<AuthCubit>(context).state,
        ),
      ),
      child: Builder(builder: (context) {
        if (shoppingListItemToSet == null || loadShoppingListItemFromApiToo) {
          BlocProvider.of<CurrentShoppingListItemCubit>(context)
              .getShoppingListItemViaApi();
        }

        return BlocListener<CurrentShoppingListItemCubit,
            CurrentShoppingListItemState>(
          listener: (context, state) async {
            if (state.status == CurrentShoppingListItemStateStatus.error &&
                state.error != null) {
              return await showPlatformDialog(
                context: context,
                builder: (context) {
                  return PlatformAlertDialog(
                    title: Text(state.error!.title),
                    content: Text(state.error!.message),
                    actions: const [OKButton()],
                  );
                },
              );
            } else if (state.status ==
                CurrentShoppingListItemStateStatus.sucessDelete) {
              AutoRouter.of(context).pop();
            }
          },
          child: PlatformScaffold(
            appBar: PlatformAppBar(
              title: BlocBuilder<CurrentShoppingListItemCubit,
                  CurrentShoppingListItemState>(
                buildWhen: (previous, current) =>
                    previous.shoppingListItem.itemName !=
                    current.shoppingListItem.itemName,
                builder: (context, state) => Text(
                  state.shoppingListItem.itemName ?? "Kein Name",
                ),
              ),
              trailingActions: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CurrentShoppingListItemCubit>(context)
                        .deleteShoppingListItemViaApi();
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            body: Column(
              children: const [
                SizedBox(height: 20),
                CurrentShoppingListItemPageWithProgressBar(),
                CustomDivider(),
                CurrentShopppingListItemPagePrivateEventTile(),
                CustomDivider(),
                CurrentShoppingListItemPageBoughtAmountList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
