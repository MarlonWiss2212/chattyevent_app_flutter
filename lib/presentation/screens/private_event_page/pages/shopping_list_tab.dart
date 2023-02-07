import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/presentation/widgets/bottom_sheet/add_shopping_list_item.dart';

class ShoppingListTab extends StatelessWidget {
  final String privateEventId;
  const ShoppingListTab({
    @PathParam('id') required this.privateEventId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingListCubit>(context).getShoppingListViaApi(
      getShoppingListItemsFilter:
          GetShoppingListItemsFilter(privateEvent: privateEventId),
    );

    return PlatformScaffold(
      body: BlocBuilder<ShoppingListCubit, ShoppingListState>(
        builder: (context, state) {
          bool loadingDataForCurrentEvent = state is ShoppingListLoading &&
              state.loadingForPrivateEventId == privateEventId;

          const emptyReturn = Center(
            child: Text("Keine Items die gekauft werden müssen"),
          );

          if (state.shoppingList.isEmpty && !loadingDataForCurrentEvent) {
            return emptyReturn;
          }

          List<ShoppingListItemEntity> filteredItems = state.shoppingList
              .where(
                (element) => element.privateEvent == privateEventId,
              )
              .toList();

          if (filteredItems.isEmpty && loadingDataForCurrentEvent) {
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
          }

          if (filteredItems.isEmpty) {
            return emptyReturn;
          }

          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  filteredItems[index].itemName ?? "Kein Name",
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  "${filteredItems[index].amount} ${filteredItems[index].unit}",
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {},
              );
            },
            itemCount: filteredItems.length,
          );
        },
      ),
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            return await showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddShoppingListItem();
              },
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
