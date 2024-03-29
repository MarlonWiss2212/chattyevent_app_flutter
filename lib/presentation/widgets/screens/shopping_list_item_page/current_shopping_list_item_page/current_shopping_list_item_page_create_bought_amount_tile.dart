import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText:
                      "shoppingListPage.createBoughtAmount.newBoughtAmountText"
                          .tr(),
                ),
                controller: boughtAmountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: Button(
                text: "general.createText".tr(),
                onTap: () async {
                  double? boughtAmount =
                      double.tryParse(boughtAmountController.text);

                  if (boughtAmount == null) {
                    return await showDialog(
                      context: context,
                      builder: (c) {
                        return CustomAlertDialog(
                          notificationAlert: NotificationAlert(
                            title:
                                "shoppingListPage.createBoughtAmount.boughtAmountIsntANumberAlert.title"
                                    .tr(),
                            message:
                                "shoppingListPage.createBoughtAmount.boughtAmountIsntANumberAlert.message"
                                    .tr(),
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
          ],
        ),
      ),
    );
  }
}
