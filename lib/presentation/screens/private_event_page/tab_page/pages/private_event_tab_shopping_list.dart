import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
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
    BlocProvider.of<CurrentPrivateEventCubit>(context)
        .getShoppingListItemsViaApi(
      reload: false,
    );

    return CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: 100,
        flexibleSpace: const FlexibleSpaceBar(
          title: Text("Einkaufsliste"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => AutoRouter.of(context).push(
              PrivateEventCreateShoppingListItemPageRoute(),
            ),
          ),
        ],
      ),
      CupertinoSliverRefreshControl(
        onRefresh: () => BlocProvider.of<CurrentPrivateEventCubit>(context)
            .getShoppingListItemsViaApi(
          reload: true,
        ),
      ),
      BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
        builder: (context, state) {
          if (state.shoppingListItemStates.isEmpty &&
              state.loadingShoppingList == false) {
            return const SliverFillRemaining(
              child: Center(
                child: Text("Keine Items die gekauft werden müssen"),
              ),
            );
          } else if (state.shoppingListItemStates.isEmpty &&
              state.loadingShoppingList) {
            return SliverFillRemaining(
              child: SkeletonListView(
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
              ),
            );
          }

          return BlocBuilder<CurrentPrivateEventCubit,
              CurrentPrivateEventState>(
            builder: (context, currentPrivateEventState) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    UserWithPrivateEventUserData userToBuyItem =
                        currentPrivateEventState.privateEventUsers.firstWhere(
                      (element) =>
                          element.user.id ==
                          state.shoppingListItemStates[index].shoppingListItem
                              .userToBuyItem,
                      orElse: () => UserWithPrivateEventUserData(
                        privateEventUser: PrivateEventUserEntity(
                            id: "",
                            userId: state.shoppingListItemStates[index]
                                .shoppingListItem.userToBuyItem),
                        user: UserEntity(
                          id: state.shoppingListItemStates[index]
                                  .shoppingListItem.userToBuyItem ??
                              "",
                          authId: "",
                        ),
                      ),
                    );

                    return ShoppingListItemTile(
                      shoppingListItem:
                          state.shoppingListItemStates[index].shoppingListItem,
                      userToBuyItem: userToBuyItem,
                      onTap: () {
                        AutoRouter.of(context).push(
                          PrivateEventShoppingListItemWrapperPageRoute(
                            shoppingListItemId: state
                                .shoppingListItemStates[index]
                                .shoppingListItem
                                .id,
                            shoppingListItemStateToSet:
                                state.shoppingListItemStates[index],
                            setCurrentPrivateEvent: false,
                          ),
                        );
                      },
                    );
                  },
                  childCount: state.shoppingListItemStates.length,
                ),
              );
            },
          );
        },
      )
    ]);
  }
}
