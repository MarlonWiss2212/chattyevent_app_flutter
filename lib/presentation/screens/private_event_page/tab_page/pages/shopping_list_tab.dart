import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/privat_event_page/tab_bar/shopping_list_tab/shopping_list_item_tile.dart';

class ShoppingListTab extends StatelessWidget {
  final String privateEventId;
  const ShoppingListTab({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentPrivateEventCubit>(context).getShoppingListViaApi(
      getShoppingListItemsFilter: GetShoppingListItemsFilter(
        privateEventId: privateEventId,
      ),
    );

    return PlatformScaffold(
      body: RefreshIndicator(
        onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
            .getShoppingListViaApi(
          getShoppingListItemsFilter: GetShoppingListItemsFilter(
            privateEventId: privateEventId,
          ),
        ),
        child: BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, state) {
            const emptyReturn = Center(
              child: Text("Keine Items die gekauft werden müssen"),
            );

            if (state.shoppingList.isEmpty && !state.loadingShoppingList) {
              return emptyReturn;
            } else if (state.shoppingList.isEmpty &&
                state.loadingShoppingList) {
              return SkeletonListView(
                itemBuilder: (p0, p1) {
                  return SkeletonListTile(
                    hasSubtitle: true,
                    hasLeading: false,
                    titleStyle: const SkeletonLineStyle(
                      width: double.infinity,
                      height: 22,
                    ),
                    subtitleStyle: const SkeletonLineStyle(
                      width: double.infinity,
                      height: 16,
                    ),
                  );
                },
              );
            } else if (state.shoppingList.isEmpty) {
              return emptyReturn;
            }

            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ShoppingListItemTile(
                  currentPrivateEventState: state,
                  shoppingListItem: state.shoppingList[index],
                );
              },
              itemCount: state.shoppingList.length,
            );
          },
        ),
      ),
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            AutoRouter.of(context).push(
              PrivateEventCreateShoppingListItemRoute(),
            );
          },
          icon: const Icon(Icons.add),
          label: Text(
            'Neues Item',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
