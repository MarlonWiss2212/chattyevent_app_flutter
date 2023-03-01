import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/core/filter/get_shopping_list_items_filter.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';
import 'package:social_media_app_flutter/domain/entities/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/shopping_list_page/shopping_list_item_tile.dart';

class PrivateEventTabShoppingList extends StatelessWidget {
  final String privateEventId;
  const PrivateEventTabShoppingList({
    @PathParam('id') required this.privateEventId,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingListCubit>(context).getShoppingListViaApi(
      getShoppingListItemsFilter: GetShoppingListItemsFilter(
        privateEventId: privateEventId,
      ),
    );

    return PlatformScaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            BlocProvider.of<ShoppingListCubit>(context).getShoppingListViaApi(
          getShoppingListItemsFilter: GetShoppingListItemsFilter(
            privateEventId: privateEventId,
          ),
        ),
        child: BlocBuilder<ShoppingListCubit, ShoppingListState>(
          builder: (context, state) {
            if (state.shoppingList.isEmpty &&
                state.loadingForPrivateEventId != privateEventId) {
              return const Center(
                child: Text("Keine Items die gekauft werden müssen"),
              );
            } else if (state.shoppingList.isEmpty &&
                state.loadingForPrivateEventId == privateEventId) {
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

            List<ShoppingListItemEntity> filteredItems = state.shoppingList
                .where(
                  (element) => element.privateEventId == privateEventId,
                )
                .toList();

            return BlocBuilder<CurrentPrivateEventCubit,
                CurrentPrivateEventState>(
              builder: (context, currentPrivateEventState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    UserWithPrivateEventUserData userToBuyItem =
                        currentPrivateEventState.privateEventUsers.firstWhere(
                      (element) =>
                          element.user.id == filteredItems[index].userToBuyItem,
                      orElse: () => UserWithPrivateEventUserData(
                        privateEventUser: PrivateEventUserEntity(id: ""),
                        user: UserEntity(id: ""),
                      ),
                    );

                    return ShoppingListItemTile(
                      shoppingListItem: filteredItems[index],
                      userToBuyItem: userToBuyItem,
                      onTap: () {
                        AutoRouter.of(context).push(
                          PrivateEventCurrentShoppingListItemPageRoute(
                            shoppingListItemId: filteredItems[index].id,
                            shoppingListItemToSet: filteredItems[index],
                            loadShoppingListItemFromApiToo: true,
                          ),
                        );
                      },
                    );
                  },
                  itemCount: filteredItems.length,
                );
              },
            );
          },
        ),
      ),
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            AutoRouter.of(context).push(
              PrivateEventCreateShoppingListItemPageRoute(),
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
