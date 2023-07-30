import 'package:chattyevent_app_flutter/core/enums/event/event_user/event_user_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:chattyevent_app_flutter/domain/entities/event/event_user_entity.dart';
import 'package:chattyevent_app_flutter/domain/entities/shopping_list_item/shopping_list_item_entity.dart';

class ShoppingListItemTile extends StatelessWidget {
  final EventUserEntity userToBuyItem;
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
    final gradientWidth =
        ((shoppingListItem.boughtAmount ?? 0) / shoppingListItem.amount!);
    return ListTile(
      title: Wrap(
        spacing: 8,
        children: [
          if (userToBuyItem.status == EventUserStatusEnum.rejected ||
              userToBuyItem.status == EventUserStatusEnum.invited) ...{
            Badge(
              backgroundColor:
                  userToBuyItem.status == EventUserStatusEnum.invited
                      ? Colors.yellow
                      : Colors.red,
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
            ? Theme.of(context).colorScheme.surface
            : null,
      ),
      subtitle: Row(
        children: [
          Text(
            shoppingListItem.boughtAmount?.toString() ?? "0",
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
                    gradientWidth - 0.02,
                    gradientWidth + 0.02,
                  ],
                  colors: [
                    Theme.of(context).colorScheme.onPrimary,
                    Theme.of(context).colorScheme.surface,
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
