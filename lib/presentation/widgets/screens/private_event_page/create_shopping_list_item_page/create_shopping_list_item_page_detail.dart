import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/add_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/screens/private_event_page/create_shopping_list_item_page/create_shopping_list_item_page_select_user_list.dart';

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
            children: [
              SizedBox(
                width: double.infinity,
                child: PlatformTextFormField(
                  controller: TextEditingController(
                    text: state.itemName,
                  ),
                  onChanged: (value) {
                    BlocProvider.of<AddShoppingListItemCubit>(context)
                        .emitState(
                      itemName: value,
                    );
                  },
                  hintText: "Item name",
                ),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: PlatformTextFormField(
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
                                    title: "Menge Fehler",
                                    message:
                                        "Die eingegebene Menge muss eine Zahl sein",
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
                        hintText: "Menge",
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      flex: 1,
                      child: PlatformTextFormField(
                        controller: TextEditingController(
                          text: state.unit,
                        ),
                        onChanged: (value) {
                          BlocProvider.of<AddShoppingListItemCubit>(context)
                              .emitState(
                            unit: value,
                          );
                        },
                        hintText: "Einheit",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    "User der das Item kauft: ${state.userToBuyItemEntity != null ? state.userToBuyItemEntity!.username : ''}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const CreateShoppingListItemPageSelectUserList(),
            ],
          ),
        );
      },
    );
  }
}
