import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user_entity.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/user/user_entity.dart';
import 'package:social_media_app_flutter/presentation/router/router.gr.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/user_list/user_list_tile.dart';

class CurrentShoppingListItemPageUserToBuyItemTile extends StatelessWidget {
  const CurrentShoppingListItemPageUserToBuyItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
      builder: (context, state) {
        return BlocBuilder<CurrentPrivateEventCubit, CurrentPrivateEventState>(
          builder: (context, privateEventState) {
            final UserWithPrivateEventUserData userToBuyItem =
                privateEventState.privateEventUsers.firstWhere(
              (element) =>
                  element.user.id == state.shoppingListItem.userToBuyItem,
              orElse: () => UserWithPrivateEventUserData(
                user: UserEntity(
                    id: state.shoppingListItem.userToBuyItem ?? "", authId: ""),
                privateEventUser: PrivateEventUserEntity(
                    id: state.shoppingListItem.userToBuyItem ?? ""),
              ),
            );

            return UserListTile(
              customTitle: userToBuyItem.getUsername(),
              user: userToBuyItem.user,
              items: [
                PopupMenuItem(
                  child: const Text("ändern"),
                  onTap: () {
                    BlocProvider.of<CurrentShoppingListItemCubit>(context)
                        .shoppingListCubitOrPrivateEventCubit
                        .fold(
                          (l) => AutoRouter.of(context).push(
                            const ShoppingListItemChangeUserPageRoute(),
                          ),
                          (r) => AutoRouter.of(context).push(
                            const PrivateEventShoppingListItemChangeUserPageRoute(),
                          ),
                        );
                  },
                )
              ],
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
  }
}
