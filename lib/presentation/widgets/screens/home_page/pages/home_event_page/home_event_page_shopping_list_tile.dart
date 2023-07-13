import 'package:auto_route/auto_route.dart';
import 'package:chattyevent_app_flutter/presentation/router/router.gr.dart';
import 'package:flutter/material.dart';

class HomeEventPageShoppingListTile extends StatelessWidget {
  const HomeEventPageShoppingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          AutoRouter.of(context).push(
            const ShoppingListWrapperRoute(
              children: [ShoppingListRoute()],
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.shopping_bag),
                const SizedBox(width: 16),
                Hero(
                  tag: "ShoppingListTitle",
                  child: Text(
                    "Einkaufsliste",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
