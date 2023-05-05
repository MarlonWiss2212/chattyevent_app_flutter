import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:chattyevent_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/my_shopping_list_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/shopping_list_item_page/shopping_list_page/shopping_list_item_tile.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MyShoppingListCubit>(context).getShoppingListViaApi();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            leading: const AutoLeadingButton(),
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Einkaufsliste",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () => BlocProvider.of<MyShoppingListCubit>(context)
                .getShoppingListViaApi(),
          ),
          BlocBuilder<MyShoppingListCubit, MyShoppingListState>(
            builder: (context, state) {
              if (state.loading == true &&
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
                    child: Text("Keine Items die gekauft werden müssen"),
                  ),
                );
              }
              final currentUser =
                  BlocProvider.of<AuthCubit>(context).state.currentUser;
              final filteredShoppingList = state.shoppingListItemStates
                  .where(
                    (element) =>
                        element.shoppingListItem.userToBuyItem ==
                        currentUser.id,
                  )
                  .toList();

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ShoppingListItemTile(
                      shoppingListItem:
                          filteredShoppingList[index].shoppingListItem,
                      userToBuyItem: PrivateEventUserEntity(
                        id: currentUser.id,
                        authId: currentUser.authId,
                        privateEventUserId: "",
                      ),
                      onTap: () {
                        AutoRouter.of(context).push(
                          ShoppingListItemWrapperPageRoute(
                            currentShoppingListItemStateToSet:
                                filteredShoppingList[index],
                            shoppingListItemId:
                                filteredShoppingList[index].shoppingListItem.id,
                          ),
                        );
                      },
                    );
                  },
                  childCount: filteredShoppingList.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
