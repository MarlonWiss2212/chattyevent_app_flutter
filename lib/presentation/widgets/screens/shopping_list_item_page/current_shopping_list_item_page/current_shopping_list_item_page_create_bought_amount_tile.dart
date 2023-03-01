import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:social_media_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:social_media_app_flutter/presentation/widgets/dialog/buttons/ok_button.dart';

class CurrentShoppingListItemPageCreateBoughtAmountTile extends StatefulWidget {
  const CurrentShoppingListItemPageCreateBoughtAmountTile({super.key});

  @override
  State<CurrentShoppingListItemPageCreateBoughtAmountTile> createState() =>
      _CurrentShoppingListItemPageCreateBoughtAmountTileState();
}

class _CurrentShoppingListItemPageCreateBoughtAmountTileState
    extends State<CurrentShoppingListItemPageCreateBoughtAmountTile> {
  TextEditingController boughtAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Neu Eingekauft"),
      subtitle: PlatformTextField(
        hintText: "Menge",
        controller: boughtAmountController,
      ),
      trailing: PlatformElevatedButton(
        child: const Text("Speichern"),
        onPressed: () async {
          double? boughtAmount = double.tryParse(boughtAmountController.text);

          if (boughtAmount == null) {
            return await showPlatformDialog(
              context: context,
              builder: (context) {
                return PlatformAlertDialog(
                  title: const Text("Bought Amount Fehler"),
                  content: const Text("Bought Amount muss eine Zahl sein"),
                  actions: const [OKButton()],
                );
              },
            );
          }

          BlocProvider.of<CurrentShoppingListItemCubit>(context)
              .addBoughtAmount(
            boughtAmount: boughtAmount,
          );
        },
      ),
    );
  }
}
