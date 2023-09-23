import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/event_page/create_shopping_list_item_page/create_shopping_list_item_page_select_user_list.dart';

class CreateShoppingListItemPageDetail extends StatelessWidget {
  const CreateShoppingListItemPageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddShoppingListItemCubit, AddShoppingListItemState>(
      buildWhen: (previous, current) =>
          previous.userToBuyItemEntity != current.userToBuyItemEntity,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText:
                        "eventPage.createShoppingListItemPage.fields.itemNameField.lable"
                            .tr(),
                  ),
                  controller: TextEditingController(
                    text: state.itemName,
                  ),
                  onChanged: (value) {
                    BlocProvider.of<AddShoppingListItemCubit>(context)
                        .emitState(
                      itemName: value,
                    );
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              "eventPage.createShoppingListItemPage.fields.amountField.lable"
                                  .tr(),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: TextEditingController(
                          text: state.amount != null
                              ? state.amount.toString()
                              : "",
                        ),
                        onChanged: (value) async {
                          final amountAsDouble = double.tryParse(
                            value,
                          );

                          if (amountAsDouble == null) {
                            return await showDialog(
                              context: context,
                              builder: (c) {
                                return CustomAlertDialog(
                                  notificationAlert: NotificationAlert(
                                    title:
                                        "general.amountIsntANumberAlert.title"
                                            .tr(),
                                    message:
                                        "general.amountIsntANumberAlert.message"
                                            .tr(),
                                  ),
                                  context: c,
                                );
                              },
                            );
                          }
                          BlocProvider.of<AddShoppingListItemCubit>(context)
                              .emitState(
                            amount: amountAsDouble,
                          );
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              "eventPage.createShoppingListItemPage.fields.unitField.lable"
                                  .tr(),
                        ),
                        controller: TextEditingController(
                          text: state.unit,
                        ),
                        onChanged: (value) {
                          BlocProvider.of<AddShoppingListItemCubit>(context)
                              .emitState(
                            unit: value,
                          );
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "eventPage.createShoppingListItemPage.userWhoShouldBuyTheItemText",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(args: [state.userToBuyItemEntity?.username ?? ""]),
                ],
              ),
              const SizedBox(height: 8.0),
              const CreateShoppingListItemPageSelectUserList(),
            ],
          ),
        );
      },
    );
  }
}
