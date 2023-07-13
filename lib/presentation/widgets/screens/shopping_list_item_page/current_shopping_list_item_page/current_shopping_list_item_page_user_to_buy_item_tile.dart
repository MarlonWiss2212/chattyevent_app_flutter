import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/current_private_event/current_private_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageUserToBuyItemTile extends StatelessWidget {
  const CurrentShoppingListItemPageUserToBuyItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
      builder: (context, privateEventState) {
        return BlocBuilder<CurrentShoppingListItemCubit,
            CurrentShoppingListItemState>(
          builder: (context, state) {
            return BlocBuilder<CurrentPrivateEventCubit,
                CurrentPrivateEventState>(
              builder: (context, privateEventState) {
                final PrivateEventUserEntity userToBuyItem =
                    privateEventState.privateEventUsers.firstWhere(
                  (element) =>
                      element.id == state.shoppingListItem.userToBuyItem,
                  orElse: () => PrivateEventUserEntity(
                    authId: "",
                    id: "",
                    privateEventUserId: "",
                  ),
                );

                return UserListTile(
                  user: userToBuyItem,
                  items: privateEventState.currentUserAllowedWithPermission(
                          permissionCheckValue: privateEventState
                              .privateEvent.permissions?.updateShoppingListItem)
                      ? [
                          PopupMenuItem(
                            child: const Text("ändern"),
                            onTap: () {
                              BlocProvider.of<CurrentShoppingListItemCubit>(
                                      context)
                                  .shoppingListCubitOrPrivateEventCubit
                                  .fold(
                                    (l) => AutoRouter.of(context).push(
                                      const ShoppingListItemChangeUserRoute(),
                                    ),
                                    (r) => AutoRouter.of(context).push(
                                      const PrivateEventShoppingListItemChangeUserRoute(),
                                    ),
                                  );
                            },
                          )
                        ]
                      : null,
                  subtitle: const Text(
                    "Benutzer der es kaufen soll",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
