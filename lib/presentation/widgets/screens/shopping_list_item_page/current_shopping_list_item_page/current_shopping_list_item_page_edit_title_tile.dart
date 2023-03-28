import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/core/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:social_media_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

class CurrentShoppingListItemPageEditAmountTile extends StatefulWidget {
  const CurrentShoppingListItemPageEditAmountTile({super.key});

  @override
  State<CurrentShoppingListItemPageEditAmountTile> createState() =>
      _CurrentShoppingListItemPageEditAmountTileState();
}

class _CurrentShoppingListItemPageEditAmountTileState
    extends State<CurrentShoppingListItemPageEditAmountTile> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: PlatformTextField(
        hintText: "Menge",
        controller: amountController,
      ),
      trailing: PlatformElevatedButton(
        child: const Text("Speichern"),
        onPressed: () async {
          double? amount = double.tryParse(amountController.text);

          if (amount == null) {
            return await showDialog(
              context: context,
              builder: (c) {
                return CustomAlertDialog(
                  title: "Menge Fehler",
                  message: "Die eingegebene Menge muss eine Zahl sein",
                  context: c,
                );
              },
            );
          }

          BlocProvider.of<CurrentShoppingListItemCubit>(context)
              .updateShoppingListItemViaApi(
            updateShoppingListItemDto: UpdateShoppingListItemDto(
              amount: amount,
            ),
          );
        },
      ),
    );
  }
}
