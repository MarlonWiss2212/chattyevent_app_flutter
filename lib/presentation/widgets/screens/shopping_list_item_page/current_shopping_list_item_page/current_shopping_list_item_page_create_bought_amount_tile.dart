import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/button.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';

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
      trailing: SizedBox(
        width: 100,
        child: Button(
          text: "Speichern",
          onTap: () async {
            double? boughtAmount = double.tryParse(boughtAmountController.text);

            if (boughtAmount == null) {
              return await showDialog(
                context: context,
                builder: (c) {
                  return CustomAlertDialog(
                    notificationAlert: NotificationAlert(
                      title: "Gekaufte Menge Fehler",
                      message:
                          "Die eingegebene gekaufte Menge muss eine Zahl sein",
                    ),
                    context: c,
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
      ),
    );
  }
}
