import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';

class CurrentShoppingListItemPageWithProgressBar extends StatelessWidget {
  const CurrentShoppingListItemPageWithProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
      buildWhen: (previous, current) {
        if (previous.shoppingListItem.amount !=
            current.shoppingListItem.amount) {
          return true;
        }
        if (previous.boughtAmounts.length != current.boughtAmounts.length) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                stops: [
                  (state.shoppingListItem.boughtAmount ??
                          0 / state.shoppingListItem.amount!) -
                      0.02,
                  (state.shoppingListItem.boughtAmount ??
                          0 / state.shoppingListItem.amount!) +
                      0.02
                ],
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.surface,
                ],
              ),
            ),
            height: 100,
            width: double.infinity,
            child: Center(
              child: Text(
                "${state.shoppingListItem.boughtAmount ?? 0} von ${state.shoppingListItem.amount} gekauft",
                style: Theme.of(context).textTheme.labelLarge?.apply(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
