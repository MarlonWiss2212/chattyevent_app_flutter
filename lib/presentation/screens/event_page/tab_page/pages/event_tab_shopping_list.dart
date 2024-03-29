import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/shopping_list_page/shopping_list_item_tile.dart';

@RoutePage()
class EventTabShoppingList extends StatelessWidget {
  const EventTabShoppingList({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CurrentEventCubit>(context).getShoppingListItemsViaApi(
      reload: false,
    );

    return CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: 100,
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: const EdgeInsets.only(bottom: 16),
          title: Text(
            "eventPage.tabs.shoppingListTab.title",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ).tr(),
        ),
        actions: [
          BlocBuilder<CurrentEventCubit, CurrentEventState>(
            builder: (context, state) {
              if (state.currentUserAllowedWithPermission(
                  permissionCheckValue:
                      state.event.permissions?.addShoppingListItem)) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => AutoRouter.of(context).push(
                    const EventCreateShoppingListItemRoute(),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
      CupertinoSliverRefreshControl(
        onRefresh: () => BlocProvider.of<CurrentEventCubit>(context)
            .getShoppingListItemsViaApi(
          reload: true,
        ),
      ),
      BlocBuilder<CurrentEventCubit, CurrentEventState>(
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

          return BlocBuilder<CurrentEventCubit, CurrentEventState>(
            builder: (context, currentPrivateEventState) {
              if (state.loadingShoppingList &&
                  state.shoppingListItemStates.isEmpty) {
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
              } else if (state.shoppingListItemStates.isEmpty) {
                return const SliverFillRemaining(
                    child: Center(
                        child: Text(
                  "Keine Items die gekauft werden müssen",
                )));
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.shoppingListItemStates.length) {
                      EventUserEntity userToBuyItem =
                          currentPrivateEventState.eventUsers.firstWhere(
                        (element) =>
                            element.id ==
                            state.shoppingListItemStates[index].shoppingListItem
                                .userToBuyItem,
                        orElse: () => EventUserEntity(
                          id: state.shoppingListItemStates[index]
                                  .shoppingListItem.userToBuyItem ??
                              "",
                          authId: "",
                          eventUserId: "",
                        ),
                      );

                      return ShoppingListItemTile(
                        shoppingListItem: state
                            .shoppingListItemStates[index].shoppingListItem,
                        userToBuyItem: userToBuyItem,
                        onTap: () {
                          AutoRouter.of(context).push(
                            EventShoppingListItemWrapperRoute(
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
                    }
                    if (state.loadingShoppingList) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<CurrentEventCubit>(context)
                              .getShoppingListItemsViaApi();
                        },
                        icon: const Icon(Ionicons.arrow_down_circle_outline),
                      );
                    }
                  },
                  childCount: state.shoppingListItemStates.length + 1,
                ),
              );
            },
          );
        },
      )
    ]);
  }
}
