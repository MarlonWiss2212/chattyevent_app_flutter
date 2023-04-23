import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_bought_amount_list.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_create_bought_amount_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_private_event_tile.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_progress_bar.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_user_to_buy_item_tile.dart';

class StandardShoppingListItemPage extends StatelessWidget {
  const StandardShoppingListItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 100,
            leading: const AutoLeadingButton(),
            flexibleSpace: FlexibleSpaceBar(
              title: BlocBuilder<CurrentShoppingListItemCubit,
                  CurrentShoppingListItemState>(
                buildWhen: (previous, current) =>
                    previous.shoppingListItem.itemName !=
                    current.shoppingListItem.itemName,
                builder: (context, state) => EditInputTextField(
                  text: state.shoppingListItem.itemName ?? "",
                  onSaved: (text) {
                    BlocProvider.of<CurrentShoppingListItemCubit>(context)
                        .updateShoppingListItemViaApi(
                      updateShoppingListItemDto: UpdateShoppingListItemDto(
                        itemName: text,
                      ),
                    );
                  },
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
                    .getPrivateEventUsersAndLeftUsersViaApi(),
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .getCurrentPrivateEvent(),
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
    );
  }
}