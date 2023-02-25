import 'package:flutter/material.dart';
import 'package:social_media_app_flutter/domain/entities/private_event/user_with_private_event_user_data.dart';
import 'package:social_media_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';

class ShoppingListItemTile extends StatelessWidget {
  final UserWithPrivateEventUserData userToBuyItem;
  final ShoppingListItemEntity shoppingListItem;
  final void Function() onTap;
  const ShoppingListItemTile({
    super.key,
    required this.onTap,
    required this.shoppingListItem,
    required this.userToBuyItem,
  });

  @override
  Widget build(BuildContext context) {
    double boughtAmountCount = 0;
    if (shoppingListItem.boughtAmount != null) {
      for (final singleBoughtAmount in shoppingListItem.boughtAmount!) {
        if (singleBoughtAmount.boughtAmount != null) {
          boughtAmountCount += singleBoughtAmount.boughtAmount!;
        }
      }
    }

    return ListTile(
      title: Wrap(
        spacing: 8,
        children: [
          if (userToBuyItem.privateEventUser.status == "rejected" ||
              userToBuyItem.privateEventUser.status == "invited") ...{
            Badge(
              backgroundColor:
                  userToBuyItem.privateEventUser.status == "rejected"
                      ? Colors.red
                      : Colors.yellow,
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
        backgroundImage: userToBuyItem.user.profileImageLink != null
            ? NetworkImage(userToBuyItem.user.profileImageLink!)
            : null,
        backgroundColor: userToBuyItem.user.profileImageLink == null
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
      ),
      subtitle: Row(
        children: [
          Text(
            boughtAmountCount.toString(),
            style: Theme.of(context).textTheme.labelMedium,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
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
                    (boughtAmountCount / shoppingListItem.amount!) - 0.02,
                    (boughtAmountCount / shoppingListItem.amount!) + 0.02
                  ],
                  colors: [
                    Theme.of(context).colorScheme.onPrimary,
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${shoppingListItem.amount} ${shoppingListItem.unit}",
            style: Theme.of(context).textTheme.labelMedium,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
