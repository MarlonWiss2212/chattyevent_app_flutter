import 'package:chattyevent_app_flutter/application/bloc/current_event/current_event_cubit.dart';
import 'package:chattyevent_app_flutter/application/bloc/notification/notification_cubit.dart';
import 'package:chattyevent_app_flutter/domain/entities/bought_amount_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattyevent_app_flutter/application/bloc/shopping_list/current_shopping_list_item_cubit.dart';
import 'package:chattyevent_app_flutter/infrastructure/dto/shopping_list_item/update_shopping_list_item_dto.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/dialog/alert_dialog.dart';
import 'package:chattyevent_app_flutter/presentation/widgets/general/input_fields/edit_input_text_field.dart';

class CurrentShoppingListItemPageWithProgressBar extends StatelessWidget {
  const CurrentShoppingListItemPageWithProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentShoppingListItemCubit,
        CurrentShoppingListItemState>(
      builder: (context, state) {
        double boughtAmount = 0;
        for (BoughtAmountEntity b
            in state.shoppingListItem.boughtAmounts ?? []) {
          boughtAmount += b.boughtAmount ?? 0;
        }
        final gradientWidth =
            (boughtAmount / (state.shoppingListItem.amount ?? 0.0));
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
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
            height: 100,
            width: double.infinity,
            child: Center(
              child: BlocBuilder<CurrentEventCubit, CurrentEventState>(
                builder: (context, privateEventState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$boughtAmount / ",
                        style: Theme.of(context).textTheme.labelLarge?.apply(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: EditInputTextField(
                          text:
                              state.shoppingListItem.amount?.toString() ?? "0",
                          onSaved: privateEventState
                                  .currentUserAllowedWithPermission(
                                      permissionCheckValue: privateEventState
                                          .event
                                          .permissions
                                          ?.updateShoppingListItem)
                              ? (text) async {
                                  final textAsDouble = double.tryParse(text);
                                  if (textAsDouble == null) {
                                    if (textAsDouble == null) {
                                      return await showDialog(
                                        context: context,
                                        builder: (c) {
                                          return CustomAlertDialog(
                                            notificationAlert:
                                                NotificationAlert(
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
                                  }
                                  BlocProvider.of<CurrentShoppingListItemCubit>(
                                          context)
                                      .updateShoppingListItemViaApi(
                                    updateShoppingListItemDto:
                                        UpdateShoppingListItemDto(
                                      amount: textAsDouble,
                                    ),
                                  );
                                }
                              : null,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 100),
                        child: EditInputTextField(
                          text: state.shoppingListItem.unit == null ||
                                  state.shoppingListItem.unit!.isEmpty
                              ? "general.unitText".tr()
                              : state.shoppingListItem.unit!,
                          onSaved: privateEventState
                                  .currentUserAllowedWithPermission(
                                      permissionCheckValue: privateEventState
                                          .event
                                          .permissions
                                          ?.updateShoppingListItem)
                              ? (text) async {
                                  BlocProvider.of<CurrentShoppingListItemCubit>(
                                          context)
                                      .updateShoppingListItemViaApi(
                                    updateShoppingListItemDto:
                                        UpdateShoppingListItemDto(
                                      unit: text,
                                    ),
                                  );
                                }
                              : null,
                          textStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.apply(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      Text(
                        "shoppingListPage.boughtText".tr(),
                        style: Theme.of(context).textTheme.labelLarge?.apply(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
