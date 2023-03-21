import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:social_media_app_flutter/application/bloc/auth/auth_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/shopping_list_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/groupchat/groupchat_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';
import 'package:social_media_app_flutter/presentation/widgets/screens/shopping_list_item_page/shopping_list_page/shopping_list_item_tile.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShoppingListCubit>(context).getShoppingListViaApi();

    return PlatformScaffold(
      appBar: PlatformAppBar(title: const Text("Einkaufsliste")),
      body: BlocListener<ShoppingListCubit, ShoppingListState>(
        listener: (context, state) async {
          if (state.error != null) {
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
          }
        },
        child: Column(
          children: [
            BlocBuilder<ShoppingListCubit, ShoppingListState>(
              buildWhen: (previous, current) =>
                  previous.loading != current.loading,
              builder: (context, state) {
                if (state.loading == true) {
                  return const LinearProgressIndicator();
                }
                return const SizedBox();
              },
            ),
            Expanded(
              child: BlocBuilder<ShoppingListCubit, ShoppingListState>(
                builder: (context, state) {
                  if (state.loading == true && state.shoppingList.isEmpty) {
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
                    return const Center(
                      child: Text("Keine Items die gekauft werden müssen"),
                    );
                  }
                  final currentUser =
                      BlocProvider.of<AuthCubit>(context).state.currentUser;
                  final filteredShoppingList = state.shoppingList
                      .where(
                        (element) => element.userToBuyItem == currentUser.id,
                      )
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ShoppingListItemTile(
                        shoppingListItem: filteredShoppingList[index],
                        userToBuyItem: UserWithPrivateEventUserData(
                          user: currentUser,
                          groupchatUser:
                              GroupchatUserEntity(id: currentUser.id),
                          privateEventUser:
                              PrivateEventUserEntity(id: currentUser.id),
                        ),
                        onTap: () {
                          AutoRouter.of(context).push(
                            ShoppingListItemPageRoute(
                              shoppingListItemId:
                                  filteredShoppingList[index].id,
                              shoppingListItemToSet:
                                  filteredShoppingList[index],
                              loadShoppingListItemFromApiToo: true,
                            ),
                          );
                        },
                      );
                    },
                    itemCount: filteredShoppingList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
