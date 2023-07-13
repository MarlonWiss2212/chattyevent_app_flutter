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

@RoutePage()
class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  void initState() {
    BlocProvider.of<MyShoppingListCubit>(context).getShoppingListViaApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            leading: const AutoLeadingButton(),
            expandedHeight: 100,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                tag: "ShoppingListTitle",
                child: Text(
                  "Einkaufsliste",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
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

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.shoppingListItemStates.length) {
                      return ShoppingListItemTile(
                        shoppingListItem: state
                            .shoppingListItemStates[index].shoppingListItem,
                        userToBuyItem: PrivateEventUserEntity(
                          id: currentUser.id,
                          authId: currentUser.authId,
                          username: currentUser.username,
                          profileImageLink: currentUser.profileImageLink,
                          privateEventUserId: "",
                        ),
                        onTap: () {
                          AutoRouter.of(context).push(
                            ShoppingListItemWrapperRoute(
                              currentShoppingListItemStateToSet:
                                  state.shoppingListItemStates[index],
                              shoppingListItemId: state
                                  .shoppingListItemStates[index]
                                  .shoppingListItem
                                  .id,
                            ),
                          );
                        },
                      );
                    }
                    if (state.loading) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<MyShoppingListCubit>(context)
                              .getShoppingListViaApi();
                        },
                        icon: const Icon(Icons.add_circle),
                      );
                    }
                  },
                  childCount: state.shoppingListItemStates.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
