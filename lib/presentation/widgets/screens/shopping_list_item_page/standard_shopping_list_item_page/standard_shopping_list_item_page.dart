import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/custom_divider.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_bought_amount_list.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_create_bought_amount_tile.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_private_event_tile.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_progress_bar.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/current_shopping_list_item_page/current_shopping_list_item_page_user_to_buy_item_tile.dart';

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
            centerTitle: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              title: CurrentShoppingListItemPageTitle(),
            ),
            actions: [
              BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
                builder: (context, state) {
                  if (state.currentUserAllowedWithPermission(
                      permissionCheckValue: state
                          .privateEvent.permissions?.deleteShoppingListItem)) {
                    return IconButton(
                      onPressed: () {
                        BlocProvider.of<CurrentShoppingListItemCubit>(context)
                            .deleteShoppingListItemViaApi();
                      },
                      icon: const Icon(Icons.delete),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await Future.wait([
                BlocProvider.of<CurrentPrivateEventCubit>(context)
                    .reloadPrivateEventStandardDataViaApi(),
                BlocProvider.of<CurrentShoppingListItemCubit>(context)
                    .reloadShoppingListItemStandardDataViaApi()
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
