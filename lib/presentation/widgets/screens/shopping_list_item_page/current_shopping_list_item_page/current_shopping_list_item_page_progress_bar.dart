import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class CurrentShoppingListItemPageWithProgressBar extends StatelessWidget {
  const CurrentShoppingListItemPageWithProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
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
              child: Wrap(
                children: [
                  Text(
                    "${state.shoppingListItem.boughtAmount ?? 0} von ",
                    style: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  EditInputTextField(
                    text: state.shoppingListItem.amount?.toString() ?? "0",
                    onSaved: (text) async {
                      final textAsDouble = double.tryParse(text);
                      if (textAsDouble == null) {
                        if (textAsDouble == null) {
                          return await showDialog(
                            context: context,
                            builder: (c) {
                              return CustomAlertDialog(
                                title: "Menge Fehler",
                                message:
                                    "Die eingegebene Menge muss eine Zahl sein",
                                context: c,
                              );
                            },
                          );
                        }
                      }
                      BlocProvider.of<CurrentShoppingListItemCubit>(context)
                          .updateShoppingListItemViaApi(
                        updateShoppingListItemDto: UpdateShoppingListItemDto(
                          amount: textAsDouble,
                        ),
                      );
                    },
                    textStyle: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  EditInputTextField(
                    text:
                        state.shoppingListItem.unit?.toString() ?? " (anzahl)",
                    onSaved: (text) async {
                      BlocProvider.of<CurrentShoppingListItemCubit>(context)
                          .updateShoppingListItemViaApi(
                        updateShoppingListItemDto: UpdateShoppingListItemDto(
                          unit: text,
                        ),
                      );
                    },
                    textStyle: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    " gekauft",
                    style: Theme.of(context).textTheme.labelLarge?.apply(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
