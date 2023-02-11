import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/application/bloc/private_event/current_private_event_cubit.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/private_event_user.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item_entity.dart';

class ShoppingListItemTile extends StatelessWidget {
  final CurrentPrivateEventState currentPrivateEventState;
  final ShoppingListItemEntity shoppingListItem;
  const ShoppingListItemTile({
    super.key,
    required this.currentPrivateEventState,
    required this.shoppingListItem,
  });

  @override
  Widget build(BuildContext context) {
    PrivateEventUser userToBuyItem =
        currentPrivateEventState.privateEventUsers.firstWhere(
      (element) => element.id == shoppingListItem.userToBuyItem,
    );

    return ListTile(
      isThreeLine: true,
      title: Wrap(
        spacing: 8,
        children: [
          if (userToBuyItem.declined || userToBuyItem.invited) ...{
            Badge(
              backgroundColor:
                  userToBuyItem.declined ? Colors.red : Colors.yellow,
            ),
          },
          Text(
            shoppingListItem.itemName ?? "Kein Name",
            style: Theme.of(context).textTheme.titleMedium,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: userToBuyItem.profileImageLink != null
            ? NetworkImage(userToBuyItem.profileImageLink!)
            : null,
        backgroundColor: userToBuyItem.profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      trailing: Text(
        "${shoppingListItem.amount} ${shoppingListItem.unit}",
        style: Theme.of(context).textTheme.titleMedium,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: shoppingListItem.amount != null &&
              shoppingListItem.boughtAmount != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userToBuyItem.username ?? "Kein Username",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                Row(
                  children: [
                    Text(
                      shoppingListItem.boughtAmount.toString(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          gradient: LinearGradient(
                            stops: [
                              (shoppingListItem.boughtAmount! /
                                  shoppingListItem.amount!),
                              (shoppingListItem.boughtAmount! /
                                  shoppingListItem.amount!)
                            ],
                            colors: [
                              Theme.of(context).colorScheme.onPrimary,
                              Theme.of(context).colorScheme.onBackground,
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      shoppingListItem.amount.toString(),
                    ),
                  ],
                ),
              ],
            )
          : null,
      onTap: () {},
    );
  }
}
